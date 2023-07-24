import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:goldvault/Constants/globalVaribles.dart';
import 'package:shared_preferences/shared_preferences.dart';

var loginid;

String token='';
// {receiver: 51, sender: 55, screen: chat_page}
FirebaseMessaging messaging = FirebaseMessaging.instance;

// const AndroidNotificationChannel channel = AndroidNotificationChannel('high_importance_channel',  'High Importance Notifications', importance: Importance.high, playSound: true);
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',  importance: Importance.high, playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
InitializationSettings initializationSettings = InitializationSettings(

  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  iOS: DarwinInitializationSettings(),
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('A bg message just showed up -=-=-=-=${message.notification?.title}');
  print('A bg message just showed up -=-=-=-=${message.notification?.body}');
  print('A bg message just showed up -=-=-=-=${message.data}');
  print( ' A bg message just showed up message${message.data['message']}');
  print( ' A bg message just showed up message${message.data['message'].runtimeType}');
  print( ' A bg message just showed up message   ${json.decode(message.data['message'])}');
var data = json.decode(message.data['message']);
print("dddd--------------${data['message']}");
  // var  data = message.data['message'][0]['message'];
  /*{message: {"result":"successful","post_id":"68","user_id":"8"
  ,"message":"Valeria Cardona like your post","key":"like your post new user"}}*/
  if(message.data['result']=='successful'){
    print(message.data['message']);
    try{
      // Navigator.push(
      //   MyGlobalKeys.navigatorKey.currentContext!,
      //   MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData: {}, orderid:message.data['order_id'],)),
      // );


    }catch(e){
      print('error in updating notifications count');
    }
  }
  else if(message.data['screen']=='withdrawal'){
    print('firebase notification baghhsid callled ');
    try{
      // Navigator.push(
      //   MyGlobalKeys.navigatorKey.currentContext!,
      //   MaterialPageRoute(builder: (context) =>  WalletPage(id:message.data['id'] ,)),
      // );


    }catch(e){
      print('error in updating notifications count');
    }
  }
}


class FirebasePushNotifications{




  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  // alert: true,
  // badge: true,
  // sound: true,
  // );
  ///step 1: Add this to main

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//   onSelectNotification: (payload)async{
//   print('the notification is selected $payload');
//   // {booking_id: 8, user_type: 3, user_id: 9, screen: booking}
//   if(payload!=null){
//   try{
//   Map data = jsonDecode(payload);
//   if(data['screen']=='booking'){
//   Map bookingInformation = await Webservices.getMap(ApiUrls.getBookingById + '${data['booking_id']}');
//   push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: BookingInformationPage(bookingInformation: bookingInformation));
//   }
//   }catch(e){
//   print('Error in catch block 332 $e');
//   }
//
//   }
// }
// await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  // alert: true,
  // badge: true,
  // sound: true,
  //
  // );
  // await FirebasePushNotifications.firebaseSetup();
  /// step 2:
  ///Create certificate Key from here
  /// https://console.firebase.google.com/project/cycle-up-338208/settings/cloudmessaging

  /// step 3 :
  /// get permission
  /// step 4 :
  /// get token and then store it to database, so that we can send notification to that specific
  /// android token.

  static const String webPushCertificateKey = 'BPE6NfMirgOcbGrnJJ-NvlXwMpRnWm_Df0UNwLSxFXshKgAUNF-HjNmbgye_knKsbZxmTEOQz6w10Mm9TVcibO4';
  /// this token is used to send notification // use the returned token to send messages to users from your custom server
  static String? token;



  static Future<NotificationSettings> getPermission()async{
    NotificationSettings settings = await messaging.requestPermission(

      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,

    );
    print('User granted permission: ${settings.authorizationStatus}');
    return settings;
  }


  static Future<String?> getToken()async{
    token = await messaging.getToken(
        vapidKey: webPushCertificateKey
    );
    return token;
  }


  static Future<void> firebaseSetup()async {
    // FirebaseMessaging.onBackgroundMessage((message)async{
    //   print)
    // })
    FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);

      print('firebase messaging is being listened');
      try{
        RemoteNotification? notification = message.notification;
        var data = message.data;

        // log('notidata+--'+data.toString());
        AndroidNotification? android = message.notification?.android;
        log('this is notification bb bb ---  ');
        print('___________${notification.toString()}');
        print('________________');
        print(message.data);
        print('________________');
        if (notification != null && android != null) {
          if(message.data['screen']=='withdrawal'){
            try{
              // if(MyGlobalKeys.tabBarKey2.currentState!=null)
              // wallet_id=message.data['id'];
              // if(message.data['user_type'].toString()=='1'){
              //   MyGlobalKeys.tabBarKey2.currentState!.onItemTapped(3);
              // }
              // else if(message.data['user_type'].toString()=='2'){
              //   MyGlobalKeys.tabBarKey.currentState!.onItemTapped(3);
              // }

            }catch(e){
              print('Error in catch block 342 $e');
            }
          }
          else if(message.data['screen']=='order'){
            // Navigator.push(
            //   MyGlobalKeys.navigatorKey.currentContext!,
            //   MaterialPageRoute(builder: (context) =>  ManageOrdersPage(orderData:{} ,orderid:message.data['order_id'].toString(),)),
            // );
          }


          // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;
          await flutterLocalNotificationsPlugin.show(

              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(

                  channel.id,
                  channel.name,
                  // channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
              payload:jsonEncode(data)
          );
          print('the payLoad is $data');
        }
      }catch(e){
        print('error in listening notifications $e');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
      await Firebase.initializeApp();

      print('A new onMessageOpenedApp event was published!');
      print(message.data);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      String title = "";
      log('this is notification aa aa ---  ');

      if(notification!=null){
        title = notification.title.toString();
      }
      if (notification != null && android != null) {
        log('this is notification ---  ');

        // try{
        //     BuildContext context = MyGlobalKeys.navigatorKey.currentContext!;
        //     // {booking_id: 6, user_type: 3, user_id: 9, screen: booking}
        //     if(message.data['screen']=='booking'){
        //       // Navigator.push(
        //       //   context,
        //       //   MaterialPageRoute(
        //       //     builder: (context) => ChatPage(
        //       //       toUserId:message.data['sender'], parkingId: '${message.data['parking_id']}',
        //       //
        //       //     ),
        //       //   ),
        //       // );
        //       // Map bookingInformation = await Webservices.getMap(ApiUrls.getBookingById + message.data['booking_id']);
        //       // push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: BookingInformationPage(bookingInformation: bookingInformation));
        //       // push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: BookingInformationPage(bookingInformation: bookingInformation));
        //     }
        //     // if(message.data['screen'] == 'parking_request'){
        //     //   print('it is a parking request');
        //     //   Navigator.push(
        //     //       context,
        //     //       MaterialPageRoute(
        //     //           builder: (context) => BookingInformationPage(
        //     //             parkingId: message.data['parking_id'],
        //     //             owner: true,
        //     //           )));
        //     // }else if(message.data['screen'] == 'booking_confirmation'){
        //     //   print('It is a booking confirmation request');
        //     //   Navigator.push(
        //     //       context,
        //     //       MaterialPageRoute(
        //     //           builder: (context) => BookingInformationPage(
        //     //             parkingId: message.data['parking_id'],
        //     //             // owner: true,
        //     //           )));
        //     // }
        //     else{
        //   print('Some other screen');
        //   print(message.data);
        // }
        //   }catch(e){
        //     print('Error in Inside catch block $e');
        //   }
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return AlertDialog(
        //         title: Text(title),
        //         content: SingleChildScrollView(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [Text(notification.body.toString())],
        //           ),
        //         ),
        //       );
        //     });

      }
    });

    FirebaseMessaging.instance.getToken().then((value)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loginid = prefs.getString("user_id");
      token=value.toString();
      print('device token---------------------- '+value.toString());
      tokenId=value!;
      print('device token---------------------- '+token.toString());



      if(value!=null){

      }

      // log("token-------"+value.toString());
    });

  }



}