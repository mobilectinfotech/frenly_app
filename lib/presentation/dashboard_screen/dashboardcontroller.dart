import 'package:frenly_app/presentation/auth/my_profile_view/my_profile_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class DashBoardController extends GetxController{

  RxInt selectedIndex = 0.obs;
  RxBool bottomBarShow = true.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    checkUserBlockMyAdminOrNot();

  }
}