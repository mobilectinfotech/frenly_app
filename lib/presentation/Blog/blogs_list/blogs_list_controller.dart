import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';

import '../blogListModel.dart';
class BlogListController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBlogList();
  }


  BlogListModel blogListModel= BlogListModel();

  RxBool isLoading =false.obs;
  getBlogList()async{
    isLoading.value =true;
   blogListModel =await ApiRepository.blog();
    isLoading.value =false;
  }


  getBlogById()async{
    isLoading.value =true;
    blogListModel =await ApiRepository.blog();
    isLoading.value =false;
  }


}