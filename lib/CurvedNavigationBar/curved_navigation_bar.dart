import 'package:flutter/material.dart';
import 'package:testingapp/CurvedNavigationBar/Static_Dynamic_Widgets/dynamic_bottom_nav_widget.dart';
import 'package:testingapp/CurvedNavigationBar/Static_Dynamic_Widgets/static_bottom_nav_widget.dart';

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

class CurvedNavigationBar extends StatefulWidget {
  final List<Widget> icons;
  final List<String> titles;
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
  final Color foregroundColor;
  final Color backgroundColor;
  final Color strokeBorderColor;
  final Color selectedButtonColor;
  final Color backgroundStrokeBorderColor;
  final Gradient? backgroundGradient;
  final Gradient strokeGradient;
  final Shader? foreGroundGradientShader;
  final Shader? strokeGradientShader;
  final double? foregroundStrokeBorderWidth;
  final double selectedButtonBottomPosition;
  final double selectedButtonTopPosition;
  final double selectedButtonElevation;
  final double? backgroundStrokeBorderWidth;
  final MaterialType selectedButtonMaterialType;
  final Widget? customSelectedButtonWidget;
  
  const CurvedNavigationBar({
    super.key,
    required this.icons,
    required this.titles,
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
    this.foregroundColor = Colors.white,
    this.backgroundColor = Colors.amber,
    this.strokeBorderColor = Colors.white,
    this.selectedButtonColor =Colors.blue,
    this.backgroundGradient,
    this.backgroundStrokeBorderColor =Colors.black,
    this.strokeGradient = defaultGradient,
    this.foreGroundGradientShader,
    this.strokeGradientShader,
    this.foregroundStrokeBorderWidth=0,
    this.selectedButtonBottomPosition=0.0,
    this.selectedButtonTopPosition=0.0,
    this.selectedButtonElevation=0,
    this.backgroundStrokeBorderWidth,
    this.selectedButtonMaterialType = MaterialType.circle,
    this.customSelectedButtonWidget,
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
      foregroundColor:widget.foregroundColor,
      backgroundColor:widget.backgroundColor,
      onTap:widget.onTap,
      letIndexChange:(index) => widget.letIndexChange,
      animationCurve:widget.animationType,
      animationDuration:widget.animationDuration,
      backgroundGradient:widget.backgroundGradient,
      foreGroundGradientShader:widget.foreGroundGradientShader,
      useForeGroundGradient:widget.useForeGroundGradient,
      foregroundStrokeBorderWidth:widget.foregroundStrokeBorderWidth,
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
    )
    :DynamicBottomnavWidget(
      icons: widget.icons, 
      titles: widget.titles,
      currentIndex:widget.currentIndex,
      foregroundColor:widget.foregroundColor,
      backgroundColor:widget.backgroundColor,
      onTap:widget.onTap,
      letIndexChange:(index) => widget.letIndexChange,
      animationCurve:widget.animationType,
      animationDuration:widget.animationDuration,
      backgroundGradient:widget.backgroundGradient,
      foreGroundGradientShader:widget.foreGroundGradientShader,
      useForeGroundGradient:widget.useForeGroundGradient,
      foregroundStrokeBorderWidth:widget.foregroundStrokeBorderWidth,
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
    );
  }
}




