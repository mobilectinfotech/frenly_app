import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



class ForgetPassword extends GetxController {

  TextEditingController passwordCp = TextEditingController();
  TextEditingController repasswordCp = TextEditingController();

  RxBool isLoadig =false.obs;
  RxBool seePassword =true.obs;
  RxBool seePassword1 =true.obs;


  @override
  void onReady() {
    super.onReady();
  }


}