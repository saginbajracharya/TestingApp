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
  final List<Widget> icons;
  final List<String> titles;
  final int currentIndex;
  final Color foregroundColor;
  final Color backgroundColor;
  final Gradient? backgroundGradient;
  final ValueChanged<int>? onTap;
  final LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final Shader? foreGroundGradientShader;
  final bool useForeGroundGradient;
  final double? foregroundStrokeBorderWidth;
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
  final double? backgroundStrokeBorderWidth;

  DynamicBottomnavWidget({
    Key? key,
    required this.icons,
    required this.titles,
    this.onTap,
    this.animationCurve = Curves.easeOut,
    LetIndexPage? letIndexChange,
    this.foregroundColor = Colors.white,
    this.backgroundColor = Colors.amber,
    this.strokeBorderColor = Colors.white,
    this.strokeGradient = defaultGradient,
    this.backgroundGradient,
    this.strokeGradientShader,
    this.foregroundStrokeBorderWidth=0,
    this.currentIndex=0,
    this.animationDuration = const Duration(milliseconds: 500),
    this.foreGroundGradientShader,
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
    this.backgroundStrokeBorderWidth,
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
                children: widget.icons.map((item) {
                return DynamicNavBarButton(
                  onTap: _buttonTap,
                  position: _pos,
                  length: _length,
                  index: widget.icons.indexOf(item),
                  title: widget.titles[widget.icons.indexOf(item)],
                  currentIndex: widget.currentIndex,
                  child: Center(child: item),
                );
              }).toList())
            ),
          ),
          // Selected Button
          selectedButtonAnim(MediaQuery.of(context).size.width, context),
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
        child:icon,
        // child: Material(
        //   elevation: widget.selectedButtonElevation,
        //   surfaceTintColor: widget.selectedButtonColor,
        //   color: widget.selectedButtonColor,
        //   type: widget.selectedButtonMaterialType,
        //   borderOnForeground: true,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: icon,
        //   ),
        // ),
      )
    );
  }

  AnimatedPositioned selectedButtonAnim(double navBarW, BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 0), // Adjust the duration as per your preference
      curve: Curves.easeInOut, // Adjust the curve as per your preference
      top: widget.selectedButtonTopPosition,
      bottom: widget.selectedButtonBottomPosition,
      width: navBarW / _length,
      left: Directionality.of(context) == TextDirection.rtl ? null : _pos * navBarW,
      right: Directionality.of(context) == TextDirection.rtl ? _pos * navBarW : null,
      child: widget.customSelectedButtonWidget ??
      Center(
        child: icon,
      ),
    );
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
        widget.strokeBorderColor, 
        Directionality.of(context),
        widget.foregroundStrokeBorderWidth??1,
        widget.strokeGradientShader,
        widget.useShaderStroke
      )
      :NavForeGroundUpperStrokeBorderPainter(
        _pos, 
        _length, 
        widget.strokeBorderColor, 
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