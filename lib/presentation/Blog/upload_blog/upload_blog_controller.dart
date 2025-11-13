import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_editing_controller.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../auth/my_profile_view/my_profile_controller.dart';

class UploadBolgController extends GetxController{

  @override
  void dispose() {
    super.dispose();
    tagcontroller.dispose();
    titleController.dispose();
    bodyController.dispose();
    locationController.dispose();
   // bodyQuillController.dispose();
    detectableCaptionTextEditingController.dispose();
    super.onClose();
  }

  RxString previewText = ''.obs; // 👈 for real-time text updates

  // Optional: update live preview
   updatePreview(String value) {
    previewText.value = value;
  }

  TextEditingController tagcontroller = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  // ── Rich-text controller (replaces bodyController) ───────
 // final quill.QuillController bodyQuillController = quill.QuillController.basic();



  // reactive preview text
  RxString titlePreview = ''.obs;
  RxString bodyPreview = ''.obs;

  // reactive font sizes (these are *preferred* sizes; AutoSizeText will shrink if needed)
  RxDouble titleFontSize = 22.0.obs;
  RxDouble bodyFontSize = 16.0.obs;


  List<String> tags = [];
  CroppedFile? coverPhoto;
  final detectableCaptionTextEditingController = DetectableTextEditingController(
    regExp: detectionRegExp(),
  );

  RxBool isLoading =false.obs;

  // preview update helpers
  void updateTitlePreview(String v) => titlePreview.value = v;
  void updateBodyPreview(String v) => bodyPreview.value = v;

  // font size controls
  void increaseTitleSize() => titleFontSize.value = (titleFontSize.value + 2).clamp(12.0, 48.0);
  void decreaseTitleSize() => titleFontSize.value = (titleFontSize.value - 2).clamp(10.0, 48.0);
  void increaseBodySize() => bodyFontSize.value = (bodyFontSize.value + 1).clamp(10.0, 28.0);
  void decreaseBodySize() => bodyFontSize.value = (bodyFontSize.value - 1).clamp(8.0, 28.0);

  // optional: set by slider
  void setTitleSize(double s) => titleFontSize.value = s.clamp(10.0, 48.0);
  void setBodySize(double s) => bodyFontSize.value = s.clamp(8.0, 28.0);


  Future<void> postBlog() async {
      isLoading.value =true;
      // Get HTML content
      String htmlBody = bodyController.text;

      // Optional: Get plain text
     // String plainText = htmlBody.replaceAll(RegExp(r'<[^>]*>'), '');

      bool isPosted = await ApiRepository.postBlog(
          title: titleController.text,
          body:bodyController.text,
         // body: htmlBody,
          tag:extractHashtags(detectableCaptionTextEditingController.text),
          blogPic:coverPhoto?.path
      );
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