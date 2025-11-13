import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class MessagingService {
  static String? fcmToken; // Variable to store the FCM token
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final MessagingService _instance = MessagingService._internal();

  factory MessagingService() => _instance;

  MessagingService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        // me.pushToken = t;
       // log('Push Token: $t');
      }
    });
  }
  Future<void> init(BuildContext context) async {
    getFirebaseMessagingToken();
    // Requesting permission for notifications
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted notifications permission: ${settings.authorizationStatus}');

    // Retrieving the FCM token
    fcmToken = await _fcm.getToken();
    // log('fcmToken: $fcmToken');

    // Handling background messages using the specified handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


    // Handling the initial message received when the app is launched from dead (killed state)
    // When the app is killed and a new notification arrives when user clicks on it
    // It gets the data to which screen to open
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(context, message);
        print("mess1234${message.notification!.title.toString()}");
      }
    });

    // Handling a notification click event when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('onMessageOpenedApp: ${message.notification!.title.toString()}');
      _handleNotificationClick(context, message);
    });
  }

  // Handling a notification click event by navigating to the specified screen
  void _handleNotificationClick(BuildContext context, RemoteMessage message) {
    final data = message.data;

    // print("qwertyio${data["screen"]}");
    // if("${data["screen"]}" =="matches"){
    //   print("pramodqwertyuytrewerty${data["sender_id"]}");
    //   Get.to(()=>const MatchesRequestPages());
    // }
    // if("${data["screen"]}" =="like"){
    //   Get.to(()=>MyAllDatesPage());
    // }if("${data["screen"]}" =="business_like"){
    //   Get.to(()=>const BuisnessHomePage());
    // } if("${data["screen"]}" =="business_comment"){
    //   Get.to(()=>const BuisnessHomePage());
    // }if("${data["screen"]}" =="chat"){
    //   Get.to(()=>const HomeScreen());
    // }
    // if("${data["screen"]}" =="comment"){
    //   Get.to(()=>const NotificationPage());
    // }
    // if("${data["screen"]}" =="invite_date"){
    //   Get.to(()=>const MyAllDatesPage());
    // }
    // if("${data["screen"]}" =="review"){
    //   Get.to(()=>MatchDetails(id:'${data["reciver_id"]}', isfriend: true,));
    // }
    // if("${data["screen"]}" =="invite_accept"){
    //   Get.to(()=> const MyAllDatesPage());
    // }
    // if("${data["screen"]}" =="Tag_you"){
    //   Get.to(()=>MyAllDatesPage());
    // }
    // if("${data["screen"]}" =="accept_your_classified_request"){
    //   Get.to(()=>MyAllDatesPage());
    // }
    // if("${data["screen"]}" =="accept_your_classified_request"){
    //   Get.to(()=>MyAllDatesPage());
    // }

  }




////////////////////local notification   start

  // show a simple notification
  static Future  showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
  }




  // initalize local notifications
  static Future localNotiInit(BuildContext context) async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      // onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    const LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }
  static void onNotificationTap(NotificationResponse notificationResponse) {
    print(notificationResponse.payload);
    try{

      print("qwerty");
      Map data = jsonDecode(notificationResponse.payload.toString());

      print("1234${data}");
      print("qwertyio${data["screen"]}");
      print("1234${data}");

      //
      // if("${data["screen"]}" =="matches"){
      //   print("pramodqwertyuytrewerty${data["sender_id"]}");
      //   Get.to(()=>const MatchesRequestPages());
      // }
      // if("${data["screen"]}" =="like"){
      //   Get.to(()=>MyAllDatesPage());
      // }if("${data["screen"]}" =="business_like"){
      //   Get.to(()=>const BuisnessHomePage());
      // } if("${data["screen"]}" =="business_comment"){
      //   Get.to(()=>const BuisnessHomePage());
      // }if("${data["screen"]}" =="chat"){
      //   Get.to(()=>const HomeScreen());
      // }
      // if("${data["screen"]}" =="comment"){
      //   Get.to(()=> HomePageUser());
      // }
      // if("${data["screen"]}" =="invite_date"){
      //   Get.to(()=>const MyAllDatesPage());
      // }
      // if("${data["screen"]}" =="review"){
      //   Get.to(()=>MatchDetails(id:'${data["reciver_id"]}', isfriend: true,));
      // }
      // if("${data["screen"]}" =="invite_accept"){
      //   Get.to(()=>MyAllDatesPage());
      // }
      // if("${data["screen"]}" =="Tag_you"){
      //   Get.to(()=>MyAllDatesPage());
      // }
      // if("${data["screen"]}" =="accept_your_classified_request"){
      //   Get.to(()=>MyAllDatesPage());
      // }
      // if("${data["screen"]}" =="accept_your_matches_request"){
      //   Get.to(()=>MyAllDatesPage());
      // }

    }catch(e){
      print("qwertyio${e}");
    }
  }
}

// Handler for background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Minimaig  Handling a background message: ${message.notification!.title}');

  // Navigator.of(context).pushNamed(screen);

}