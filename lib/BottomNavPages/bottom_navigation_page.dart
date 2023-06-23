import 'package:flutter/material.dart';
import '../CurvedNavigationBar/multi_navigation_bar.dart';
import '../utils/styles.dart';
import 'page_1.dart';
import 'page_2.dart';
import 'page_3.dart';
import 'page_4.dart';
import 'page_5.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  var currentIndex = 0;

  final List<String> title = [
    "Page 1",
    "Page 2",
    "Page 3",
    "Page 4",
    "Page 5"
  ];

  final List<IconData> icons = [
    Icons.favorite, 
    Icons.home, 
    Icons.wallet, 
    Icons.ac_unit_outlined, 
    Icons.access_alarm_rounded, 
  ];

  final List pages = [
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
    const Page5(),
  ];
  
  Gradient backgroundGradientColor = const LinearGradient(
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

  Shader foreGroundGradientShader = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      black,
      black,
      black,
      black,
      red,
    ],
    stops: [0.2, 0.4, 0.5, 0.6, 2.0],
  ).createShader(Rect.fromCenter(center: const Offset(0.0,0.0), height: 200, width: 100));

  Shader strokeGradientShader = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.red,
      Colors.purple,
      Colors.green,
      Colors.yellow,
      Colors.blue,
    ],
    stops: [0.2, 0.4, 0.5, 0.6, 2.0],
  ).createShader(Rect.fromCenter(center: const Offset(0.0,0.0), height: 200, width: 100));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: blue.withOpacity(0.6),
      body: pages[currentIndex],
      bottomNavigationBar: MultiNavigationBar(
        icons                        : icons,                    // Icon list<Widget>
        titles                       : title,                    // Title list<String>
        letIndexChange               : true,                     // On Tap Icon if true => changes index , False => dose not changes index
        currentIndex                 : currentIndex,             // Current selected index
        backgroundColor              : lightBlue,                // NavBar BackGround Color [backgroundGradient ovrerides color]
        foregroundColor              : green,                    // NavBar ForeGround Color with Curve 
        foregroundStrokeBorderColor  : red,                      // Nav Stroke Border Color [useShaderStroke = false , strokeBorderWidth != 0]
        backgroundStrokeBorderColor  : red,                      // nav background stroke color [seems like when border width is 0.0 still shows the color but transparent solves it]
        backgroundStrokeBorderWidth  : 1.0,                      // Nav BackGround Stroke Border Width
        foregroundStrokeBorderWidth  : 1.0,                      // Nav ForeGround Stroke Border Width  
        backgroundGradient           : null,                     // Nav background Gradient [No Gradient if Null Overrides backgroundColor if given]
        foreGroundGradientShader     : foreGroundGradientShader, // Nav ForeGround Gradient Shader [foregroundColor or foreGroundGradientShader determined by Bool useForeGroundGradient]
        //Selection and UnSelection for No Curve (Simple Nav) OK,
        //Selection and UnSelection for Static Curve (No Change Curve) OK,
        //Selection and UnSelection for Dynamic Curve (Changing Curve) OK,
        selectedIconColor            : red,                      // Selected Item Icon Color
        selectedIconSize             : 25,                       // Selected Item Icon Size
        selectedTextSize             : 10,                       // Selected Item Text Size
        selectedTextColor            : red,                      // Selected Item Text Color
        unselectedIconColor          : black,                    // UnSelected Item Icon Color
        unselectedIconSize           : 25,                       // UnSelected Item Icon Size
        unselectedTextSize           : 10,                       // UnSelected Item Text Size
        unselectedTextColor          : black,                    // UnSelected Item Text Color

        strokeGradientShader         : strokeGradientShader,     // ForeGround Stroke border Gradient Shader
        useForeGroundGradient        : false,
        showForeGround               : true,
        useShaderStroke              : false,
        underCurve                   : false,
        staticCurve                  : false,
        //[Selected btn values ok for DYNAMIC upper and under curve]
        //[Selected btn values not ok for STATIC upper and under curve]
        selectedButtonBottomPosition : 14.0,
        selectedButtonTopPosition    : 0.0,
        selectedButtonElevation      : 10,
        animationType                : Curves.ease, // Index change animation curves
        animationDuration            : const Duration(milliseconds: 1000), //Index Change Animation duration for curve only
        onTap                        : (index) async => onItemTapped(index), //Custom OnTap CallBacks
      ),
    );
  }

  void onItemTapped(int index) async{
    setState(() {
      currentIndex = index;
    });
  }
}