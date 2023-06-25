import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/barcode_scanner_with_zoom.dart';
import '../widgets/mobile_scanner_widget.dart';
import '../services/notification_service.dart';
import '../utils/styles.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  NotificationService notificationsServices = NotificationService();
  bool isListenerOn = false;

  @override
  void initState() {
    setBluetoothPermission();
    super.initState();
  }

  setBluetoothPermission() async {
    await Permission.bluetooth.request().isGranted;
    log("permission");
  }
  
  @override
  Widget build(BuildContext context) {
    return const Text("PAGE 3",style: TextStyle(color: black,fontSize: 40.0));
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
              backgroundColor: MaterialStateProperty.all<Color>(grey), // Change the color here
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
              backgroundColor: MaterialStateProperty.all<Color>(grey), // Change the color here
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
              backgroundColor: MaterialStateProperty.all<Color>(grey), // Change the color here
            ),
            onPressed: () async {
              notificationsServices.stopNotification();
            },
            child: const Text('Cancle Notification'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(grey), // Change the color here
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
              backgroundColor: MaterialStateProperty.all<Color>(grey), // Change the color here
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
              backgroundColor: MaterialStateProperty.all<Color>(grey), // Change the color here
            ),
            onPressed: () async {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BarcodeScannerWithZoom()),
              );
            },
            child: const Text("Mobile Scanner with zoom"),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(grey), // Change the color here
            ),
            onPressed: () async {
              
            },
            child: const Text("Bluetooth On/Off"),
          ),
        ],
      ),
    );
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