import 'package:frenly_app/data/repositories/api_repository.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'ReqModel.dart';

class ReqController extends GetxController {


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRequest();
  }

  ReqModel reqModel =ReqModel();

  getRequest() async {
    reqModel  = await ApiRepository.getUserFollowingReqest();
  }



}