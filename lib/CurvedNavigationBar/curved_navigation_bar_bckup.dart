import 'package:flutter/material.dart';

typedef LetIndexPage = bool Function(int value);

const Gradient defaultGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.white,
    Colors.grey,
    Colors.green,
    Colors.grey,
    Colors.white,
  ],
  stops: [0.1, 0.3, 0.5, 0.7, 1.0],
);

Shader defaultGradientShader = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.red,
    Colors.blue,
  ],
  stops: [0.1, 0.3, 0.5, 0.7, 1.0],
).createShader(Rect.fromCenter(center: const Offset(0.0,0.0), height: 200, width: 100));


class CurvedNavigationBar extends StatefulWidget {
  final List<Widget> icons;
  final List<RichText> titles;
  final int currentIndex;
  final Color navBarColor;
  final Color backgroundColor;
  final ValueChanged<int>? onTap;
  final LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double navBarHeight;
  final double navBarWidth;
  final Shader? foreGroundGradient;
  final bool useForeGroundGradient;
  final double? strokeBorderWidth;
  final Color strokeBorderColor;
  final Gradient strokeGradient;
  final Shader? strokeGradientShader;
  final bool useShaderStroke;
  final bool showForeGround;
  final bool underCurve;
  final bool staticCurve;
  final double selectedButtonBottomPosition;
  final double selectedButtonTopPosition;
  final double selectedButtonElevation;
  final Color selectedButtonColor;
  final MaterialType selectedButtonMaterialType;
  final Widget? customSelectedButtonWidget;
  final Color backgroundStrokeBorderColor;
  final double backgroundStrokeBorderWidth;
  final BorderStyle backgroundStrokeBorderStyle;
  
  CurvedNavigationBar({
    Key? key,
    required this.icons,
    required this.titles,
    this.onTap,
    this.animationCurve = Curves.easeOut,
    LetIndexPage? letIndexChange,
    this.navBarColor = Colors.white,
    this.backgroundColor = Colors.amber,
    this.strokeBorderColor = Colors.white,
    this.strokeGradient = defaultGradient,
    this.strokeGradientShader,
    this.strokeBorderWidth=0,
    this.currentIndex=0,
    this.animationDuration = const Duration(milliseconds: 500),
    this.navBarHeight = kBottomNavigationBarHeight,
    this.navBarWidth=double.infinity,
    this.foreGroundGradient,
    this.useForeGroundGradient=false,
    this.showForeGround=true,
    this.useShaderStroke=false,
    this.underCurve=true,
    this.staticCurve=false,
    this.selectedButtonBottomPosition=0.0,
    this.selectedButtonTopPosition=0.0,
    this.selectedButtonElevation=0,
    this.selectedButtonColor=Colors.blue,
    this.selectedButtonMaterialType = MaterialType.circle,
    this.customSelectedButtonWidget,
    this.backgroundStrokeBorderColor=Colors.black,
    this.backgroundStrokeBorderWidth=2.0,
    this.backgroundStrokeBorderStyle=BorderStyle.solid,
  })  
  : letIndexChange = letIndexChange ?? ((_) => true),
    assert(icons.isNotEmpty),
    assert(0 <= currentIndex && currentIndex < icons.length),
    assert(0 <= navBarHeight && navBarHeight <= 75.0),
    super(key: key);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar> with TickerProviderStateMixin {
  late double _startingPos;
  int _endingIndex = 0;
  late double _pos;
  late Widget icon;
  late AnimationController _animationController;
  late int _length;

  @override
  void initState() {
    super.initState();
    icon = widget.icons[widget.currentIndex];
    _length = widget.icons.length;
    _pos = widget.currentIndex / _length;
    _startingPos = widget.currentIndex / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.icons.length;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          icon = widget.icons[_endingIndex];
        }
      });
    });
  }

  @override
  void didUpdateWidget (CurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      final newPosition = widget.currentIndex / _length;
      _startingPos = _pos;
      _endingIndex = widget.currentIndex;
      _animationController.animateTo(
        newPosition,
        duration: widget.animationDuration, 
        curve: widget.animationCurve
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var navBarW = widget.navBarWidth;
    var navBarH = widget.navBarHeight;
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border(
          top: BorderSide(
            color : widget.backgroundStrokeBorderColor,
            width : widget.backgroundStrokeBorderWidth,
            style : widget.backgroundStrokeBorderStyle,
            strokeAlign: BorderSide.strokeAlignInside
          ),
        )
      ),
      height: widget.navBarHeight,
      width: navBarW,
      padding: EdgeInsets.zero,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // Nav ForeGround With Curve
          widget.showForeGround
          ?Positioned(
            left: 0,
            right: 0,
            bottom: 0 - (75.0 - navBarH),
            child: widget.staticCurve
            ?staticCurve(context)
            :dynamicCurve(context),
          )
          :const SizedBox(),
          // Icons
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: SizedBox(
              height: 100.0,
              child: Row(
                children: widget.icons.map((item) {
                return NavButton(
                  onTap: _buttonTap,
                  position: _pos,
                  length: _length,
                  index: widget.icons.indexOf(item),
                  title: widget.titles[widget.icons.indexOf(item)],
                  child: Center(child: item),
                );
              }).toList())
            ),
          ),
          // Selected Button
          widget.staticCurve
          ?const SizedBox()
          :selectedButton(navBarW, context),
        ],
      ),
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (!widget.letIndexChange(index)) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(
        newPosition,
        duration: widget.animationDuration, 
        curve: widget.animationCurve
      );
    });
  }

  Positioned selectedButton(double navBarW, BuildContext context) {
    return Positioned(
      top: widget.selectedButtonTopPosition,
      bottom: widget.selectedButtonBottomPosition,
      width: navBarW/_length,
      left: Directionality.of(context) == TextDirection.rtl
      ? null
      : _pos * navBarW,
      right: Directionality.of(context) == TextDirection.rtl
      ? _pos * navBarW
      : null,
      child: widget.customSelectedButtonWidget??Center(
        child: Material(
          elevation: widget.selectedButtonElevation,
          surfaceTintColor: widget.selectedButtonColor,
          color: widget.selectedButtonColor,
          type: widget.selectedButtonMaterialType,
          borderOnForeground: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
        ),
      )
    );
  }
  
  CustomPaint dynamicCurve(BuildContext context) {
    return CustomPaint(
      painter: widget.underCurve
      ?NavForeGroundCurvePainterUnder(
        _pos, 
        _length, 
        widget.useForeGroundGradient,
        widget.foreGroundGradient,
        widget.navBarColor, 
        Directionality.of(context)
      )
      :NavForeGroundCurvePainterUpper(
        _pos, 
        _length, 
        widget.useForeGroundGradient,
        widget.foreGroundGradient,
        widget.navBarColor, 
        Directionality.of(context)
      ),
      foregroundPainter: widget.strokeBorderWidth!=0 
      ?widget.underCurve
      ?NavForeGroundUnderStrokeBorderPainter(
        _pos, 
        _length, 
        widget.strokeBorderColor, 
        Directionality.of(context),
        widget.strokeBorderWidth??1,
        widget.strokeGradientShader,
        widget.useShaderStroke
      )
      :NavForeGroundUpperStrokeBorderPainter(
        _pos, 
        _length, 
        widget.strokeBorderColor, 
        Directionality.of(context),
        widget.strokeBorderWidth??1,
        widget.strokeGradientShader,
        widget.useShaderStroke
      )
      :null,
      child: Container(
        height: 75.0,
      ),
    );
  }

  CustomPaint staticCurve(BuildContext context){
    return CustomPaint(
      painter: widget.underCurve
      ?NavForeGroundCurvePainterUnderStatic(
        _pos, 
        _length, 
        widget.useForeGroundGradient,
        widget.foreGroundGradient,
        widget.navBarColor, 
        Directionality.of(context)
      )
      :NavForeGroundCurvePainterUpperStatic(
        _pos, 
        _length, 
        widget.useForeGroundGradient,
        widget.foreGroundGradient,
        widget.navBarColor, 
        Directionality.of(context)
      ),
      foregroundPainter: widget.strokeBorderWidth!=0 
      ?widget.underCurve
      ?NavForeGroundUnderStrokeBorderPainterStatic(
        _pos, 
        _length, 
        widget.strokeBorderColor, 
        Directionality.of(context),
        widget.strokeBorderWidth??1,
        widget.strokeGradientShader,
        widget.useShaderStroke
      )
      :NavForeGroundUpperStrokeBorderPainterStatic(
        _pos, 
        _length, 
        widget.strokeBorderColor, 
        Directionality.of(context),
        widget.strokeBorderWidth??1,
        widget.strokeGradientShader,
        widget.useShaderStroke
      )
      :null,
      child: Container(
        height: 75.0,
      ),
    );
  } 
}

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;
  final RichText title;

  const NavButton({super.key, 
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          height: 75.0,
          child: Transform.translate(
            offset: Offset(
              0, 
              difference < 1.0 / length ? verticalAlignment * 40 : 0
            ),
            child: Opacity(
              opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child,
                  title.text.toPlainText() == "" ? const SizedBox() : title
                ],
              )
            ),
          )
        ),
      ),
    );
  }
}

//=========================== Bottom Curve ===========================//

//Navigation Background with Under Curve
//Control Curves here
class NavForeGroundCurvePainterUnder extends CustomPainter {
  late double loc; // Represents the starting location of the curve
  late double s; // Represents the size of the curve
  late bool useForeGroundGradient; // Indicates whether to use a gradient for the foreground
  late Shader? foreGroundGradientShader; // Shader for the foreground gradient
  Color color; // Color used if not using the gradient
  TextDirection textDirection; // Direction of the text

  NavForeGroundCurvePainterUnder(
    double startingLoc, 
    int itemsLength, 
    this.useForeGroundGradient,
    this.foreGroundGradientShader,
    this.color, 
    this.textDirection
  ) 
  {
    final span = 1.0 / itemsLength;
    s = 0.18;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color // Sets the desired color
      ..style = PaintingStyle.fill; // Sets the painting style to fill

    if (!useForeGroundGradient) {
      paint.color = color; // Set the desired color for the foreground
    } else {
      paint.shader = foreGroundGradientShader ?? defaultGradientShader; // Set the desired shader for the foreground
    }

    final path = Path()
      ..moveTo(0, 0) // Moves to the top-left corner
      ..lineTo((loc - 0.02) * size.width, 0) // Draws a line from the previous point to the left side of the curve
      ..cubicTo(
        (loc + s * 0.20) * size.width, // First control point for the curve
        size.height * 0.05, // Second control point for the curve
        loc * size.width, // Ending point of the curve
        size.height * 0.60, // Ending control point of the curve
        (loc + s * 0.50) * size.width, // Starting control point of the next curve
        size.height * 0.60, // Ending control point of the next curve
      )
      ..cubicTo(
        (loc + s) * size.width, // First control point for the next curve
        size.height * 0.60, // Second control point for the next curve
        (loc + s - s * 0.20) * size.width, // Ending point of the next curve
        size.height * 0.05, // Ending control point of the next curve
        (loc + s + 0.02) * size.width, // Starting point of the next curve
        0, // Draws a line from the previous point to the right side of the curve
      )
      ..lineTo(size.width, 0) // Draws a line from the last point to the top-right corner
      ..lineTo(size.width, size.height) // Draws a line from the previous point to the bottom-right corner
      ..lineTo(0, size.height) // Draws a line from the previous point to the bottom-left corner
      ..close(); // Closes the path

    canvas.drawPath(path, paint); // Draws the path on the canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

//=========================== Bottom Curve Stroke ===========================//

//Under Curve
//Custom Stroke painter for bottom nav with gradient or a solid color
//Control Curves here 
//This is a line/Stroke above Bottom Navigation 
class NavForeGroundUnderStrokeBorderPainter extends CustomPainter {
  late double loc; // Represents the starting location of the curve
  late double s; // Represents the size of the curve
  late double strokeBorderWidth; // Width of the stroke border
  late bool useShaderStroke; // Indicates whether to use a shader for the stroke
  Color color; // Color used if not using the shader
  Shader? strokeGradientShader; // Shader for the stroke gradient
  TextDirection textDirection; // Direction of the text

  NavForeGroundUnderStrokeBorderPainter(
    double startingLoc, 
    int itemsLength, 
    this.color, 
    this.textDirection,
    this.strokeBorderWidth,
    this.strokeGradientShader,
    this.useShaderStroke,
  ) 
  {
    final span = 1.0 / itemsLength;
    s = 0.18;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeBorderWidth // Sets the width of the stroke border
      ..style = PaintingStyle.stroke; // Sets the painting style to stroke

    if (!useShaderStroke) {
      paint.color = color; // Set the desired color for the stroke
    } else {
      paint.shader = strokeGradientShader ?? defaultGradientShader; // Set the desired shader for the stroke
    }

    final path = Path()
      ..moveTo(-size.height, 0) // Moves to the top-left corner of the path
      ..lineTo((loc - 0.02) * size.width, 0) // Draws a line from the previous point to the left side of the curve
      ..cubicTo(
        (loc + s * 0.20) * size.width, // First control point for the curve
        size.height * 0.05, // Second control point for the curve
        loc * size.width, // Ending point of the curve
        size.height * 0.60, // Ending control point of the curve
        (loc + s * 0.50) * size.width, // Starting control point of the next curve
        size.height * 0.60, // Ending control point of the next curve
      )
      ..cubicTo(
        (loc + s) * size.width, // First control point for the next curve
        size.height * 0.60, // Second control point for the next curve
        (loc + s - s * 0.20) * size.width, // Ending point of the next curve
        size.height * 0.05, // Ending control point of the next curve
        (loc + s + 0.02) * size.width, // Starting point of the next curve
        0, // Draws a line from the previous point to the right side of the curve
      )
      ..lineTo(size.width, 0) // Draws a line from the last point to the top-right corner
      ..moveTo(0, size.width) // Moves to the bottom-left corner of the path
      ..close(); // Closes the path

    canvas.drawPath(path, paint); // Draws the path on the canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

//=========================== Upper Curve ===========================//

//Navigation Background with Upper Curve
//Control Curves here
class NavForeGroundCurvePainterUpper extends CustomPainter {
  late double loc; // Represents the starting location of the curve
  late double s; // Represents the size of the curve
  late bool useForeGroundGradient; // Indicates whether to use a foreground gradient
  late Shader? foreGroundGradientShader; // Shader for the foreground gradient
  Color color; // Color used if not using the foreground gradient
  TextDirection textDirection; // Direction of the text

  NavForeGroundCurvePainterUpper(
    double startingLoc, 
    int itemsLength, 
    this.useForeGroundGradient,
    this.foreGroundGradientShader,
    this.color, 
    this.textDirection
  ) 
  {
    final span = 1.0 / itemsLength;
    s = 0.16;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    if (!useForeGroundGradient) {
      paint.color = color; 
    } else {
      paint.shader = foreGroundGradientShader ?? defaultGradientShader;
    }

    final path = Path()
      ..moveTo(0, 0) // Moves to the starting point of the path
      ..lineTo(size.width, 0) // Draws a line from the starting point to the top-right corner
      ..lineTo(size.width, size.height) // Draws a line from the top-right corner to the bottom-right corner
      ..lineTo(0, size.height) // Draws a line from the bottom-right corner to the bottom-left corner
      ..moveTo(-size.height, 0) // Moves to a point outside the canvas on the left side
      ..lineTo((loc - 0.03) * size.width, 0) // Draws a line from the previous point to the left side of the curve
      ..cubicTo(
        (loc + s * 0.20) * size.width, // First control point for the curve
        -size.height * 0.02, // Second control point for the curve
        loc * size.width, // Ending point of the curve
        -size.height * 0.30, // Ending control point of the curve
        (loc + s * 0.50) * size.width, // Starting control point of the next curve
        -size.height * 0.30, // Ending control point of the next curve
      )
      ..cubicTo(
        (loc + s) * size.width, // First control point for the next curve
        -size.height * 0.30, // Second control point for the next curve
        (loc + s - s * 0.20) * size.width, // Ending point of the next curve
        -size.height * 0.02, // Ending control point of the next curve
        (loc + s + 0.03) * size.width, // Starting point of the next curve
        0, // Draws a line from the previous point to the right side of the curve
      )
      ..lineTo(size.width, 0) // Draws a line from the last point to the top-right corner
      ..moveTo(0, size.height) // Moves to the bottom-left corner
      ..close(); // Closes the path

    canvas.drawPath(path, paint); // Draws the path on the canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

//=========================== Upper Curve Stroke ===========================//
//Upper Curve
//Custom Stroke painter for bottom nav with gradient or a solid color
//Control Curves here 
//This is a line/Stroke above Bottom Navigation 
class NavForeGroundUpperStrokeBorderPainter extends CustomPainter {
  late double loc; // Represents the starting location of the curve
  late double s; // Represents the size of the curve
  late double strokeBorderWidth; // Width of the stroke border
  late bool useShaderStroke; // Indicates whether to use a shader for the stroke
  Color color; // Color used if not using the shader for stroke
  Shader? strokeGradientShader; // Shader for the stroke gradient
  TextDirection textDirection; // Direction of the text

  NavForeGroundUpperStrokeBorderPainter(
    double startingLoc, 
    int itemsLength, 
    this.color, 
    this.textDirection,
    this.strokeBorderWidth,
    this.strokeGradientShader,
    this.useShaderStroke,
  ) 
  {
    final span = 1.0 / itemsLength;
    s = 0.16;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeBorderWidth // Sets the width of the stroke border
      ..style = PaintingStyle.stroke; // Sets the painting style to stroke (outline)
      
    if (!useShaderStroke) {
      paint.color = color; // Set the desired color for the stroke
    } else {
      paint.shader = strokeGradientShader ?? defaultGradientShader; // Set the desired shader for the stroke
    }

    final path = Path()
      ..moveTo(-size.height, 0) // Moves to a point outside the canvas on the left side
      ..lineTo((loc - 0.03) * size.width, 0) // Draws a line from the previous point to the left side of the curve
      ..cubicTo(
        (loc + s * 0.20) * size.width, // First control point for the curve
        -size.height * 0.02, // Second control point for the curve
        loc * size.width, // Ending point of the curve
        -size.height * 0.30, // Ending control point of the curve
        (loc + s * 0.50) * size.width, // Starting control point of the next curve
        -size.height * 0.30, // Ending control point of the next curve
      )
      ..cubicTo(
        (loc + s) * size.width, // First control point for the next curve
        -size.height * 0.30, // Second control point for the next curve
        (loc + s - s * 0.20) * size.width, // Ending point of the next curve
        -size.height * 0.02, // Ending control point of the next curve
        (loc + s + 0.03) * size.width, // Starting point of the next curve
        0, // Draws a line from the previous point to the right side of the curve
      )
      ..lineTo(size.width, 0) // Draws a line from the last point to the top-right corner
      ..moveTo(0, size.width) // Moves to the bottom-left corner
      ..close(); // Closes the path

    canvas.drawPath(path, paint); // Draws the path on the canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}


//=========================== Static Curve ===========================//

//=========================== Static Bottom Curve ===========================//

//Navigation Background with Under Curve
//Control Curves here
class NavForeGroundCurvePainterUnderStatic extends CustomPainter {
  late double loc; // Represents the starting location of the curve
  late double s; // Represents the size of the curve
  late bool useForeGroundGradient; // Indicates whether to use a gradient for the foreground
  late Shader? foreGroundGradientShader; // Shader for the foreground gradient
  Color color; // Color used if not using the gradient
  TextDirection textDirection; // Direction of the text

  NavForeGroundCurvePainterUnderStatic(
    double startingLoc, 
    int itemsLength, 
    this.useForeGroundGradient,
    this.foreGroundGradientShader,
    this.color, 
    this.textDirection
  ) 
  {
    s = 0.18;
    final span = 1.0 / itemsLength;
    loc = span * (itemsLength ~/ 2) + (span - s) / 2;
    if (textDirection == TextDirection.rtl) {
      loc = 1.0 - (loc + s);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color // Sets the desired color
      ..style = PaintingStyle.fill; // Sets the painting style to fill

    if (!useForeGroundGradient) {
      paint.color = color; // Set the desired color for the foreground
    } else {
      paint.shader = foreGroundGradientShader ?? defaultGradientShader; // Set the desired shader for the foreground
    }

    final path = Path()
      ..moveTo(0, 0) // Moves to the top-left corner
      ..lineTo((loc - 0.02) * size.width, 0) // Draws a line from the previous point to the left side of the curve
      ..cubicTo(
        (loc + s * 0.20) * size.width, // First control point for the curve
        size.height * 0.05, // Second control point for the curve
        loc * size.width, // Ending point of the curve
        size.height * 0.60, // Ending control point of the curve
        (loc + s * 0.50) * size.width, // Starting control point of the next curve
        size.height * 0.60, // Ending control point of the next curve
      )
      ..cubicTo(
        (loc + s) * size.width, // First control point for the next curve
        size.height * 0.60, // Second control point for the next curve
        (loc + s - s * 0.20) * size.width, // Ending point of the next curve
        size.height * 0.05, // Ending control point of the next curve
        (loc + s + 0.02) * size.width, // Starting point of the next curve
        0, // Draws a line from the previous point to the right side of the curve
      )
      ..lineTo(size.width, 0) // Draws a line from the last point to the top-right corner
      ..lineTo(size.width, size.height) // Draws a line from the previous point to the bottom-right corner
      ..lineTo(0, size.height) // Draws a line from the previous point to the bottom-left corner
      ..close(); // Closes the path

    canvas.drawPath(path, paint); // Draws the path on the canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

//=========================== Static Bottom Curve Stroke ===========================//

//Under Curve
//Custom Stroke painter for bottom nav with gradient or a solid color
//Control Curves here 
//This is a line/Stroke above Bottom Navigation 
class NavForeGroundUnderStrokeBorderPainterStatic extends CustomPainter {
  late double loc; // Represents the starting location of the curve
  late double s; // Represents the size of the curve
  late double strokeBorderWidth; // Width of the stroke border
  late bool useShaderStroke; // Indicates whether to use a shader for the stroke
  Color color; // Color used if not using the shader
  Shader? strokeGradientShader; // Shader for the stroke gradient
  TextDirection textDirection; // Direction of the text

  NavForeGroundUnderStrokeBorderPainterStatic(
    double startingLoc, 
    int itemsLength, 
    this.color, 
    this.textDirection,
    this.strokeBorderWidth,
    this.strokeGradientShader,
    this.useShaderStroke,
  ) 
  {
    s = 0.18;
    final span = 1.0 / itemsLength;
    loc = span * (itemsLength ~/ 2) + (span - s) / 2;
    if (textDirection == TextDirection.rtl) {
      loc = 1.0 - (loc + s);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeBorderWidth // Sets the width of the stroke border
      ..style = PaintingStyle.stroke; // Sets the painting style to stroke

    if (!useShaderStroke) {
      paint.color = color; // Set the desired color for the stroke
    } else {
      paint.shader = strokeGradientShader ?? defaultGradientShader; // Set the desired shader for the stroke
    }

    final path = Path()
      ..moveTo(-size.height, 0) // Moves to the top-left corner of the path
      ..lineTo((loc - 0.02) * size.width, 0) // Draws a line from the previous point to the left side of the curve
      ..cubicTo(
        (loc + s * 0.20) * size.width, // First control point for the curve
        size.height * 0.05, // Second control point for the curve
        loc * size.width, // Ending point of the curve
        size.height * 0.60, // Ending control point of the curve
        (loc + s * 0.50) * size.width, // Starting control point of the next curve
        size.height * 0.60, // Ending control point of the next curve
      )
      ..cubicTo(
        (loc + s) * size.width, // First control point for the next curve
        size.height * 0.60, // Second control point for the next curve
        (loc + s - s * 0.20) * size.width, // Ending point of the next curve
        size.height * 0.05, // Ending control point of the next curve
        (loc + s + 0.02) * size.width, // Starting point of the next curve
        0, // Draws a line from the previous point to the right side of the curve
      )
      ..lineTo(size.width, 0) // Draws a line from the last point to the top-right corner
      ..moveTo(0, size.width) // Moves to the bottom-left corner of the path
      ..close(); // Closes the path

    canvas.drawPath(path, paint); // Draws the path on the canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

//=========================== Static Upper Curve ===========================//

//Navigation Background with Upper Curve
//Control Curves here
class NavForeGroundCurvePainterUpperStatic extends CustomPainter {
  late double loc; // Represents the starting location of the curve
  late double s; // Represents the size of the curve
  late bool useForeGroundGradient; // Indicates whether to use a foreground gradient
  late Shader? foreGroundGradientShader; // Shader for the foreground gradient
  Color color; // Color used if not using the foreground gradient
  TextDirection textDirection; // Direction of the text

  NavForeGroundCurvePainterUpperStatic(
    double startingLoc, 
    int itemsLength, 
    this.useForeGroundGradient,
    this.foreGroundGradientShader,
    this.color, 
    this.textDirection
  ) 
  {
    s = 0.18;
    final span = 1.0 / itemsLength;
    loc = span * (itemsLength ~/ 2) + (span - s) / 2;
    if (textDirection == TextDirection.rtl) {
      loc = 1.0 - (loc + s);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    if (!useForeGroundGradient) {
      paint.color = color; 
    } else {
      paint.shader = foreGroundGradientShader ?? defaultGradientShader;
    }

    final path = Path()
      ..moveTo(0, 0) // Moves to the starting point of the path
      ..lineTo(size.width, 0) // Draws a line from the starting point to the top-right corner
      ..lineTo(size.width, size.height) // Draws a line from the top-right corner to the bottom-right corner
      ..lineTo(0, size.height) // Draws a line from the bottom-right corner to the bottom-left corner
      ..moveTo(-size.height, 0) // Moves to a point outside the canvas on the left side
      ..lineTo((loc - 0.03) * size.width, 0) // Draws a line from the previous point to the left side of the curve
      ..cubicTo(
        (loc + s * 0.20) * size.width, // First control point for the curve
        -size.height * 0.02, // Second control point for the curve
        loc * size.width, // Ending point of the curve
        -size.height * 0.30, // Ending control point of the curve
        (loc + s * 0.50) * size.width, // Starting control point of the next curve
        -size.height * 0.30, // Ending control point of the next curve
      )
      ..cubicTo(
        (loc + s) * size.width, // First control point for the next curve
        -size.height * 0.30, // Second control point for the next curve
        (loc + s - s * 0.20) * size.width, // Ending point of the next curve
        -size.height * 0.02, // Ending control point of the next curve
        (loc + s + 0.03) * size.width, // Starting point of the next curve
        0, // Draws a line from the previous point to the right side of the curve
      )
      ..lineTo(size.width, 0) // Draws a line from the last point to the top-right corner
      ..moveTo(0, size.height) // Moves to the bottom-left corner
      ..close(); // Closes the path

    canvas.drawPath(path, paint); // Draws the path on the canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

//=========================== Static Upper Curve Stroke ===========================//
//Upper Curve
//Custom Stroke painter for bottom nav with gradient or a solid color
//Control Curves here 
//This is a line/Stroke above Bottom Navigation 
class NavForeGroundUpperStrokeBorderPainterStatic extends CustomPainter {
  late double loc; // Represents the starting location of the curve
  late double s; // Represents the size of the curve
  late double strokeBorderWidth; // Width of the stroke border
  late bool useShaderStroke; // Indicates whether to use a shader for the stroke
  Color color; // Color used if not using the shader for stroke
  Shader? strokeGradientShader; // Shader for the stroke gradient
  TextDirection textDirection; // Direction of the text

  NavForeGroundUpperStrokeBorderPainterStatic(
    double startingLoc, 
    int itemsLength, 
    this.color, 
    this.textDirection,
    this.strokeBorderWidth,
    this.strokeGradientShader,
    this.useShaderStroke,
  ) 
  {
    s = 0.18;
    final span = 1.0 / itemsLength;
    loc = span * (itemsLength ~/ 2) + (span - s) / 2;
    if (textDirection == TextDirection.rtl) {
      loc = 1.0 - (loc + s);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeBorderWidth // Sets the width of the stroke border
      ..style = PaintingStyle.stroke; // Sets the painting style to stroke (outline)
      
    if (!useShaderStroke) {
      paint.color = color; // Set the desired color for the stroke
    } else {
      paint.shader = strokeGradientShader ?? defaultGradientShader; // Set the desired shader for the stroke
    }

    final path = Path()
      ..moveTo(-size.height, 0) // Moves to a point outside the canvas on the left side
      ..lineTo((loc - 0.03) * size.width, 0) // Draws a line from the previous point to the left side of the curve
      ..cubicTo(
        (loc + s * 0.20) * size.width, // First control point for the curve
        -size.height * 0.02, // Second control point for the curve
        loc * size.width, // Ending point of the curve
        -size.height * 0.30, // Ending control point of the curve
        (loc + s * 0.50) * size.width, // Starting control point of the next curve
        -size.height * 0.30, // Ending control point of the next curve
      )
      ..cubicTo(
        (loc + s) * size.width, // First control point for the next curve
        -size.height * 0.30, // Second control point for the next curve
        (loc + s - s * 0.20) * size.width, // Ending point of the next curve
        -size.height * 0.02, // Ending control point of the next curve
        (loc + s + 0.03) * size.width, // Starting point of the next curve
        0, // Draws a line from the previous point to the right side of the curve
      )
      ..lineTo(size.width, 0) // Draws a line from the last point to the top-right corner
      ..moveTo(0, size.width) // Moves to the bottom-left corner
      ..close(); // Closes the path

    canvas.drawPath(path, paint); // Draws the path on the canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}




