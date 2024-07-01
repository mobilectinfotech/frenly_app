import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/models/GetCommentsModel.dart';
import '../../data/repositories/api_repository.dart';
import '../chat/Pages/all_frined/AllFriendsModel.dart';

class DashBoardController extends GetxController{


   RxBool bottomBarShow = true.obs;

  RxBool isLoadingONComments = false.obs;
  Rx<GetCommentsModel> getdata =GetCommentsModel().obs;
  GetCommentsModel get getCommentsModel => getdata.value;


  getComments({required String vlogId,bool ? isLoading,bool ? isBlog, bool ? post})async{
    print("getComments========>$isBlog ");
    isLoadingONComments.value = isLoading ?? true;
    var response = isBlog == true ? await ApiRepository.getCommentsOnBlog(blogId: vlogId) : post==true ?  await ApiRepository.getCommentsOnPosts(vlogId: vlogId) : await ApiRepository.getCommentsOnVlog(vlogId: vlogId);
    getdata(response);
    getdata.refresh();
    isLoadingONComments.value=false;
  }


  TextEditingController commentController =TextEditingController();
  RxBool isLoadingONCommentsPost = false.obs;


  postCommnetOnVlog({required String vlogId, bool ? isBlog , bool ? post})async{
    print("postCommnetOnVlog========>$isBlog ");
    isLoadingONComments.value=true;
    bool isCommented = isBlog ==true ?await ApiRepository.postCommentOnBlog(vlogId: vlogId, comment: commentController.text) : post==true ?    await ApiRepository.postCommentOnPost(vlogId: vlogId, comment: commentController.text) :  await ApiRepository.postCommentOnVlog(vlogId: vlogId, comment: commentController.text);
    isLoadingONComments.value=false;
    if(isCommented){
      commentController.clear();
      getComments(vlogId: vlogId,isLoading: false, isBlog:isBlog,  post :post );
    }
  }

   RxBool isLoadingONShare = false.obs;
   Rx<AllFriendsModel> getdata1 =AllFriendsModel().obs;
   AllFriendsModel get getAllFriendsModel => getdata1.value;
   getFriends()async{
     isLoadingONShare.value =  true;
     var response =  await ApiRepository.getFriends();
     getdata1(response);
     getdata1.refresh();
     isLoadingONShare.value=false;
   }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    commentController.dispose();
  }
}