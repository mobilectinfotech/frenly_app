import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/models/DiscoverUsersModel.dart';
import '../../data/models/vlog_by_id_model.dart';
import '../../data/repositories/api_repository.dart';
import '../Vlog/TrendingVlogModel.dart';

class VlogFullViewController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    discoveryUsers();
    getVlog();
  }


  late BuildContext context;

  VlogByIdModel vlogByIdModel=VlogByIdModel();
  RxBool isLoadingVlogById =false.obs;
  Future<void> getVlogById({required String vlogId}) async {
    isLoadingVlogById.value=true;
    vlogByIdModel  =await ApiRepository.getVlogById(userId:vlogId );
    isLoadingVlogById.value=false;
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

  TrendingVlogModel trendingVlogModel=TrendingVlogModel();
  RxBool isLoadingVlogs = false.obs;

  RxBool isLoadingGetVlog = false.obs;

  Future<void> getVlog()async{
    isLoadingGetVlog.value=true;
    trendingVlogModel = await ApiRepository.getVlog(limit: 5);
    isLoadingGetVlog.value=false;

  }



}