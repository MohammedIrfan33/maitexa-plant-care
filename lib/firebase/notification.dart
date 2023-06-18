

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:plant_care/agriculture%20department/message.dart';


Future<void> handleBackGroundNotification(RemoteMessage message)async {
  print(message.notification?.title);

  

}
class FirebaseNotificatios{

  FirebaseMessaging messaging =  FirebaseMessaging.instance;

  Future<void> initNotification() async{
    await  messaging.requestPermission();

    FirebaseMessaging.onBackgroundMessage(handleBackGroundNotification);
  }

 }