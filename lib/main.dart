import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:plant_care/wel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.getInitialMessage();

NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);
  
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomePage(),
  ));
}

