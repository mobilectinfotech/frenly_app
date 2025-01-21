import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/core/utils/pref_utils.dart';
import 'package:get/get.dart';
import '../../../../messaing_service/messaging_service.dart';
import '../../../dashboard_screen/dashboard_screen.dart';
import '../../onboard/onboard.dart';
class SplashController extends GetxController {


  final _messagingService = MessagingService();


  // MySettingModel ? settingModel ;
  // Future<void> getLangues() async {
  //   settingModel = await ApiRepository.mySettings();
  //   if(settingModel?.userSetting.language == "English"){
  //     Get.updateLocale(Locale('swe', 'SE'));
  //   }
  //
  // }




  @override
  void onReady() {

    _messagingService.init(Get.context!);
    MessagingService.localNotiInit(Get.context!);
    Future.delayed(const Duration(seconds:2 ), () async {
      bool isLoggedIn =await PrefUtils().isLoggedIn();
      if (isLoggedIn) {
        Get.offAll(()=>DashBoardScreen());
      }
      else {

        Get.offAll(()=> OnBoard());      }
    });
  }
}

class TestDem0 extends StatelessWidget {
  const TestDem0({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        children: [
        Container(
        color: Colors.blue,
        child: Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final size = context.size;
              print("Container Width: ${size?.width}");
              print("Container Height: ${size?.height}");
            });
            return Text("Check console for size");
          },
        ),)
        ],
      )
    );
  }
}



