import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/presentation/auth/signup_screenbankid/signup_screenbankid.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/auth/login_screen/login_screen.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get.dart';

import '../../../../socket_service/socket_service.dart';
import '../../../dashboard_screen/dashboard_screen.dart';


class  SignUpController extends GetxController {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();


  RxBool isLoading = false.obs;
  RxBool isShowPassword = false.obs;
  RxBool isShowCPassword = false.obs;
  Rx<bool> isLoading2 = false.obs;
  final RxInt bankIdToggle = 0.obs;



   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
  }


    signUp()async{
      isLoading(true);
     bool issingUp = await ApiRepository.signUpWithEmailPassword(
       email: emailController.text,
       password: passwordController.text,
       fullname: fullNameController.text,
       username: userNameController.text, );
      isLoading(false);
      if(issingUp){
       Get.offAll(()=> const LoginScreen());
     }








    }

  // Future<void> loginWithBankID(name,personalNumber) async {
  //   isLoading2(true);
  //   bool login = await ApiRepository.loginWithBankID(namestr: name, personalNumberstr: personalNumber);
  //   isLoading2(false);
  //   if (login) {
  //     SocketService().socketDisconnect();
  //     SocketService().socketConnect();
  //     Get.offAll(() => const DashBoardScreen());
  //   }
  // }









}
