import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:testingapp/CurvedNavigationBar/curved_navigation_bar.dart';
import 'package:testingapp/notification_service.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter/services.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'barcode_scanner_with_zoom.dart';
import 'mobile_scanner_widget.dart';
import 'utils/styles.dart';

void main() {
  initilize();
  runApp(const MyApp());
}

initilize(){
  initializeTimeZones();
  final location = getLocation('Asia/Kolkata');
  final now = TZDateTime.now(location);
  log(location.toString());
  log(now.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notificationsServices = NotificationService();
  var currentIndex = 0;

  final List pagesAppBarTitle = [
    "Favourite",
    "Home",
    "Wallet",
    "AC",
    "Alarm"
  ];

  final List pages = [
    const Center(
      child: Text("Favourite"),
    ),
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Wallet"),
    ),
    const Center(
      child: Text("AC"),
    ),
    const Center(
      child: Text("Alarm"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    notificationsServices.initialiseNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black.withOpacity(0.6),
      appBar: AppBar(
        backgroundColor: transparent,
        centerTitle: true,
        title: Text(pagesAppBarTitle[currentIndex]),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: pages[currentIndex],
          ),
          SliverFillRemaining(
            hasScrollBody: false, // Fixes Scroll Overflow
            child: buttonList(),
          ),
        ],
      ),
      // bottomNavigationBar: ConvexAppBar(
      //   style: TabStyle.fixed,
      //   items: const [
      //     TabItem(icon: Icons.list,title: 'list'),
      //     TabItem(icon: Icons.calendar_today,title: 'calaendar'),
      //     TabItem(icon: Icons.wallet,title: 'wallet'),
      //   ],
      //   initialActiveIndex: 1,
      //   onTap: (int i) => log('click index=$i'),
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        //List of Icons
        icons: const <Widget>[
          Icon(
            Icons.favorite, 
            color: Colors.white,
          ),
          Icon(
            Icons.home, 
            color: Colors.white,
          ),
          // Icon(
          //   Icons.wallet, 
          //   color: Colors.white,
          // ),
          Icon(
            Icons.ac_unit_outlined, 
            color: Colors.white,
          ),
          Icon(
            Icons.access_alarm_rounded, 
            color: Colors.white,
          )
        ],
        //List of Titles
        titles: <RichText>[
          RichText(
            text: const TextSpan(
              text: 'Favourite',
              style: TextStyle(color: Colors.yellow,fontSize: 10),
            ),
          ),
          RichText(
            text: const TextSpan(
              text: 'Home',
              style: TextStyle(color: Colors.yellow,fontSize: 10),
            ),
          ),
          RichText(
            text: const TextSpan(
              text: 'Wallet',
              style: TextStyle(color: Colors.yellow,fontSize: 10),
            ),
          ),
          RichText(
            text: const TextSpan(
              text: 'AC',
              style: TextStyle(color: Colors.yellow,fontSize: 10),
            ),
          ),
          RichText(
            text: const TextSpan(
              text: 'Alarm',
              style: TextStyle(color: Colors.yellow,fontSize: 10),
            ),
          ),
        ],
        height: kBottomNavigationBarHeight, // height of the bottom Nav Bar
        width: MediaQuery.of(context).size.width, // width of the bottom Nav Bar 
        letIndexChange: true, // true on tap items change index else not change index
        currentIndex: currentIndex, // current selected index
        backgroundColor: red, // Nav BackGround Color
        foregroundColor: black, // Nav ForeGround Color 
        strokeBorderColor: red, // Nav Stroke Border Color [useShaderStroke = false , strokeBorderWidth != 0]
        backgroundStrokeBorderColor: yellow, // nav background stroke color
        backgroundStrokeBorderWidth: 1.0, // Nav BackGround Stroke Border Width
        foregroundStrokeBorderWidth: 1.0, // Nav ForeGround Stroke Border Width  
        backgroundGradient: null,
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
        showForeGround: false,
        useShaderStroke: false,
        underCurve: false,
        staticCurve: true,
        selectedButtonBottomPosition: 14.0,
        selectedButtonTopPosition: 0.0,
        selectedButtonElevation: 1,
        animationType: Curves.ease, // Index change animation curves
        animationDuration: const Duration(milliseconds: 1000), //Index Change Animation duration
        onTap: (index) {
          onItemTapped(index);
        },
      ),
    );
  }

  buttonList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(transparent), // Change the color here
            ),
            onPressed: () async {
              notificationsServices.sendNotification(
                'title', 
                'body'
              );
            },
            child: const Text('Instant Notification'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(transparent), // Change the color here
            ),
            onPressed: () async {
              notificationsServices.secheduleNotification(
                'Scheduled Every Minute',
                'Scheduled Every Minute Body'
              );
            },
            child: const Text('Schedule Notification'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(transparent), // Change the color here
            ),
            onPressed: () async {
              notificationsServices.stopNotification();
            },
            child: const Text('Cancle Notification'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(transparent), // Change the color here
            ),
            onPressed: () async {
              try {
                // Copy OCR language file
                var languageFolder = await copyLanguageFile();
                // Initialize with your licence key
                // await FlutterGeniusScan.setLicenceKey('REPLACE_WITH_YOUR_LICENCE_KEY')
                // Start scan flow
                var scanConfiguration = {
                  'source': 'camera',
                  'multiPage': true,
                  'ocrConfiguration': {
                    'languages': ['eng'],
                    'languagesDirectoryUrl': languageFolder.path
                  }
                };
                var scanResult = await FlutterGeniusScan.scanWithConfiguration(scanConfiguration);
                // Here is how you can display the resulting document:
                String documentUrl = scanResult['multiPageDocumentUrl'];
                await OpenFile.open(documentUrl.replaceAll("file://", ''));
                // You can also generate your document separately from selected pages:
                /*
                var appFolder = await getApplicationDocumentsDirectory();
                var documentUrl = appFolder.path + '/mydocument.pdf';
                var document = {
                  'pages': [{
                    'imageUrl': scanResult['scans'][0]['enhancedUrl'] ,
                    'hocrTextLayout': scanResult.['scans'][0].['ocrResult'].['hocrTextLayout']
                  }]
                };
                var documentGenerationConfiguration = { 'outputFileUrl': documentUrl };
                await FlutterGeniusScan.generateDocument(document, documentGenerationConfiguration);
                await OpenFile.open(documentUrl);
                */
              } on PlatformException catch (error) {
                displayError(context, error);
              }
            },
            child: const Text("START SCANNING"),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(transparent), // Change the color here
            ),
            onPressed: () async {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MobileScannerWidget()),
              );
            },
            child: const Text("Mobile Scanner"),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(transparent), // Change the color here
            ),
            onPressed: () async {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BarcodeScannerWithZoom()),
              );
            },
            child: const Text("Mobile Scanner with zoom"),
          )
        ],
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      if(index==0){
      }
      else if(index==1){
      }
      else if(index==2){
      }
    });
  }

  Future<Directory> copyLanguageFile() async {
    Directory languageFolder = await getApplicationSupportDirectory();
    File languageFile = File("${languageFolder.path}/eng.traineddata");
    if (!languageFile.existsSync()) {
      ByteData data = await rootBundle.load("assets/eng.traineddata");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await languageFile.writeAsBytes(bytes);
    }
    return languageFolder;
  }

  void displayError(BuildContext context, PlatformException error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message!)));
  }
}
