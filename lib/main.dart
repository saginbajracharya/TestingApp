import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:testingapp/services/notification_service.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';
import 'BottomNavPages/bottom_navigation_page.dart';

void main() {
  initilize();
  runApp(const Main());
}

initilize(){
  initializeTimeZones();
  final location = getLocation('Asia/Kathmandu');
  final now = TZDateTime.now(location);
  log(location.toString());
  log(now.toString());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  NotificationService notificationsServices = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationsServices.initialiseNotification();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationPage()
    );
  }
}
