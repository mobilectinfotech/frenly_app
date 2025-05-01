import 'package:get/get.dart';

import '../controller/signupbankid_controller.dart';
import '../signup_screenbankid.dart';

/// A binding class for the SignUpPageScreen.
///
/// This class ensures that the SignUpPageController is created when the
/// SignUpPageScreen is first loaded.
class SignUpBankidPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpBankidController>(() => SignUpBankidController());
  }
}


