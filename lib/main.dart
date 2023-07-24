import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:goldvault/Language/LocalString.dart';
import 'package:goldvault/Screens/Splash.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'Constants/firebasesetup.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse : (payload)async{
        print('the notification is selected ${payload}');
        // {booking_id: 8, user_type: 3, user_id: 9, screen: booking}
        if(payload!=null){
          try{
            Map data = jsonDecode(payload.toString());
            if(data['screen']=='withdrawal'){
              try{
                // // if(MyGlobalKeys.tabBarKey2.currentState!=null)
                // wallet_id=data['id'];
                // if(data['user_type'].toString()=='1'){
                //   MyGlobalKeys.tabBarKey2.currentState!.onItemTapped(3);
                // }
                // else if(data['user_type'].toString()=='2'){
                //   MyGlobalKeys.tabBarKey.currentState!.onItemTapped(3);
                // }

              }catch(e){
                print('Error in catch block 342 $e');
              }
            }
            else if(data['screen']=='order'){
              // Navigator.push(
              //   MyGlobalKeys.navigatorKey.currentContext!,
              //   MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:{} ,orderid:data['order_id'].toString(),)),
              // );
            }
          }catch(e){
            print('Error in catch block 332 $e');
          }

        }
      });
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(

    alert: true,
    badge: true,
    sound: true,
  );
  await FirebasePushNotifications.firebaseSetup();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      locale: Locale('en', 'US'),
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   Locale('en', 'US'), // English
      //   Locale('fr', 'FR'), // French
      //   // Add more supported locales as needed
      // ],
      home: Splash(),
    );
  }
}
