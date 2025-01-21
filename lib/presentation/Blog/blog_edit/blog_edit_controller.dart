

import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../auth/my_profile_view/my_profile_controller.dart';

class BlogEditController extends GetxController{


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

  Future<void> updateBlog({required String id}) async {
    isLoading.value =true;
    bool isPosted = await ApiRepository.updateBlog(title: titleController.text, body:bodyController.text, tag: tags,blogPic:coverPhoto?.path,id: id );
    isLoading.value =false;
    if(isPosted){
      Get.find<MyProfileController>().getProfile();
      Get.back();
      Get.back();
      Get.back();
    }
  }





}