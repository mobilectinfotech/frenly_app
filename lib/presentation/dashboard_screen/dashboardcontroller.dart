import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../data/models/GetCommentsModel.dart';
import '../../data/repositories/api_repository.dart';
import '../chat/Pages/all_frined/AllFriendsModel.dart';

class DashBoardController extends GetxController{

  RxInt selectedIndex = 0.obs;
  RxBool bottomBarShow = true.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }
}