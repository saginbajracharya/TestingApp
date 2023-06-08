import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

typedef LetIndexPage = bool Function(int value);

Gradient whiteGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.grey[400]!,
    Colors.grey[300]!,
    Colors.grey[100]!,
    Colors.grey[300]!,
    Colors.grey[400]!,
  ],
  stops: const [0.1, 0.3, 0.5, 0.7, 1.0],
);

class CurvedNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int currentIndex;
  final Color navBarColor;
  final Color backgroundColor;
  final Color? borderColor;
  final ValueChanged<int>? onTap;
  final LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double navBarHeight;
  final double navBarWidth;
  final double? strokeBorderWidth;
  final Color strokeBorderColor;
  final bool showForeGround;
  
  CurvedNavigationBar({
    Key? key,
    required this.items,
    this.onTap,
    this.animationCurve = Curves.easeOut,
    LetIndexPage? letIndexChange,
    this.navBarColor = Colors.white,
    this.backgroundColor = Colors.amber,
    this.borderColor = Colors.yellow,
    this.strokeBorderColor = Colors.white,
    this.strokeBorderWidth=0,
    this.currentIndex=0,
    this.animationDuration = const Duration(milliseconds: 500),
    this.navBarHeight = kBottomNavigationBarHeight,
    this.navBarWidth=double.infinity,
    this.showForeGround=true,
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
        border: const Border(
          top: BorderSide(
            color : Colors.blue,
            width : 4.0,
            style : BorderStyle.solid,
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
              painter: NavCustomPainter(
                _pos, 
                _length, 
                widget.navBarColor, 
                Directionality.of(context)
              ),
              foregroundPainter: widget.strokeBorderWidth!=0
              ?NavCustomForeGroundPainter(
                _pos, 
                _length, 
                widget.borderColor?? widget.navBarColor, 
                Directionality.of(context),
                widget.strokeBorderWidth??1
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
            bottom: 18,
            width: navBarW/_length,
            left: Directionality.of(context) == TextDirection.rtl
            ? null
            : _pos * navBarW,
            right: Directionality.of(context) == TextDirection.rtl
            ? _pos * navBarW
            : null,
            child: Center(
              child: Material(
                elevation: 0,
                surfaceTintColor:Colors.black,
                color: Colors.transparent,
                type: MaterialType.circle,
                borderOnForeground : true,
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: GradientBoxBorder(
                      gradient: whiteGradient,
                      width: 1,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.transparent,
                    child: icon
                  ),
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
class NavCustomPainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;

  NavCustomPainter(
    double startingLoc, int itemsLength, this.color, this.textDirection) {
    final span = 1.0 / itemsLength;
    s = 0.14;
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
      ..lineTo((loc - 0.1) * size.width, 0)
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.60,
        (loc + s * 0.50) * size.width,
        size.height * 0.60,
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.60,
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s + 0.1) * size.width,
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
class NavCustomForeGroundPainter extends CustomPainter {
  late double loc;
  late double s;
  late double strokeBorderWidth;
  Color color;
  TextDirection textDirection;

  NavCustomForeGroundPainter(
    double startingLoc, 
    int itemsLength, 
    this.color, 
    this.textDirection,
    this.strokeBorderWidth,
  ) 
  {
    final span = 1.0 / itemsLength;
    s = 0.14;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  dynamic defaultGradientShader = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.grey[100]!,
      Colors.grey[200]!,
      Colors.grey[400]!,
      Colors.grey[200]!,
      Colors.grey[100]!,
    ],
    stops: const [0.1, 0.3, 0.5, 0.7, 1.0],
  ).createShader(Rect.fromCenter(center: const Offset(0.0,0.0), height: 200, width: 100,));

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      // ..color = color
      ..strokeWidth = strokeBorderWidth
      ..style = PaintingStyle.stroke
      ..shader = defaultGradientShader;

    final path = Path()
      ..moveTo(-size.height, 0)
      ..lineTo((loc - 0.1) * size.width, 0)
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.60,
        (loc + s * 0.50) * size.width,
        size.height * 0.60,
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.60,
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s + 0.1) * size.width,
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

