import 'package:frenly_app/core/utils/pref_utils.dart';
import 'package:get/get.dart';
import '../../../../messaing_service/messaging_service.dart';
import '../../../dashboard_screen/dashboard_screen.dart';
import '../../onboard/onboard.dart';
class SplashController extends GetxController {


  final _messagingService = MessagingService();

  @override
  void onReady() {

    _messagingService.init(Get.context!);
    MessagingService.localNotiInit(Get.context!);
    Future.delayed(const Duration(seconds:2 ), () async {
      bool isLoggedIn =await PrefUtils().isLoggedIn();
      var token =await PrefUtils().getAuthToken();
      print("isLoggedIn${isLoggedIn}$token");
      if (isLoggedIn) {
        Get.offAll(()=>DashBoardScreen());
      }
      else {

        Get.offAll(()=> OnBoard());      }
    });
  }
}
