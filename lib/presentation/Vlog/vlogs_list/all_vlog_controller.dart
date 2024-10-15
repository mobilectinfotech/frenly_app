import 'package:get/get.dart';

import 'package:frenly_app/data/repositories/api_repository.dart';
import '../TrendingVlogModel.dart';

class AllVlogController extends GetxController{



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVlog();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }

  TrendingVlogModel trendingVlogModel=TrendingVlogModel();
  RxBool isLoading = false.obs;

 Future<void> getVlog()async{
    isLoading.value=true;
    trendingVlogModel = await ApiRepository.getVlog();
    isLoading.value=false;
  }




}