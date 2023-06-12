import 'package:flutter/material.dart';
import 'package:testingapp/CurvedNavigationBar/dynamic_bottom_nav_widget.dart';
import 'package:testingapp/CurvedNavigationBar/static_bottom_nav_widget.dart';

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
  final double navBarHeight;
  final double navBarWidth;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Curve animationType;
  final Duration animationDuration;
  final bool letIndexChange;
  final bool useForeGroundGradient;
  final bool useShaderStroke;
  final bool showForeGround;
  final bool underCurve;
  final bool staticCurve;
  final Color navBarColor;
  final Color backgroundColor;
  final Color strokeBorderColor;
  final Color selectedButtonColor;
  final Color backgroundStrokeBorderColor;
  final Gradient strokeGradient;
  final Shader? foreGroundGradient;
  final Shader? strokeGradientShader;
  final double? strokeBorderWidth;
  final double selectedButtonBottomPosition;
  final double selectedButtonTopPosition;
  final double selectedButtonElevation;
  final double backgroundStrokeBorderWidth;
  final MaterialType selectedButtonMaterialType;
  final Widget? customSelectedButtonWidget;
  final BorderStyle backgroundStrokeBorderStyle;
  
  const CurvedNavigationBar({
    super.key,
    required this.icons,
    required this.titles,
    this.navBarHeight = kBottomNavigationBarHeight,
    this.navBarWidth=double.infinity,
    this.currentIndex=0,
    this.onTap,
    this.animationType = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 500),
    this.letIndexChange = true,
    this.useForeGroundGradient=false,
    this.useShaderStroke=false,
    this.showForeGround=true,
    this.underCurve=true,
    this.staticCurve=false,
    this.navBarColor = Colors.white,
    this.backgroundColor = Colors.amber,
    this.strokeBorderColor = Colors.white,
    this.selectedButtonColor =Colors.blue,
    this.backgroundStrokeBorderColor =Colors.black,
    this.strokeGradient = defaultGradient,
    this.foreGroundGradient,
    this.strokeGradientShader,
    this.strokeBorderWidth=0,
    this.selectedButtonBottomPosition=0.0,
    this.selectedButtonTopPosition=0.0,
    this.selectedButtonElevation=0,
    this.backgroundStrokeBorderWidth=2.0,
    this.selectedButtonMaterialType = MaterialType.circle,
    this.customSelectedButtonWidget,
    this.backgroundStrokeBorderStyle=BorderStyle.solid,
  });

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar>{

  @override
  Widget build(BuildContext context) {
    return widget.staticCurve
    ?StaticBottomNavWidget(
      icons: widget.icons, 
      titles: widget.titles,
      currentIndex:widget.currentIndex,
      navBarColor:widget.navBarColor,
      backgroundColor:widget.backgroundColor,
      onTap:widget.onTap,
      letIndexChange:(index) => widget.letIndexChange,
      animationCurve:widget.animationType,
      animationDuration:widget.animationDuration,
      navBarHeight:widget.navBarHeight,
      navBarWidth:widget.navBarWidth,
      foreGroundGradient:widget.foreGroundGradient,
      useForeGroundGradient:widget.useForeGroundGradient,
      strokeBorderWidth:widget.strokeBorderWidth,
      strokeBorderColor:widget.strokeBorderColor,
      strokeGradient:widget.strokeGradient,
      strokeGradientShader:widget.strokeGradientShader,
      useShaderStroke:widget.useShaderStroke,
      showForeGround:widget.showForeGround,
      underCurve:widget.underCurve,
      staticCurve:widget.staticCurve,
      selectedButtonBottomPosition:widget.selectedButtonBottomPosition,
      selectedButtonTopPosition:widget.selectedButtonTopPosition,
      selectedButtonElevation:widget.selectedButtonElevation,
      selectedButtonColor:widget.selectedButtonColor,
      selectedButtonMaterialType:widget.selectedButtonMaterialType,
      customSelectedButtonWidget:widget.customSelectedButtonWidget,
      backgroundStrokeBorderColor:widget.backgroundStrokeBorderColor,
      backgroundStrokeBorderWidth:widget.backgroundStrokeBorderWidth,
      backgroundStrokeBorderStyle:widget.backgroundStrokeBorderStyle,
    )
    :DynamicBottomnavWidget(
      icons: widget.icons, 
      titles: widget.titles,
      currentIndex:widget.currentIndex,
      navBarColor:widget.navBarColor,
      backgroundColor:widget.backgroundColor,
      onTap:widget.onTap,
      letIndexChange:(index) => widget.letIndexChange,
      animationCurve:widget.animationType,
      animationDuration:widget.animationDuration,
      navBarHeight:widget.navBarHeight,
      navBarWidth:widget.navBarWidth,
      foreGroundGradient:widget.foreGroundGradient,
      useForeGroundGradient:widget.useForeGroundGradient,
      strokeBorderWidth:widget.strokeBorderWidth,
      strokeBorderColor:widget.strokeBorderColor,
      strokeGradient:widget.strokeGradient,
      strokeGradientShader:widget.strokeGradientShader,
      useShaderStroke:widget.useShaderStroke,
      showForeGround:widget.showForeGround,
      underCurve:widget.underCurve,
      staticCurve:widget.staticCurve,
      selectedButtonBottomPosition:widget.selectedButtonBottomPosition,
      selectedButtonTopPosition:widget.selectedButtonTopPosition,
      selectedButtonElevation:widget.selectedButtonElevation,
      selectedButtonColor:widget.selectedButtonColor,
      selectedButtonMaterialType:widget.selectedButtonMaterialType,
      customSelectedButtonWidget:widget.customSelectedButtonWidget,
      backgroundStrokeBorderColor:widget.backgroundStrokeBorderColor,
      backgroundStrokeBorderWidth:widget.backgroundStrokeBorderWidth,
      backgroundStrokeBorderStyle:widget.backgroundStrokeBorderStyle,
    );
  }
}




