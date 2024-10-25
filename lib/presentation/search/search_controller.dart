import 'package:flutter/cupertino.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import 'package:get/get.dart';
import '../../data/models/SertchUserModel.dart';
import '../Blog/blogListModel.dart';
import '../Vlog/VlogsListModel.dart';
import '../post/post_list_model.dart';

class SearchVlogController extends GetxController{


  TextEditingController searchController =TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    searchVlogg("",true);

  }


  Rx<VlogsListModel> getData =VlogsListModel().obs;
  VlogsListModel get searchModel => getData.value;

  RxBool isLoadingVlog = false.obs;

  searchVlogg(String text,bool ? load)async{
    isLoadingVlog.value=load ??true;
    var response =  await ApiRepository.searchVlog(searchText:text.replaceAll("#", "") );
    getData(response);
    getData.refresh();
    isLoadingVlog.value=false;

  }



  Rx<BlogListModel> getBlogData =BlogListModel().obs;
  BlogListModel get searchBlogModel => getBlogData.value;
  RxBool isLoadingBlog =false.obs;

  Future<void> searchBlog(String text, bool ? load)async{
    isLoadingBlog.value =load ?? true;
    final response =await ApiRepository.searchBlog(searchText:text.replaceAll("#", ""));
    getBlogData(response);
    getBlogData.refresh();
    isLoadingBlog.value =false;
  }




  Rx<PostListsModel> getPostData =PostListsModel().obs;
  PostListsModel get searchPhotosModel => getPostData.value;
  RxBool isLoadingPosts =false.obs;

  searchPhotos(String text, bool ? load)async{
    isLoadingPosts.value =load ?? true;
    final response =await ApiRepository.searchPosts(searchText:text.replaceAll("#", "") );
    getPostData(response);
    getPostData.refresh();
    isLoadingPosts.value =false;
  }




  Rx<SertchUserModel> getUserData =SertchUserModel().obs;
  SertchUserModel get searchUserModel => getUserData.value;
  RxBool isLoadingUsers =false.obs;
  searchUsers(String text, bool ? load)async{


    isLoadingUsers.value =load ?? true;
    final response =await ApiRepository.searchUser(searchText: text.replaceAll("#", ""));
    getUserData(response);
    getUserData.refresh();
    isLoadingUsers.value =false;
  }










  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    searchController.dispose();
  }

}
