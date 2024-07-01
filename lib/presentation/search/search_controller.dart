import 'package:flutter/cupertino.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import '../../data/models/SertchUserModel.dart';
import '../Blog/PopularBlogModel.dart';
import '../Vlog/TrendingVlogModel.dart';
import '../photos/photo_list/PhotosListModel.dart';

class SearchVlogController extends GetxController{


  TextEditingController searchController =TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    searchVlogg("",true);

  }


  Rx<TrendingVlogModel> getData =TrendingVlogModel().obs;
  TrendingVlogModel get searchModel => getData.value;

  RxBool isLoadingVlog = false.obs;

  searchVlogg(String text,bool ? load)async{
    isLoadingVlog.value=load ??true;
    var response =  await ApiRepository.searchVlog(searchText:searchController.text );
    getData(response);
    getData.refresh();
    isLoadingVlog.value=false;

  }



  Rx<PopularBlogModel> getBlogData =PopularBlogModel().obs;
  PopularBlogModel get searchBlogModel => getBlogData.value;
  RxBool isLoadingBlog =false.obs;
  searchBlog(String text, bool ? load)async{
    isLoadingBlog.value =load ?? true;
    final response =await ApiRepository.searchBlog(searchText:searchController.text );
    getBlogData(response);
    getBlogData.refresh();
    isLoadingBlog.value =false;
  }




  Rx<PhotosListsModel> getPostData =PhotosListsModel().obs;
  PhotosListsModel get searchPhotosModel => getPostData.value;
  RxBool isLoadingPosts =false.obs;

  searchPhotos(String text, bool ? load)async{
    isLoadingPosts.value =load ?? true;
    final response =await ApiRepository.searchPosts(searchText:searchController.text );
    getPostData(response);
    getPostData.refresh();
    isLoadingPosts.value =false;
  }




  Rx<SertchUserModel> getUserData =SertchUserModel().obs;
  SertchUserModel get searchUserModel => getUserData.value;
  RxBool isLoadingUsers =false.obs;
  searchUsers(String text, bool ? load)async{
    isLoadingUsers.value =load ?? true;
    final response =await ApiRepository.searchUser(searchText:searchController.text );
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
