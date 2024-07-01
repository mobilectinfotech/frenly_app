import 'package:flutter/material.dart';
import 'package:frenly_app/data/models/DiscoverUsersModel.dart';
import 'package:get/get.dart';
import '../../../data/repositories/api_repository.dart';
import '../../data/models/GetCommentsModel.dart';
import '../my_following/FollowingsModel.dart';
import 'FollowersModel.dart';

class MyFollowersController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    myFollowers();
  }

  var followingsModelData =FollowersModel().obs;
  FollowersModel get  followingsModel => followingsModelData.value;
  RxBool isLoading = false.obs;

  Future<void> myFollowers() async {
    isLoading.value =true;
    try{
      final response = await ApiRepository.myFollowers();
      followingsModelData(response);
      followingsModelData.refresh();
      print("fdsffssfsfsfs${followingsModel.followers?.length}");
    }catch(e){
      print("catch${e.toString()}");

    }
    isLoading.value =false;
  }








}