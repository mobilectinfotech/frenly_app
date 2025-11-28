import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import '../../../../socket_service/socket_service.dart';
import '../../../dashboard_screen/dashboard_screen.dart';


class LoginController extends GetxController {

  TextEditingController emaillController = TextEditingController();
  TextEditingController passworddController = TextEditingController();
  Rx<bool> isShowPassword = true.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLoading2 = false.obs;

  @override
  void dispose() {
    emaillController.dispose();
    passworddController.dispose();
    super.dispose();
  }

  Future<void> loginWithEmail() async {
      isLoading(true);
    bool login = await ApiRepository.loginWithEmailPassword(
        email: emaillController.text,
        password: passworddController.text
    );
      isLoading(false);
      if (login) {
        // SocketService().socketDisconnect();
        SocketService().socketConnect();
        print('.socketConnect().....LOGIN');
        Get.offAll(() => const DashBoardScreen());
    }
  }

}
