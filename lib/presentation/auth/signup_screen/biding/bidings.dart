import 'package:get/get.dart';

import '../controller/signup_controller.dart';

/// A binding class for the SignUpPageScreen.
///
/// This class ensures that the SignUpPageController is created when the
/// SignUpPageScreen is first loaded.
class SignUpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}


class OnBoardBinding extends Bindings {
  @override
  void dependencies() {
  // Get.lazyPut(() => SignUpController());
  }
}
