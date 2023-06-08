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
      Colors.white,
      Colors.grey,
      Colors.green,
      Colors.grey,
      Colors.white,
    ],
    stops: [0.1, 0.3, 0.5, 0.7, 1.0],
  ).createShader(Rect.fromCenter(center: const Offset(0.0,0.0), height: 200, width: 100));


class CurvedNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int currentIndex;
  final Color navBarColor;
  final Color backgroundColor;
  final ValueChanged<int>? onTap;
  final LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double navBarHeight;
  final double navBarWidth;
  final double? strokeBorderWidth;
  final Color strokeBorderColor;
  final Gradient strokeGradient;
  final Shader? strokeGradientShader;
  final bool useShaderStroke;
  final bool showForeGround;
  final double selectedButtonHeight;
  final double selectedButtonElevation;
  final Color selectedButtonColor;
  final MaterialType selectedButtonMaterialType;
  final Widget? customSelectedButtonWidget;
  final Color backgroundStrokeBorderColor;
  final double backgroundStrokeBorderWidth;
  final BorderStyle backgroundStrokeBorderStyle;
  
  CurvedNavigationBar({
    Key? key,
    required this.items,
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
    this.showForeGround=true,
    this.useShaderStroke=false,
    this.selectedButtonHeight=18.0,
    this.selectedButtonElevation=0,
    this.selectedButtonColor=Colors.blue,
    this.selectedButtonMaterialType = MaterialType.circle,
    this.customSelectedButtonWidget,
    this.backgroundStrokeBorderColor=Colors.black,
    this.backgroundStrokeBorderWidth=2.0,
    this.backgroundStrokeBorderStyle=BorderStyle.solid,
  })  
  : letIndexChange = letIndexChange ?? ((_) => true),
    assert(items.isNotEmpty),
    assert(0 <= currentIndex && currentIndex < items.length),
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
    icon = widget.items[widget.currentIndex];
    _length = widget.items.length;
    _pos = widget.currentIndex / _length;
    _startingPos = widget.currentIndex / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          icon = widget.items[_endingIndex];
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
            child: CustomPaint(
              painter: NavForeGroundCurvePainter(
                _pos, 
                _length, 
                widget.navBarColor, 
                Directionality.of(context)
              ),
              foregroundPainter: widget.strokeBorderWidth!=0
              ?NavForeGroundStrokeBorderPainter(
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
            ),
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
                children: widget.items.map((item) {
                return NavButton(
                  onTap: _buttonTap,
                  position: _pos,
                  length: _length,
                  index: widget.items.indexOf(item),
                  child: Center(child: item),
                );
              }).toList())
            ),
          ),
          // Selected Button
          Positioned(
            top: 0,
            bottom: widget.selectedButtonHeight,
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
                surfaceTintColor:widget.selectedButtonColor,
                color: widget.selectedButtonColor,
                type: widget.selectedButtonMaterialType,
                borderOnForeground : true,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: icon,
                ),
              ),
            )
          ),
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
}

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;

  const NavButton({super.key, 
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
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
              child: child
            ),
          )
        ),
      ),
    );
  }
}
//Navigation Background with curve
//Control Curves here
class NavForeGroundCurvePainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;

  NavForeGroundCurvePainter(
    double startingLoc, int itemsLength, this.color, this.textDirection) {
    final span = 1.0 / itemsLength;
    s = 0.18;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((loc - 0.0) * size.width, 0) //foreground left top curvature 0.05 default 0.1
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.60, //foreground curve height left default 0.60
        (loc + s * 0.50) * size.width, //foreground curve bottom right default 0.50
        size.height * 0.60, //foreground curve height bottom default 0.60
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.60, //foreground curve height right default 0.60
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s + 0.0) * size.width, //foreground right top curvature 0.05 default 0.1
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

//Custom Stroke painter for bottom nav with gradient or a solid color
//Control Curves here 
//This is a line/Stroke above Bottom Navigation 
class NavForeGroundStrokeBorderPainter extends CustomPainter {
  late double loc;
  late double s;
  late double strokeBorderWidth;
  late bool useShaderStroke;
  Color color;
  Shader? strokeGradientShader;
  TextDirection textDirection;

  NavForeGroundStrokeBorderPainter(
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
      ..strokeWidth = strokeBorderWidth
      ..style = PaintingStyle.stroke;
      if (!useShaderStroke) {
        paint.color = color; // Set the desired color
      } else {
        paint.shader = strokeGradientShader??defaultGradientShader;// Set the desired shader
      }

    final path = Path()
      ..moveTo(-size.height, 0)
      ..lineTo((loc - 0.0) * size.width, 0) //foreground left top curvature 0.05 default 0.1
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.60, //foreground curve height left default 0.60
        (loc + s * 0.50) * size.width, //bottom curvature
        size.height * 0.60, //foreground curve height bottom default 0.60
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.60, //foreground curve height right default 0.60
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s + 0.0) * size.width, //foreground right top curvature 0.05 default 0.1
        0,
      )
      ..lineTo(size.width, 0)
      ..moveTo(0, size.width)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

