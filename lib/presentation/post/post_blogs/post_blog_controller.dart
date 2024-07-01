import 'package:flutter/material.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../auth/my_profile_view/my_profile_controller.dart';

class PostBolgController extends GetxController{

  MyProfileController myProfileController =Get.put(MyProfileController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tagcontroller.dispose();
    titleController.dispose();
    bodyController.dispose();
    locationController.dispose();
  }

  TextEditingController tagcontroller = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List<String> tags = [];
  CroppedFile? coverPhoto;


  RxBool isLoading =false.obs;

   Future<void> postBlog() async {
      isLoading.value =true;
      bool isPosted = await ApiRepository.postBlog(title: titleController.text, body:bodyController.text, tag: tags,blogPic:coverPhoto?.path );
      isLoading.value =false;
      if(isPosted){
        myProfileController.getProfile();
        Get.back();
      }
   }





}