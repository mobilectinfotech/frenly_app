import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'MySettingModel.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    mySettings();
  }

  RxBool isLoading = false.obs;

  MySettingModel? mySettingModel;
  Future<void> mySettings() async {
    print("MySettingModel");
    isLoading.value = true;
    mySettingModel = await ApiRepository.mySettings();
    isLoading.value = false;
  }

  mySettingsUpdate() {
    ApiRepository.mySettingsUpdate(
        lastSeen: mySettingModel!.userSetting.lastSeen,
        commentsAllowed: mySettingModel!.userSetting.commentsAllowed,
        chatNotification: mySettingModel!.userSetting.chatNotification,
        feedNotification: mySettingModel!.userSetting.feedNotification,
        language: mySettingModel!.userSetting.language);
  }





}
