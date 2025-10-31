import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_editing_controller.dart';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../auth/my_profile_view/my_profile_controller.dart';

class UploadBolgController extends GetxController{


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

  final detectableCaptionTextEditingController = DetectableTextEditingController(
    regExp: detectionRegExp(),
  );


  RxBool isLoading =false.obs;

   Future<void> postBlog() async {

      isLoading.value =true;
      bool isPosted = await ApiRepository.postBlog(
          title: titleController.text,
          body:bodyController.text,
          tag:  extractHashtags(detectableCaptionTextEditingController.text),
          blogPic:coverPhoto?.path );
      isLoading.value =false;
      if(isPosted){
        if(Get.isRegistered<MyProfileController>()) {
          Get.find<MyProfileController>().getProfile(); //done
        }
        Get.back();
      }
   }


  List<String> extractHashtags(String inputString) {
    // Split the input string into words
    List<String> words = inputString.split(" ");

    // Filter the words that start with a hashtag, remove the hashtag, and return the list
    List<String> hashtags = words
        .where((word) => word.startsWith("#"))  // Filter words with hashtags
        .map((word) => word.substring(1))      // Remove the '#' character
        .toList();

    return hashtags;
  }




}