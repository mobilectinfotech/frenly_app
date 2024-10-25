import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/DiscoverUsersModel.dart';
import '../../../data/models/PostSingleViewModel.dart';
import '../../../data/models/vlog_by_id_model.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import '../../Blog/blog_model.dart';
import '../../Vlog/VlogsListModel.dart';

class VlogFullViewController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    discoveryUsers();
    getVlog();
  }


  late BuildContext context;

  // VlogByIdModel vlogByIdModel=VlogByIdModel();
  Rxn<VlogByIdModel> vlogByIdModel = Rxn<VlogByIdModel>();

  RxBool isLoadingVlogById =false.obs;

  Future<void> getVlogById({required String vlogId}) async {
    isLoadingVlogById.value=true;
    vlogByIdModel.value  =await ApiRepository.getVlogById(userId:vlogId );
    isLoadingVlogById.value=false;
  }



  void toggleLikeStatus() {
    final vlog = vlogByIdModel.value?.vlog;
    if (vlog != null) {
      vlog.alreadyLiked = !(vlog.alreadyLiked ?? false);
      vlogByIdModel.refresh(); // Refresh the observable to trigger UI updates
    }
  }






  //descover pepople

  var discoverUsersModelData =DiscoverUsersModel().obs;
  DiscoverUsersModel get  discoverUsersModel => discoverUsersModelData.value;

  RxBool isLoadingDiscoveruser = false.obs;

  Future<void> discoveryUsers() async {
    isLoadingDiscoveruser.value =true;
    try{
      final response = await ApiRepository.discoverUser(limit: 5);
      discoverUsersModelData(response);
      discoverUsersModelData.refresh();
      // ignore: empty_catches
    }catch(e){

    }
    isLoadingDiscoveruser.value =false;
  }




  //vlog

  VlogsListModel trendingVlogModel=VlogsListModel();
  RxBool isLoadingVlogs = false.obs;

  RxBool isLoadingGetVlog = false.obs;

  Future<void> getVlog()async{
    isLoadingGetVlog.value=true;
    trendingVlogModel = await ApiRepository.getVlog(limit: 5);
    isLoadingGetVlog.value=false;

  }

  // blog

  Rxn<BlogModel> blogByIdModel = Rxn<BlogModel>();
  RxBool isLoadingBolg =false.obs;

  getBlogById({required String id,bool ? isLoading})async{
    if(isLoading == null){
      isLoadingBolg.value=true;
    }
    blogByIdModel.value = await ApiRepository.getBlogBYId( blogId: id);
    isLoadingBolg.value =false;
  }

  // post

  RxBool isLoadingPostsingle = false.obs ;
  Rxn<PostSingleViewModel> postSingleViewModel = Rxn<PostSingleViewModel>();
  getPostByid({required String id,bool ? isLoading}) async {
    if(isLoading==null){
      isLoadingPostsingle.value=true;
    }
    postSingleViewModel.value = await   ApiRepository.getPostsByID(id: id);
    isLoadingPostsingle.value=false;
  }


  // Rxn<GetBlogByIdModel> blogByIdModel = Rxn<GetBlogByIdModel>();
  // RxBool isLoadingBolg =false.obs;
  // getPostsByID
  //
  // getBlogById({required String id,bool ? isLoadingg})async{
  //   if(isLoadingg == null){
  //     isLoadingBolg.value=true;
  //   }
  //   blogByIdModel.value = await ApiRepository.getBlogBYId( blogId: id);
  //   isLoadingBolg.value =false;
  // }


}