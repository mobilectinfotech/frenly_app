import 'package:flutter/material.dart';
import 'package:frenly_app/data/models/GetBlogByIdModel.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';

class BlogFullViewController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  late BuildContext context;


  GetBlogByIdModel blogByIdModel= GetBlogByIdModel();

  RxBool isLoading =false.obs;

  getBlogById({required String id,bool ? isLoadingg})async{
    if(isLoadingg == null){
      isLoading.value=true;
    }
    blogByIdModel = await ApiRepository.getBlogBYId( blogId: id);
    isLoading.value =false;
  }


}