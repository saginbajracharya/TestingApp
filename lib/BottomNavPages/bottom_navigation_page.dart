import 'package:flutter/material.dart';
import '../CurvedNavigationBar/curved_navigation_bar.dart';
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

  final List<Widget> icons = [
    const Icon(
      Icons.favorite, 
      color: Colors.white,
    ),
    const Icon(
      Icons.home, 
      color: Colors.white,
    ),
    const Icon(
      Icons.wallet, 
      color: Colors.white,
    ),
    const Icon(
      Icons.ac_unit_outlined, 
      color: Colors.white,
    ),
    const Icon(
      Icons.access_alarm_rounded, 
      color: Colors.white,
    )
  ];

  final List pages = [
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
    const Page5(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: blue.withOpacity(0.6),
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        icons: icons, //icon list<Widget>
        titles: title, //title list<String>
        letIndexChange: true, // true on tap items change index else not change index
        currentIndex: currentIndex, // current selected index
        backgroundColor: transparent, // Nav BackGround Color
        foregroundColor: black, // Nav ForeGround Color 
        strokeBorderColor: red, // Nav Stroke Border Color [useShaderStroke = false , strokeBorderWidth != 0]
        backgroundStrokeBorderColor: transparent, // nav background stroke color [seems like when border width is 0.0 still shows the color but transparent solves it]
        backgroundStrokeBorderWidth: 0.0, // Nav BackGround Stroke Border Width
        foregroundStrokeBorderWidth: 2.0, // Nav ForeGround Stroke Border Width  
        backgroundGradient: null, // Nav background Gradient [No Gradient if Null]
        // ForeGround Gradient Shader 
        foreGroundGradientShader : const LinearGradient(
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
        ).createShader(Rect.fromCenter(center: const Offset(0.0,0.0), height: 200, width: 100)),
        // ForeGround Stroke border Gradient Shader
        strokeGradientShader : const LinearGradient(
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
        ).createShader(Rect.fromCenter(center: const Offset(0.0,0.0), height: 200, width: 100)),
        useForeGroundGradient: true,
        showForeGround: true,
        useShaderStroke: false,
        underCurve: true,
        staticCurve: true,
        //[Selected btn values ok for DYNAMIC upper and under curve]
        //[Selected btn values not ok for STATIC upper and under curve]
        selectedButtonBottomPosition: 14.0,
        selectedButtonTopPosition: 0.0,
        selectedButtonElevation: 1,
        animationType: Curves.ease, // Index change animation curves
        animationDuration: const Duration(milliseconds: 5000), //Index Change Animation duration
        onTap: (index) async{
          onItemTapped(index);
        },
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}