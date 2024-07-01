import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/core/utils/initial_bindings.dart';
import 'package:frenly_app/presentation/auth/splash_screen/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'data/data_sources/local/app_localization.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'messaing_service/messaging_service.dart';

// ...


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );


 ///for notification
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      MessagingService.showSimpleNotification(
          title: message.notification?.title ?? "title",
          body: message.notification?.body ?? "bodynot",
          payload: payloadData);
    }
    print("Got a message in foreground==lin52");
  }


  );

  ///for notification end


  ///for crushAnalitics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);};
  PlatformDispatcher.instance.onError = (error, stack) {FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);return true;};
  ///for crushAnalitics  end



  runApp( const MyApp());


}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {




  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarIconBrightness:Brightness.dark,
    //   statusBarColor: Colors.white, //
    // ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalString(),
      // locale: const Locale('swe', 'SE'), //for setting localization strings
      // fallbackLocale: const Locale('se', 'SE'),
      locale: const Locale('en', 'US'), //for setting localization strings
      fallbackLocale: const Locale('en', 'US'),
      // Locale('en', 'US')
      title: 'friendlily',
     home: SplashScreen(),

     initialBinding: InitialBindings(),
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory
      ),
      // home:Demooooo(),
    );
  }
}




