import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/core/constants/my_app_url.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordController extends GetxController {

  TextEditingController emailforgetcontr = TextEditingController();

  RxBool isLoadig =false.obs;
  RxBool seePassword =true.obs;
  RxBool seePassword1 =true.obs;




  forgotPassword() async {
    isLoadig.value=true;
  bool sendLink = await   ApiRepository.forgotPassword(email: emailforgetcontr.text);
    if(sendLink){
      emailforgetcontr.clear();
      Get.back();
    }
    isLoadig.value=false;

  }


}