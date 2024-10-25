import 'package:flutter/material.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import '../blog_model.dart';

class BlogViewController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  late BuildContext context;


  BlogModel blogModel= BlogModel();

  RxBool isLoading =false.obs;

  getBlogById({required String id,bool ? isLoadingg})async{
    if(isLoadingg == null){
      isLoading.value=true;
    }
    blogModel = await ApiRepository.getBlogBYId( blogId: id);
    isLoading.value =false;
  }

}