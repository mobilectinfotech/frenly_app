import 'package:flutter/material.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../auth/my_profile_view/my_profile_controller.dart';

class PostPostController extends GetxController{


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    captionController.dispose();
  }

  TextEditingController captionController = TextEditingController();

  CroppedFile? coverPhoto;

  RxBool isLoading =false.obs;
   Future<void> postPost() async {
      isLoading.value =true;
      bool isPosted = await ApiRepository.postPost(title: captionController.text, photoPath: '${coverPhoto!.path}' );
      isLoading.value =false;
      if(isPosted){
     //   Get.lazyPut(()=>MyProfileController());
        if(Get.isRegistered<MyProfileController>()) {
          Get.find<MyProfileController>().getProfile(); //asdasd
        }
        Get.back();

      }
   }





}