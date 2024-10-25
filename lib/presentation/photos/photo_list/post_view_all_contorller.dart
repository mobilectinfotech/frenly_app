import 'package:frenly_app/data/repositories/api_repository.dart';

import 'package:get/get.dart';
import '../../../data/models/PostSingleViewModel.dart';
import 'PhotosListModel.dart';

class PostAllViewController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
 //   getAllPost();
  }

  PhotosListsModel getAllPostsModel=PhotosListsModel();
  RxBool isLoading =false.obs ;

   getAllPost()async{
     isLoading.value =true;
     getAllPostsModel = await ApiRepository.getPosts();
     isLoading.value =false;
   }



  RxBool isLoadingPostsingle = false.obs ;


  PostSingleViewModel ? postSingleViewModel ;

  getPostByid({required String id,bool ? isLoading}) async {
    if(isLoading==null){
      isLoadingPostsingle.value=true;
    }
    postSingleViewModel = await   ApiRepository.getPostsByID(id: id);
    isLoadingPostsingle.value=false;
  }



}