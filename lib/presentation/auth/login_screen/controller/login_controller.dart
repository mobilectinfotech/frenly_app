import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import '../../../dashboard_screen/dashboard_screen.dart';


class LoginController extends GetxController {

  TextEditingController emaillController = TextEditingController();
  TextEditingController passworddController = TextEditingController();
  Rx<bool> isShowPassword = true.obs;
  Rx<bool> isLoading = false.obs;

  @override
  void dispose() {
    emaillController.dispose();
    passworddController.dispose();
    super.dispose();
  }

  Future<void> loginWithEmail() async {
      isLoading(true);
    bool login = await ApiRepository.loginWithEmailPassword(email: emaillController.text, password: passworddController.text);
      isLoading(false);
      if (login) {
      Get.offAll(() => const DashBoardScreen());
    }
  }
}
