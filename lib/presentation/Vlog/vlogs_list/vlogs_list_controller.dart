import 'package:get/get.dart';

import 'package:frenly_app/data/repositories/api_repository.dart';
import '../VlogsListModel.dart';

class VlogsListController extends GetxController{



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

  VlogsListModel vlogListModel=VlogsListModel();
  RxBool isLoading = false.obs;

 Future<void> getVlog()async{
    isLoading.value=true;
     vlogListModel = await ApiRepository.getVlog();
    isLoading.value=false;
  }




}