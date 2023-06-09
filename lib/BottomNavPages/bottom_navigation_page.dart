import 'dart:math';

import 'package:flutter/material.dart';
import '../UltimateBottomNavBar/ultimate_bottom_nav_bar.dart';
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
  Random random                      = Random();
  int currentIndex                   = 0;
  bool staticCurve                   = false;
  bool useForeGroundGradient         = false;
  bool showForeGround                = true;
  bool useShaderStroke               = false;
  bool underCurve                    = true;
  bool showCircleStaticMidItem       = true;
  Color backgroundColor              = transparent; 
  double backgroundStrokeBorderWidth = 0.0;  
  var badgeVal1                      = '5';
  var badgeVal2                      = '55';

  final List<String> title = [
    "",
    "",
    "",
    "",
    ""
  ];

  final List<IconData> icons = [
    Icons.favorite, 
    Icons.wallet, 
    Icons.home, 
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
      blue,
      red,
      yellow,
      green,
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
      extendBody: true,
      backgroundColor: blue.withOpacity(0.6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: kBottomNavigationBarHeight+50,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top:kBottomNavigationBarHeight),
            child: pages[currentIndex],
          ),
          Container(
            height: MediaQuery.of(context).size.height-kBottomNavigationBarHeight-kBottomNavigationBarHeight,
            padding: const EdgeInsets.only(left:10.0,right:10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Random Background Color
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          backgroundColor = Color.fromARGB(
                            255,
                            random.nextInt(256),
                            random.nextInt(256),
                            random.nextInt(256),
                          );
                        });
                      }, 
                      child: const Text('Random Background Color',style: TextStyle(color: white))
                    ),
                  ),
                  //Show Hide Background Stroke
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          if(backgroundStrokeBorderWidth==0.0){
                            backgroundStrokeBorderWidth=2.0;
                          }else{
                            backgroundStrokeBorderWidth=0.0;
                          }
                        });
                      }, 
                      child: Text(backgroundStrokeBorderWidth==0.0?'Show Background Stroke':'Hide Background Stroke',style: const TextStyle(color: white))
                    ),
                  ),
                  //ForeGround Gradient / Solod Color
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          if(useForeGroundGradient==false)
                          {
                            useForeGroundGradient=true;
                          }else{
                            useForeGroundGradient=false;
                          }
                        });
                      }, 
                      child: Text(useForeGroundGradient?'ForeGround Solid Color':'ForeGround Gradient Color',style: const TextStyle(color: white))
                    ),
                  ),
                  //Show Hide ForeGround
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          if(showForeGround==false)
                          {
                            showForeGround=true;
                          }else{
                            showForeGround=false;
                          }
                        });
                      }, 
                      child: Text(showForeGround?'Hide ForeGround':'Show ForeGround',style: const TextStyle(color: white))
                    ),
                  ),
                  //Foreground Shader Stroke
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          if(useShaderStroke==false)
                          {
                            useShaderStroke=true;
                          }else{
                            useShaderStroke=false;
                          }
                        });
                      }, 
                      child: Text(useShaderStroke?'ForeGround Solid Color Stroke':'ForeGround Shader Gradient Stroke',style: const TextStyle(color: white))
                    ),
                  ),
                  //Under Upper Curve
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          if(underCurve==false)
                          {
                            underCurve=true;
                          }else{
                            underCurve=false;
                          }
                        });
                      }, 
                      child: Text(underCurve?'Upper Curve':'Under Curve',style: const TextStyle(color: white))
                    ),
                  ),
                  //Static Dynamic Curve
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          if(staticCurve==false)
                          {
                            staticCurve=true;
                          }else{
                            staticCurve=false;
                          }
                        });
                      }, 
                      child: Text(staticCurve?'Dynamic Curve':'Static Curve',style: const TextStyle(color: white))
                    ),
                  ),
                  //Change Badge value 1
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          badgeVal1 = (int.parse(badgeVal1)+1).toString();
                        });
                      }, 
                      child: const Text('Change Badge value 1',style: TextStyle(color: white))
                    ),
                  ),
                  //Change Badge value 2
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          badgeVal2 = (int.parse(badgeVal2)+1).toString();
                        });
                      }, 
                      child: const Text('Change Badge value 2',style: TextStyle(color: white))
                    ),
                  ),
                  //Reset Badge value 1
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          badgeVal1 = '0';
                        });
                      }, 
                      child: const Text('Reset Badge value 1',style: TextStyle(color: white))
                    ),
                  ),
                  //Reset Badge value 2
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical :8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: ()async{
                        setState(() {
                          badgeVal2 = '0';
                        });
                      }, 
                      child: const Text('Reset Badge value 2',style: TextStyle(color: white))
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: UltimateBottomNavBar(
        icons                              : icons,                                                                       // Icon list<Widget>
        titles                             : title,                                                                       // Title list<String>
        currentIndex                       : currentIndex,                                                                // Current selected index
        backgroundColor                    : backgroundColor,                                                             // NavBar BackGround Color [backgroundGradient ovrerides color]
        foregroundColor                    : white,                                                                       // NavBar ForeGround Color with Curve 
        foregroundStrokeBorderColor        : black,                                                                       // Nav Stroke Border Color [useShaderStroke = false , strokeBorderWidth != 0]
        backgroundStrokeBorderColor        : black,                                                                       // nav background stroke color [seems like when border width is 0.0 still shows the color but transparent solves it]
        backgroundStrokeBorderWidth        : backgroundStrokeBorderWidth,                                                 // Nav BackGround Stroke Border Width
        foregroundStrokeBorderWidth        : 2.0,                                                                         // Nav ForeGround Stroke Border Width  
        backgroundGradient                 : null,                                                                        // Nav background Gradient [No Gradient if Null Overrides backgroundColor if given]
        foreGroundGradientShader           : foreGroundGradientShader,                                                    // Nav ForeGround Gradient Shader [foregroundColor or foreGroundGradientShader determined by Bool useForeGroundGradient]
        
        selectedIconColor                  : red,                                                                         // Selected Item Icon Color
        selectedIconSize                   : 25,                                                                          // Selected Item Icon Size
        selectedTextSize                   : 10,                                                                          // Selected Item Text Size
        selectedTextColor                  : red,                                                                         // Selected Item Text Color
        unselectedIconColor                : black,                                                                       // UnSelected Item Icon Color
        unselectedIconSize                 : 25,                                                                          // UnSelected Item Icon Size
        unselectedTextSize                 : 10,                                                                          // UnSelected Item Text Size
        unselectedTextColor                : black,                                                                       // UnSelected Item Text Color

        strokeGradientShader               : strokeGradientShader,                                                        // ForeGround Stroke border Gradient Shader
        useForeGroundGradient              : useForeGroundGradient,                                                       // Gradient for ForeGround or Not
        showForeGround                     : showForeGround,                                                              // Show ForeGround or Not
        useShaderStroke                    : useShaderStroke,                                                             // Use Shadered Stroke Border or Not
        underCurve                         : underCurve,                                                                  // Under Curve or Upper Curve
        staticCurve                        : staticCurve,                                                                 // Static Curve or Dynamic Curve
        showCircleStaticMidItemStatic      : showCircleStaticMidItem,                                                     // Show or Not Show Circle for Mid Item If Static Curve

        midItemCircleColorStatic           : white,                                                                       // Color of a Mid item circle for static item  
        midItemCircleBorderColorStatic     : black,                                                                       // Color of a Mid item border circle for static item
        showMidCircleStatic                : false,                                                                       // Show/Hide Mid item circle for static item
        midCircleRadiusStatic              : 20.0,                                                                        // Radius for Mid Circle
        midCircleBorderRadiusStatic        : 2.0,                                                                         // Radius for Mid Circle Border
        customSelectedItemDecor            : customSelecteditem(),                                                        // Custom Selected Item Decor
        customUnSelectedItemDecor          : customUnselectedItem(),                                                      // Custom UnSelected Item Decor

        badgeData                          : [{'index': 1, 'value': badgeVal1},{'index': 4, 'value': badgeVal2}],         //Badge Data for Each Index with value
        badgeColor                         : red,                                                                         // Badge Color 
        badgeTextStyle                     : const TextStyle(color: white,fontSize: 8.0,overflow: TextOverflow.ellipsis), // Badge Text Style
        badgeCircleRadius                  : 8.0,                                                                         // Badge Circle Radius
        badgeTopPosition                   : 10.0,                                                                        // Badge Top Position
        badgeRightPosition                 : 16.0,                                                                        // Badge Right Position
        badgeBottomPosition                : null,                                                                        // Badge Bottom Position
        badgeLeftPosition                  : null,                                                                        // Badge Left Position

        animationType                      : Curves.ease,                                                                 // Index change animation curves
        animationDuration                  : const Duration(milliseconds: 500),                                           // Index Change Animation duration for curve only
        onTap                              : (index) async => onItemTapped(index),                                        // Custom OnTap CallBacks
      ),
    );
  }

  customSelecteditem() {
    return const CircleAvatar(
      backgroundColor: red,
      radius: 22.0,
      child: CircleAvatar(
        backgroundColor: black,
        radius: 20.0,
        child: SizedBox()
      )
    );
  }

  customUnselectedItem() {
    return const CircleAvatar(
      backgroundColor: black,
      radius: 22.0,
      child: CircleAvatar(
        backgroundColor: white,
        radius: 20.0,
        child: SizedBox()
      )
    );
  }

  void onItemTapped(int index) async{
    setState(() {
      currentIndex = index;
      //reset on Tap Badge Value
      // if(index==1){
      //   badgeVal1='0';
      // }
    });
  }
}