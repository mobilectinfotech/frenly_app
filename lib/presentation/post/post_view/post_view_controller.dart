import 'package:get/get.dart';
import '../../../data/models/PostSingleViewModel.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

class PostViewController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxBool isLoadingPostsingle = false.obs ;
  bool blockScroll = false;


  Rxn<PostSingleViewModel> postSingleViewModel = Rxn<PostSingleViewModel>();

  getPostByid({required String id,bool ? isLoading}) async {
    if(isLoading==null){
      isLoadingPostsingle.value=true;
    }
    postSingleViewModel.value = await
    ApiRepository.getPostsByID(id: id);
    isLoadingPostsingle.value=false;
  }

}