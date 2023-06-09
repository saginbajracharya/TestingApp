import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:testingapp/curved_navigation_bar.dart';
import 'package:testingapp/notification_service.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter/services.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'barcode_scanner_with_zoom.dart';
import 'mobile_scanner_widget.dart';

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

  @override
  void initState() {
    super.initState();
    notificationsServices.initialiseNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Testing App'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false, // Fixes Scroll Overflow
            child: buttonList(context),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        currentIndex: currentIndex, // current selected index
        backgroundColor: Colors.transparent, // nav button behind background
        navBarColor: Colors.blue, // nav background
        letIndexChange: (index) => true, // true on tap items change index else not change index
        navBarHeight: kBottomNavigationBarHeight, // height of the bottom Nav Bar
        navBarWidth: MediaQuery.of(context).size.width, // width of the bottom Nav Bar 
        strokeBorderWidth: 2, // Nav bar Stroke Width 
        strokeBorderColor: Colors.red, //stroke border color if useShaderStroke is false else uses shader
        strokeGradientShader:const LinearGradient(
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
        animationCurve: Curves.slowMiddle, // Index change animation curves
        animationDuration: const Duration(milliseconds: 200), //Index Change Animation duration
        showForeGround: true,
        useShaderStroke: false,
        selectedButtonHeight: 10.0,
        selectedButtonElevation: 1,
        useForeGroundGradient: true,
        backgroundStrokeBorderColor: Colors.transparent,
        backgroundStrokeBorderWidth: 1,
        backgroundStrokeBorderStyle: BorderStyle.solid,
        items: const <Widget>[
          Icon(
            Icons.favorite, 
            color: Colors.white,
          ),
          Icon(
            Icons.home, 
            color: Colors.white,
          ),
          Icon(
            Icons.wallet, 
            color: Colors.white,
          ),
          Icon(
            Icons.ac_unit_outlined, 
            color: Colors.white,
          ),
          Icon(
            Icons.access_alarm_rounded, 
            color: Colors.white,
          ),
          // Icon(
          //   Icons.access_time_filled, 
          //   color: Colors.white,
          // ),
          // Icon(
          //   Icons.account_balance_rounded, 
          //   color: Colors.white,
          // ),
          // Icon(
          //   Icons.zoom_out_map_rounded, 
          //   color: Colors.white,
          // ),
          // Icon(
          //   Icons.wrap_text_outlined, 
          //   color: Colors.white,
          // ),
          // Icon(
          //   Icons.window_outlined, 
          //   color: Colors.white,
          // ),
          // Icon(
          //   Icons.webhook_sharp, 
          //   color: Colors.white,
          // ),
        ],
        onTap: (index) {
          onItemTapped(index);
        },
      ),
    );
  }

  Widget buttonList(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton(
            onPressed: () async {
              notificationsServices.sendNotification(
                'title', 
                'body'
              );
            },
            child: const Text('Instant Notification'),
          ),
          ElevatedButton(
            onPressed: () async {
              notificationsServices.secheduleNotification(
                'Scheduled Every Minute',
                'Scheduled Every Minute Body'
              );
            },
            child: const Text('Schedule Notification'),
          ),
          ElevatedButton(
            onPressed: () async {
              notificationsServices.stopNotification();
            },
            child: const Text('Cancle Notification'),
          ),
          ElevatedButton(
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
            onPressed: () async {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MobileScannerWidget()),
              );
            },
            child: const Text("Mobile Scanner"),
          ),
          ElevatedButton(
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
