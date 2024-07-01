import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import '../../../data/models/PostSingleViewModel.dart';
import 'GetAllPostsModel.dart';

class PostAllViewController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPost();
  }

  GetAllPostsModel getAllPostsModel=GetAllPostsModel();
  RxBool isLoading =false.obs ;
   getAllPost()async{
     isLoading.value =true;
     getAllPostsModel = await ApiRepository.getPosts();
     isLoading.value =false;
   }


  RxBool isLoadingGetPostByid =false.obs ;

  PostSingleViewModel ? postSingleViewModel ;

   getPostByid({required String id}) async {
     isLoadingGetPostByid.value=true;
     postSingleViewModel = await   ApiRepository.getPostsByID(id: '$id');
     isLoadingGetPostByid.value=false;

   }


}