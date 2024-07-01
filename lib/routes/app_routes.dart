import 'package:frenly_app/presentation/auth/splash_screen/binding/splash_binding.dart';
import 'package:frenly_app/presentation/auth/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import '../presentation/auth/onboard/onboard.dart';
import '../presentation/auth/signup_screen/biding/bidings.dart';
import '../presentation/auth/signup_screen/signup_screen.dart';


class AppRoutes {
  static const String SignUp = '/signup_screen';
  static const String OnBoardings = '/onboard';
  static const String splash = '/splash';

  static List<GetPage> pages = [
    GetPage(name: SignUp, page: () => const SignUpScreen(), bindings: [
      SignUpPageBinding(),
    ]),

    GetPage(name: OnBoardings, page: () => const OnBoard(),),
    GetPage(name: splash, page: () => SplashScreen(),binding: SplashBinding()),

  ];
}
