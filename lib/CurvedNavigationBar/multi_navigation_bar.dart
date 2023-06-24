import 'package:flutter/material.dart';
import '../utils/styles.dart';
import 'Static_Dynamic_Widgets/dynamic_bottom_nav_widget.dart';
import 'Static_Dynamic_Widgets/static_bottom_nav_widget.dart';

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
  final bool showCircleStaticMidItem;
  final Color midItemCircleColor;
  final Color midItemCircleBorderColor;
  final bool showMidCircleStatic;
  final double midCircleRadiusStatic;
  final double midCircleBorderRadiusStatic;

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
    this.backgroundStrokeBorderWidth = 0.0,   // Default Nav BackGround Stroke Border Width
    this.foregroundStrokeBorderWidth = 1.0,   // Default Nav ForeGround Stroke Border Width
    this.backgroundGradient,                  // Default Null
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
    this.useForeGroundGradient       = false,
    this.showForeGround              = true,
    this.useShaderStroke             = false,
    this.underCurve                  = true,
    this.staticCurve                 = false,
    this.showCircleStaticMidItem     = true,
    this.midItemCircleColor          = Colors.white,
    this.midItemCircleBorderColor    = Colors.black,
    this.showMidCircleStatic         = true,
    this.midCircleRadiusStatic       = 25.0,
    this.midCircleBorderRadiusStatic = 2.0,
    
    this.animationType               = Curves.easeOut,
    this.animationDuration           = const Duration(milliseconds: 500),
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
      icons                               : widget.icons, 
      titles                              : widget.titles,
      letIndexChange                      : (index) => widget.letIndexChange,
      currentIndex                        : widget.currentIndex,
      backgroundColor                     : widget.backgroundColor,
      foregroundColor                     : widget.foregroundColor,
      foregroundStrokeBorderColor         : widget.foregroundStrokeBorderColor,
      backgroundStrokeBorderColor         : widget.backgroundStrokeBorderColor,
      backgroundStrokeBorderWidth         : widget.backgroundStrokeBorderWidth,
      foregroundStrokeBorderWidth         : widget.foregroundStrokeBorderWidth,
      backgroundGradient                  : widget.backgroundGradient,
      foreGroundGradientShader            : widget.foreGroundGradientShader,

      selectedIconColor                   : widget.selectedIconColor,
      selectedIconSize                    : widget.selectedIconSize,   
      selectedTextSize                    : widget.selectedTextSize,  
      selectedTextColor                   : widget.selectedTextColor,
      unselectedIconColor                 : widget.unselectedIconColor,
      unselectedIconSize                  : widget.unselectedIconSize,   
      unselectedTextSize                  : widget.unselectedTextSize,  
      unselectedTextColor                 : widget.unselectedTextColor,

      strokeGradientShader                : widget.strokeGradientShader,
      useForeGroundGradient               : widget.useForeGroundGradient,
      showForeGround                      : widget.showForeGround,
      useShaderStroke                     : widget.useShaderStroke,
      underCurve                          : widget.underCurve,
      staticCurve                         : widget.staticCurve,
      showCircleStaticMidItem             : widget.showCircleStaticMidItem,
      midItemCircleColor                  : widget.midItemCircleColor,
      midItemCircleBorderColor            : widget.midItemCircleBorderColor,
      showMidCircleStatic                 : widget.showMidCircleStatic,
      midCircleRadiusStatic               : widget.midCircleRadiusStatic,
      midCircleBorderRadiusStatic         : widget.midCircleBorderRadiusStatic,
      
      animationCurve                      : widget.animationType,
      animationDuration                   : widget.animationDuration,
      onTap                               : widget.onTap,
    )
    :DynamicBottomnavWidget(
      icons                                : widget.icons, 
      titles                               : widget.titles,
      letIndexChange                       : (index) => widget.letIndexChange,
      currentIndex                         : widget.currentIndex,
      foregroundColor                      : widget.foregroundColor,
      backgroundColor                      : widget.backgroundColor,
      foregroundStrokeBorderColor          : widget.foregroundStrokeBorderColor,
      backgroundStrokeBorderColor          : widget.backgroundStrokeBorderColor,
      backgroundStrokeBorderWidth          : widget.backgroundStrokeBorderWidth,
      foregroundStrokeBorderWidth          : widget.foregroundStrokeBorderWidth,
      backgroundGradient                   : widget.backgroundGradient,
      foreGroundGradientShader             : widget.foreGroundGradientShader,

      selectedIconColor                    : widget.selectedIconColor,
      selectedIconSize                     : widget.selectedIconSize,   
      selectedTextSize                     : widget.selectedTextSize,  
      selectedTextColor                    : widget.selectedTextColor,
      unselectedIconColor                  : widget.unselectedIconColor,
      unselectedIconSize                   : widget.unselectedIconSize,   
      unselectedTextSize                   : widget.unselectedTextSize,  
      unselectedTextColor                  : widget.unselectedTextColor,

      strokeGradientShader                 : widget.strokeGradientShader,
      useForeGroundGradient                : widget.useForeGroundGradient,
      showForeGround                       : widget.showForeGround,
      useShaderStroke                      : widget.useShaderStroke,
      underCurve                           : widget.underCurve,
      staticCurve                          : widget.staticCurve,
      
      animationCurve                       : widget.animationType,
      animationDuration                    : widget.animationDuration,
      onTap                                : widget.onTap,
    );
  }
}




