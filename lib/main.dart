import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/initial_bindings.dart';
import 'package:frenly_app/core/utils/pref_utils.dart';
import 'package:frenly_app/presentation/auth/splash_screen/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'LifeCycleManager/life_cycle_manager.dart';
import 'firebase_options.dart';
import 'localservice/local_service.dart';
import 'localservice/messages_local.dart';
import 'messaing_service/messaging_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(PrefUtils(),permanent: true);
  final localeService = LocaleService();
  final locale = await localeService.getLocale();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
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
  ///for crush Analitics end
  runApp(MyApp(locale: locale));
}

class MyApp extends StatelessWidget {
  final Locale? locale;
  MyApp({this.locale});

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: Messages(),
        locale: locale ?? const Locale('swe', 'SE'), // Default locale if no saved locale
        fallbackLocale:const  Locale('swe', 'SE'),
        title: 'Frenly',
        home: SplashScreen(),
        initialBinding: InitialBindings(),
        theme: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory
        ),
        // home:Demooooo(),s
      ),
    );
  }
}
//updated

