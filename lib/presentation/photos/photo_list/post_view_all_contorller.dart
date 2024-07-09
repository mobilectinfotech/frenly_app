import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'PhotosListModel.dart';
import 'PhotosListModel.dart';

class PostAllViewController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPost();
  }

  PhotosListsModel getAllPostsModel=PhotosListsModel();
  RxBool isLoading =false.obs ;
   getAllPost()async{
     isLoading.value =true;
     getAllPostsModel = await ApiRepository.getPosts();
     isLoading.value =false;
   }




}