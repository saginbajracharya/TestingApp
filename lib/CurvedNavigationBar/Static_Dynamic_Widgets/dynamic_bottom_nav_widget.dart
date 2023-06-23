import 'package:flutter/material.dart';
import '../ForeGround_Curves_Under_Upper/nav_foreground_curve_under.dart';
import '../ForeGround_Curves_Under_Upper/nav_foreground_curve_upper.dart';
import '../Button_Widgets/nav_button_widget.dart';

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

class DynamicBottomnavWidget extends StatefulWidget {
  final List<IconData> icons;
  final List<String> titles;
  final LetIndexPage letIndexChange;
  final int currentIndex;
  final Color? backgroundColor;
  final Color foregroundColor;
  final Color foregroundStrokeBorderColor;
  final Color backgroundStrokeBorderColor;
  final double? backgroundStrokeBorderWidth;
  final double? foregroundStrokeBorderWidth;
  final Gradient? backgroundGradient;
  final Shader? foreGroundGradientShader;

  final Color? selectedIconColor;
  final double? selectedIconSize;   
  final double? selectedTextSize;  
  final Color? selectedTextColor;
  final Color? unselectedIconColor;
  final double? unselectedIconSize;   
  final double? unselectedTextSize;  
  final Color? unselectedTextColor;
  
  final Shader? strokeGradientShader;
  final bool useForeGroundGradient;
  final bool showForeGround;
  final bool useShaderStroke;
  final bool underCurve;
  final bool staticCurve;
  
  final Curve animationCurve;
  final Duration animationDuration;
  final ValueChanged<int>? onTap;

  DynamicBottomnavWidget({
    Key? key,
    required this.icons,
    required this.titles,
    LetIndexPage? letIndexChange,
    this.currentIndex=0,
    this.backgroundColor = Colors.amber,
    this.foregroundColor = Colors.white,
    this.foregroundStrokeBorderColor = Colors.white,
    this.backgroundStrokeBorderColor=Colors.black,
    this.backgroundStrokeBorderWidth,
    this.foregroundStrokeBorderWidth=0,
    this.backgroundGradient,
    this.foreGroundGradientShader,
    
    this.selectedIconColor,
    this.selectedIconSize,   
    this.selectedTextSize,  
    this.selectedTextColor,
    this.unselectedIconColor,
    this.unselectedIconSize,   
    this.unselectedTextSize,  
    this.unselectedTextColor,
    
    this.strokeGradientShader,
    this.useForeGroundGradient=false,
    this.showForeGround=true,
    this.useShaderStroke=false,
    this.underCurve=true,
    this.staticCurve=false,
    
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 500),
    this.onTap,
  })  
  : letIndexChange = letIndexChange ?? ((_) => true),
    assert(icons.isNotEmpty),
    assert(0 <= currentIndex && currentIndex < icons.length),
    assert(0 <= kBottomNavigationBarHeight && kBottomNavigationBarHeight <= 75.0),
    super(key: key);

  @override
  State<DynamicBottomnavWidget> createState() => _DynamicBottomnavWidgetState();
}

class _DynamicBottomnavWidgetState extends State<DynamicBottomnavWidget> with TickerProviderStateMixin{
  late double _startingPos;
  int _endingIndex = 0;
  late double _pos;
  late IconData icon;
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
  void didUpdateWidget (DynamicBottomnavWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() {
        final newPosition = widget.currentIndex / _length;
        _startingPos = _pos;
        _endingIndex = widget.currentIndex;
        _animationController.animateTo(
          newPosition,
          duration: widget.animationDuration, 
          curve: widget.animationCurve
        );
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border(
          top: BorderSide(
            color : widget.backgroundStrokeBorderColor,
            width : widget.backgroundStrokeBorderWidth??0.0,
            style : BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignInside
          ),
        ),
        gradient:widget.backgroundGradient,
      ),
      height: kBottomNavigationBarHeight,
      width: MediaQuery.of(context).size.width,
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
            bottom: 0 - (75.0 - kBottomNavigationBarHeight),
            child: dynamicCurve(context),
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
                children: widget.icons.map((icon) {
                return DynamicNavBarButton(
                  onTap              : _buttonTap,
                  position           : _pos,
                  length             : _length,
                  index              : widget.icons.indexOf(icon),
                  title              : widget.titles[widget.icons.indexOf(icon)],
                  currentIndex       : widget.currentIndex,
                  showForeGround     : widget.showForeGround,
                  icon               : icon,
                  selectedIconColor  : widget.selectedIconColor, 
                  selectedIconSize   : widget.selectedIconSize, 
                  selectedTextColor  : widget.selectedTextColor, 
                  selectedTextSize   : widget.selectedTextSize, 
                  unselectedIconColor: widget.unselectedIconColor, 
                  unselectedIconSize : widget.unselectedIconSize, 
                  unselectedTextColor: widget.unselectedTextColor, 
                  unselectedTextSize : widget.unselectedTextSize,
                );
              }).toList())
            ),
          ),
        ],
      ),
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    setState(() {
      if (!widget.letIndexChange(index)) {
        return;
      }
      if (widget.onTap != null) {
        widget.onTap!(index);
      }
      final newPosition = index / _length;
        _startingPos = _pos;
        _endingIndex = index;
        _animationController.animateTo(
          newPosition,
          duration: widget.animationDuration, 
          curve: widget.animationCurve
        );
    });
  }
  
  CustomPaint dynamicCurve(BuildContext context) {
    return CustomPaint(
      painter: widget.underCurve
      ?NavForeGroundCurvePainterUnder(
        _pos, 
        _length, 
        widget.useForeGroundGradient,
        widget.foreGroundGradientShader,
        widget.foregroundColor, 
        Directionality.of(context)
      )
      :NavForeGroundCurvePainterUpper(
        _pos, 
        _length, 
        widget.useForeGroundGradient,
        widget.foreGroundGradientShader,
        widget.foregroundColor, 
        Directionality.of(context)
      ),
      foregroundPainter: widget.foregroundStrokeBorderWidth!=0 
      ?widget.underCurve
      ?NavForeGroundUnderStrokeBorderPainter(
        _pos, 
        _length, 
        widget.foregroundStrokeBorderColor, 
        Directionality.of(context),
        widget.foregroundStrokeBorderWidth??1,
        widget.strokeGradientShader,
        widget.useShaderStroke
      )
      :NavForeGroundUpperStrokeBorderPainter(
        _pos, 
        _length, 
        widget.foregroundStrokeBorderColor, 
        Directionality.of(context),
        widget.foregroundStrokeBorderWidth??1,
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