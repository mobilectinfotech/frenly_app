import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import '../../../data/models/PostSingleViewModel.dart';
import '../post_list_model.dart';

class PostListController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //   getAllPost();
  }

  Rxn<PostListsModel> postListModel= Rxn<PostListsModel>();
  RxBool isLoading =false.obs ;

  getAllPost()async{
    isLoading.value =true;
    postListModel.value = await ApiRepository.getPosts();
    isLoading.value =false;
  }


}