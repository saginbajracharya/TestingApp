import 'package:flutter/material.dart';
import '../utils/styles.dart';
import 'Static_Dynamic_Widgets/dynamic_bottom_nav_widget.dart';
import 'Static_Dynamic_Widgets/static_bottom_nav_widget.dart';

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

class MultiNavigationBar extends StatefulWidget {
  final List<IconData> icons;
  final List<String> titles;
  final bool letIndexChange;
  final int currentIndex;
  final Color? backgroundColor;
  final Color foregroundColor;
  final Color foregroundStrokeBorderColor;
  final Color backgroundStrokeBorderColor;
  final double foregroundStrokeBorderWidth;
  final double backgroundStrokeBorderWidth;
  final Gradient? backgroundGradient;
  final Color? selectedIconColor;
  final double? selectedIconSize;   
  final double? selectedTextSize;  
  final Color? selectedTextColor;
  final Color? unselectedIconColor;
  final double? unselectedIconSize;   
  final double? unselectedTextSize;  
  final Color? unselectedTextColor;

  final bool useForeGroundGradient;
  final bool useShaderStroke;
  final bool showForeGround;
  final bool underCurve;
  final bool staticCurve;
  final Color selectedButtonColor;
  final Gradient strokeGradient;
  final Shader? foreGroundGradientShader;
  final Shader? strokeGradientShader;
  final double selectedButtonBottomPosition;
  final double selectedButtonTopPosition;
  final double selectedButtonElevation;
  final MaterialType selectedButtonMaterialType;
  final Widget? customSelectedButtonWidget;
  final Curve animationType;
  final Duration animationDuration;
  final ValueChanged<int>? onTap;
  
  const MultiNavigationBar({
    super.key,
    required this.icons,
    required this.titles,
    this.letIndexChange              = true,  // Default to change index
    this.currentIndex                = 0,     // Default as 0
    this.backgroundColor,                     // Default background Color Null
    this.foregroundColor             = grey,  // Default foreground Color White
    this.foregroundStrokeBorderColor = white, // Default foreground Stroke Border Color White
    this.backgroundStrokeBorderColor = white, // Default background Stroke Border Color White
    this.backgroundStrokeBorderWidth = 1.0,   // Default Nav BackGround Stroke Border Width
    this.foregroundStrokeBorderWidth = 1.0,   // Default Nav ForeGround Stroke Border Width
    this.backgroundGradient,                  // Default Null
    this.selectedIconColor,
    this.selectedIconSize,   
    this.selectedTextSize,  
    this.selectedTextColor,
    this.unselectedIconColor,
    this.unselectedIconSize,   
    this.unselectedTextSize,  
    this.unselectedTextColor,

    this.animationType               = Curves.easeOut,
    this.animationDuration           = const Duration(milliseconds: 500),
    this.useForeGroundGradient       = false,
    this.useShaderStroke             = false,
    this.showForeGround              = true,
    this.underCurve                  = true,
    this.staticCurve                 = false,
    this.selectedButtonColor         = blue,
    this.strokeGradient              = defaultGradient,
    this.foreGroundGradientShader,
    this.strokeGradientShader,
    this.selectedButtonBottomPosition= 0.0,
    this.selectedButtonTopPosition   = 0.0,
    this.selectedButtonElevation     = 0,
    this.selectedButtonMaterialType  = MaterialType.circle,
    this.customSelectedButtonWidget,
    this.onTap,
  });

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<MultiNavigationBar>{

  @override
  Widget build(BuildContext context) {
    return widget.staticCurve
    ?StaticBottomNavWidget(
      icons                            : widget.icons, 
      titles                           : widget.titles,
      letIndexChange                   : (index) => widget.letIndexChange,
      currentIndex                     : widget.currentIndex,
      backgroundColor                  : widget.backgroundColor,
      foregroundColor                  : widget.foregroundColor,
      backgroundStrokeBorderWidth      : widget.backgroundStrokeBorderWidth,
      foregroundStrokeBorderWidth      : widget.foregroundStrokeBorderWidth,
      selectedIconColor                : widget.selectedIconColor,
      selectedIconSize                 : widget.selectedIconSize,   
      selectedTextSize                 : widget.selectedTextSize,  
      selectedTextColor                : widget.selectedTextColor,
      unselectedIconColor              : widget.unselectedIconColor,
      unselectedIconSize               : widget.unselectedIconSize,   
      unselectedTextSize               : widget.unselectedTextSize,  
      unselectedTextColor              : widget.unselectedTextColor,

      animationCurve                   : widget.animationType,
      animationDuration                : widget.animationDuration,
      backgroundGradient               : widget.backgroundGradient,
      foreGroundGradientShader         : widget.foreGroundGradientShader,
      useForeGroundGradient            : widget.useForeGroundGradient,
      foregroundStrokeBorderColor      : widget.foregroundStrokeBorderColor,
      strokeGradient                   : widget.strokeGradient,
      strokeGradientShader             : widget.strokeGradientShader,
      useShaderStroke                  : widget.useShaderStroke,
      showForeGround                   : widget.showForeGround,
      underCurve                       : widget.underCurve,
      staticCurve                      : widget.staticCurve,
      selectedButtonBottomPosition     : widget.selectedButtonBottomPosition,
      selectedButtonTopPosition        : widget.selectedButtonTopPosition,
      selectedButtonElevation          : widget.selectedButtonElevation,
      selectedButtonColor              : widget.selectedButtonColor,
      selectedButtonMaterialType       : widget.selectedButtonMaterialType,
      customSelectedButtonWidget       : widget.customSelectedButtonWidget,
      backgroundStrokeBorderColor      : widget.backgroundStrokeBorderColor,
      onTap                            : widget.onTap,
    )
    :DynamicBottomnavWidget(
      icons                            : widget.icons, 
      titles                           : widget.titles,
      letIndexChange                   : (index) => widget.letIndexChange,
      currentIndex                     : widget.currentIndex,
      foregroundColor                  : widget.foregroundColor,
      backgroundColor                  : widget.backgroundColor,
      backgroundStrokeBorderWidth      : widget.backgroundStrokeBorderWidth,
      foregroundStrokeBorderWidth      : widget.foregroundStrokeBorderWidth,
      selectedIconColor                : widget.selectedIconColor,
      selectedIconSize                 : widget.selectedIconSize,   
      selectedTextSize                 : widget.selectedTextSize,  
      selectedTextColor                : widget.selectedTextColor,
      unselectedIconColor              : widget.unselectedIconColor,
      unselectedIconSize               : widget.unselectedIconSize,   
      unselectedTextSize               : widget.unselectedTextSize,  
      unselectedTextColor              : widget.unselectedTextColor,

      animationCurve                    : widget.animationType,
      animationDuration                 : widget.animationDuration,
      backgroundGradient                : widget.backgroundGradient,
      foreGroundGradientShader          : widget.foreGroundGradientShader,
      useForeGroundGradient             : widget.useForeGroundGradient,
      foregroundStrokeBorderColor       : widget.foregroundStrokeBorderColor,
      strokeGradient                    : widget.strokeGradient,
      strokeGradientShader              : widget.strokeGradientShader,
      useShaderStroke                   : widget.useShaderStroke,
      showForeGround                    : widget.showForeGround,
      underCurve                        : widget.underCurve,
      staticCurve                       : widget.staticCurve,
      selectedButtonBottomPosition      : widget.selectedButtonBottomPosition,
      selectedButtonTopPosition         : widget.selectedButtonTopPosition,
      selectedButtonElevation           : widget.selectedButtonElevation,
      selectedButtonColor               : widget.selectedButtonColor,
      selectedButtonMaterialType        : widget.selectedButtonMaterialType,
      customSelectedButtonWidget        : widget.customSelectedButtonWidget,
      backgroundStrokeBorderColor       : widget.backgroundStrokeBorderColor,
      onTap                             : widget.onTap,
    );
  }
}




