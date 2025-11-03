import 'package:flutter/cupertino.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:io';
import '../../auth/my_profile_view/my_profile_controller.dart';

class UploadVlogController extends GetxController{


  TextEditingController titleController =TextEditingController();
  TextEditingController desController =TextEditingController();
  XFile? pikedVideo ;

  RxBool isLoading = false.obs;

  postVlog() async {
    isLoading.value = true;

    // Get the file size before compression
    File originalVideoFile = File(pikedVideo!.path);
    int originalSize = await originalVideoFile.length();
    print("Original Video Size: ${originalSize / 1024 / 1024} MB"); // Convert to MB

    // Compress the video
    MediaInfo? compressedVideo = await VideoCompress.compressVideo(
      pikedVideo!.path,
      quality: VideoQuality.MediumQuality, // You can change the quality based on your needs
      deleteOrigin: false, // Keep the original video if needed
    );

    // Proceed with the upload
    bool isPost = false;

    // Check if compression was successful
    if (compressedVideo != null) {
      // Get the file size after compression
      File compressedFile = File(compressedVideo.file!.path);
      int compressedSize = await compressedFile.length();
      print("Compressed Video Size: ${compressedSize / 1024 / 1024} MB"); // Convert to MB

      // Upload the compressed video
      isPost = await ApiRepository.postVlog(
          photoPath: compressedFile.path,
          title: titleController.text,
          des: desController.text
      );
    } else {
      // If compression failed, use the original video
      print("Video compression failed, uploading the original video.");

      // Upload the original video
      isPost = await ApiRepository.postVlog(
          photoPath: originalVideoFile.path,
          title: titleController.text,
          des: desController.text
      );
    }

    // Reset the loading state
    isLoading.value = false;

    if (isPost) {
      if (Get.isRegistered<MyProfileController>()) {
        Get.find<MyProfileController>().getProfile(); // Update profile
      }
      Get.back();
    } else {
      print("Video upload failed.");
    }
  }


  editVlog()async{
    isLoading.value=true;
    bool isPost = await ApiRepository.updateVlog(id: '', title: '', body: '', );
    isLoading.value=true;
    if(isPost){
      if(Get.isRegistered<MyProfileController>()) {
        Get.find<MyProfileController>().getProfile(); //done
      }

      Get.back();
    }
  }

}