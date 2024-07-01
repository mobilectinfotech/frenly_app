import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';

import 'PopularBlogModel.dart';
class PopularBlogController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBlog();
  }


  PopularBlogModel popularBlogModel= PopularBlogModel();

  RxBool isLoading =false.obs;
  getBlog()async{
    isLoading.value =true;
  popularBlogModel =await ApiRepository.blog();
    isLoading.value =false;
  }


  getBlogById()async{
    isLoading.value =true;
    popularBlogModel =await ApiRepository.blog();
    isLoading.value =false;
  }


}