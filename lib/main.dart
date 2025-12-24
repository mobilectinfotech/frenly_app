import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/core/utils/initial_bindings.dart';
import 'package:frenly_app/core/utils/pref_utils.dart';
import 'package:frenly_app/presentation/auth/splash_screen/splash_screen.dart';
import 'package:frenly_app/socket_service/socket_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'LifeCycleManager/life_cycle_manager.dart';
import 'firebase_options.dart';
import 'localservice/local_service.dart';
import 'localservice/messages_local.dart';
import 'messaing_service/messaging_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(PrefUtils(),permanent: true);

 // Get.put(SettingsController(), permanent: true);
  final localeService = LocaleService();
  final locale = await localeService.getLocale();
  // FIX: Start socket globally

  await SocketService().socketConnect();
   print("Start socket globally");

  // REGISTER timeago languages
  // timeago.setLocaleMessages('en', timeago.EnMessages());
  // timeago.setLocaleMessages('sv', timeago.SvMessages());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize Firebase only once
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (!e.toString().contains("duplicate-app")) {
      rethrow; // only ignore duplicate-app error
    }
  }

  /// Request notification permission (Android 13+ and iOS)
  final isDenied = await Permission.notification.isDenied;
  if (isDenied) {
    await Permission.notification.request();
  }

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // ///for notification
  // await Permission.notification.isDenied.then((value) {
  //   if (value) {
  //     Permission.notification.request();
  //   }
  // });
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      MessagingService.showSimpleNotification(
          title: message.notification?.title ?? "title",
          body: message.notification?.body ?? "body",
          payload: payloadData);
    }
    print("Got a message in foreground==lin52");
  }
  );

  ///for notification end
  ///for crushAnalitics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // FlutterError.onError = (errorDetails) {FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);};
  // PlatformDispatcher.instance.onError = (error, stack) {FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);return true;};
  ///for crush Analitics end


  setupTimeagoLocales();
  runApp(MyApp(locale: locale));
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   /// Initialize SharedPreferences BEFORE put()
//   await PrefUtils.init();
//
//   /// Initialize GetStorage (if used)
//   // await GetStorage.init();
//
//   /// Setup socket later, after runApp
//    await SocketService().socketConnect();
//
//   /// Firebase first
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (_) {}
//
//   /// Notification permission
//   if (await Permission.notification.isDenied) {
//     await Permission.notification.request();
//   }
//
//   // timeago
//   setupTimeagoLocales();
//
//   // finally run the UI
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  final Locale? locale;
  MyApp({this.locale});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: LifeCycleManager(
        child: GetMaterialApp(
          localizationsDelegates: [DefaultMaterialLocalizations.delegate, ],
          debugShowCheckedModeBanner: false,
          translations: Messages(),
          locale: locale ?? const Locale('swe', 'SE'), // Default locale if no saved locale
          fallbackLocale:const  Locale('swe', 'SE'),
          // locale: locale ?? const Locale('en', 'US'), // Default locale if no saved locale
          // fallbackLocale:const  Locale('en', 'US'),
          title: 'Frenly',
          home: SplashScreen(),
         // home: Scaffold(body: VideoThumbnailPlayer(videoUrl: 'https://frenly.s3.amazonaws.com/1719924957051-3769033-sd_426_240_25fps.mp4')),
          initialBinding: InitialBindings(),
          theme: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory
          ),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: widget!,
            );
          },
        ),
      ),
    );
  }
}

void setupTimeagoLocales() {
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('swe', timeago.SvMessages());
}


// class PrefUtils {
//   static SharedPreferences? _prefs;
//
//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   SharedPreferences get prefs => _prefs!;
// }


///Priyanshu Update 24// oct // 29 Oct // 3rd Nov
// https://we.tl/t-VxvzWZEZFk

// jhonk@yopmail.com
// https://we.tl/t-PsH436A0Is

// flutter clean
// rm -rf ios/Pods ios/Podfile.lock
// pod cache clean --all
// flutter pub get
// cd ios
// pod deintegrate
// flutter build ios --config-only --release

///Today 18 deccc aajjhii