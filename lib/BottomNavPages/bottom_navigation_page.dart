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
  bool staticCurve             = false;
  bool useForeGroundGradient   = false;
  bool showForeGround          = true;
  bool useShaderStroke         = false;
  bool underCurve              = true;
  bool showCircleStaticMidItem = true;   
  int currentIndex             = 0;

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
      backgroundColor: blue.withOpacity(0.6),
      body: Column(
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
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
                  child: const Text('Use Fore Ground Gradient',style: TextStyle(color: white))
                ),
                ElevatedButton(
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
                  child: const Text('Show Fore Ground',style: TextStyle(color: white))
                ),
                ElevatedButton(
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
                  child: const Text('Use Shader Stroke',style: TextStyle(color: white))
                ),
                ElevatedButton(
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
                  child: const Text('Under Curve',style: TextStyle(color: white))
                ),
                ElevatedButton(
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
                  child: const Text('Static Curve',style: TextStyle(color: white))
                )
              ],
            )
          ),
          Flexible(
            child: pages[currentIndex]
          )
        ],
      ),
      bottomNavigationBar: MultiNavigationBar(
        icons                        : icons,                                // Icon list<Widget>
        titles                       : title,                                // Title list<String>
        letIndexChange               : true,                                 // On Tap Icon if true => changes index , False => dose not changes index
        currentIndex                 : currentIndex,                         // Current selected index
        backgroundColor              : transparent,                          // NavBar BackGround Color [backgroundGradient ovrerides color]
        foregroundColor              : white,                                // NavBar ForeGround Color with Curve 
        foregroundStrokeBorderColor  : black,                                // Nav Stroke Border Color [useShaderStroke = false , strokeBorderWidth != 0]
        backgroundStrokeBorderColor  : black,                                // nav background stroke color [seems like when border width is 0.0 still shows the color but transparent solves it]
        backgroundStrokeBorderWidth  : 0.0,                                  // Nav BackGround Stroke Border Width
        foregroundStrokeBorderWidth  : 2.0,                                  // Nav ForeGround Stroke Border Width  
        backgroundGradient           : null,                                 // Nav background Gradient [No Gradient if Null Overrides backgroundColor if given]
        foreGroundGradientShader     : foreGroundGradientShader,             // Nav ForeGround Gradient Shader [foregroundColor or foreGroundGradientShader determined by Bool useForeGroundGradient]
        
        selectedIconColor            : red,                                  // Selected Item Icon Color
        selectedIconSize             : 25,                                   // Selected Item Icon Size
        selectedTextSize             : 10,                                   // Selected Item Text Size
        selectedTextColor            : white,                                // Selected Item Text Color
        unselectedIconColor          : black,                                // UnSelected Item Icon Color
        unselectedIconSize           : 25,                                   // UnSelected Item Icon Size
        unselectedTextSize           : 10,                                   // UnSelected Item Text Size
        unselectedTextColor          : black,                                // UnSelected Item Text Color

        strokeGradientShader         : strokeGradientShader,                 // ForeGround Stroke border Gradient Shader
        useForeGroundGradient        : useForeGroundGradient,                // Gradient for ForeGround or Not
        showForeGround               : showForeGround,                       // Show ForeGround or Not
        useShaderStroke              : useShaderStroke,                      // Use Shadered Stroke Border or Not
        underCurve                   : underCurve,                           // Under Curve or Upper Curve
        staticCurve                  : staticCurve,                          // Static Curve or Dynamic Curve
        showCircleStaticMidItem      : showCircleStaticMidItem,              // Show or Not Show Circle for Mid Item If Static Curve

        midItemCircleColor           : white,                                // Color of a Mid item circle for static item  
        midItemCircleBorderColor     : black,                                // Color of a Mid item border circle for static item
        showMidCircleStatic          : true,                                 // Show/Hide Mid item circle for static item
        midCircleRadiusStatic        : 20.0,                                 // Radius for Mid Circle
        midCircleBorderRadiusStatic  : 2.0,                                  // Radius for Mid Circle Border

        animationType                : Curves.ease,                          // Index change animation curves
        animationDuration            : const Duration(milliseconds: 1000),   // Index Change Animation duration for curve only
        onTap                        : (index) async => onItemTapped(index), // Custom OnTap CallBacks
      ),
    );
  }

  void onItemTapped(int index) async{
    setState(() {
      currentIndex = index;
    });
  }
}