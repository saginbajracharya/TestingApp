import 'package:flutter/material.dart';
import 'package:testingapp/CurvedNavigationBar/dynamic_bottom_nav_widget.dart';
import 'package:testingapp/CurvedNavigationBar/static_bottom_nav_widget.dart';

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
    super(key: key);

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
      letIndexChange:widget.letIndexChange,
      animationCurve:widget.animationCurve,
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
      letIndexChange:widget.letIndexChange,
      animationCurve:widget.animationCurve,
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




