import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_editing_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../auth/my_profile_view/my_profile_controller.dart';

class UploadPostController extends GetxController{

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    detectableCaptionTextEditingController.dispose();
  }

  //TextEditingController captionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController gpsLocController = TextEditingController();

  // final detectableCaptionTextEditingController = DetectableTextEditingController(
  //   regExp: detectionRegExp(),
  // );
  final detectableCaptionTextEditingController = DetectableTextEditingController(
    regExp: RegExp(
      r"(#\p{L}[\p{L}\p{M}\p{N}_]*)",
      unicode: true,
    ),
  );


  String? lat;
  String? lng;


  CroppedFile? coverPhoto;
  RxBool isLoading =false.obs;

   Future<void> postPost() async {
      isLoading.value =true;
      bool isPosted = await ApiRepository.postPost(
          title: detectableCaptionTextEditingController.text,
          photoPath: '${coverPhoto!.path}',
         location: locationController.text.trim(),
      );
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