import 'package:flutter/cupertino.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/my_profile_view/my_profile_controller.dart';
class EditVlogController extends GetxController{

  MyProfileController myProfileController =Get.put(MyProfileController());

  TextEditingController titleController =TextEditingController();
  TextEditingController desController =TextEditingController();
  XFile? pikedVideo ;

  RxBool isLoading = false.obs;


  editVlog({
    String ? videopath,
    required String title,
    required String des,
    required String id,
  })async{
    isLoading.value=true;
    bool isPost = await ApiRepository.updateVlog(id: id, title: title, body: des,blogPic: videopath );
    isLoading.value=true;
    if(isPost){
      myProfileController.getProfile();
      Get.back();
    }
  }

}