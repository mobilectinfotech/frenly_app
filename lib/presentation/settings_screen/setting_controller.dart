import 'package:flutter/cupertino.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/auth/my_profile_view/my_profile_screen.dart';
import 'package:frenly_app/presentation/settings_screen/setting_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../core/constants/app_dialogs.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/data_sources/remote/api_client.dart';
import 'MySettingModel.dart';

class SettingsController extends GetxController {

  RxBool isLoading = false.obs;
  MySettingModel? mySettingModel;

  RxBool hideLikes = false.obs; // ✅ added local toggle
  final PrefUtils _prefs = Get.find<PrefUtils>();

  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  /// ✅ Toggle Hide Likes
  // void toggleHideLikes(bool value) async {
  //   hideLikes.value = value;
  //   await _prefs.setHideLikes(value);
  // }

/*
  void toggleHideLikes(bool value) async {
    hideLikes.value = value;
    // Save locally
    await _prefs.setHideLikes(value);
    // Update server settings
    await ApiRepository.mySettingsUpdate(
      lastSeen: mySettingModel!.userSetting.lastSeen,
      commentsAllowed: mySettingModel!.userSetting.commentsAllowed,
      chatNotification: mySettingModel!.userSetting.chatNotification,
      feedNotification: mySettingModel!.userSetting.feedNotification,
      language: mySettingModel!.userSetting.language,
      hideLikes: value,
    );

    // Update local model also
    mySettingModel!.userSetting.hideLikes = value;
  }
*/


  /// ✅ Load stored setting properly (async)
  void loadHideLikes() async {
    final storedValue = await _prefs.getHideLikes();
    hideLikes.value = storedValue;
  }

  // void loadHideLikesFromAPI() async {
  //   await mySettings();   // Fetch from server
  //   hideLikes.value = mySettingModel!.userSetting.hideLikes;
  //   await _prefs.setHideLikes(hideLikes.value);
  // }

  Future<void> fetchSettings() async {
    isLoading.value = true;

    mySettingModel = await ApiRepository.mySettings();

    hideLikes.value = mySettingModel!.userSetting.hideLikes;

    isLoading.value = false;
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchSettings();   // only one API call
    // mySettings();
   // loadHideLikes();
  //  loadHideLikesFromAPI();
  }

  /// Update Hide Likes Toggle
  Future<void> toggleHideLikes(bool value) async {
    hideLikes.value = value;

    bool updated = await ApiRepository.mySettingsUpdate(
      lastSeen: mySettingModel!.userSetting.lastSeen,
      commentsAllowed: mySettingModel!.userSetting.commentsAllowed,
      chatNotification: mySettingModel!.userSetting.chatNotification,
      feedNotification: mySettingModel!.userSetting.feedNotification,
      language: mySettingModel!.userSetting.language,
      hideLikes: value,
    );

    if (updated) {
      mySettingModel!.userSetting.hideLikes = value;
    } else {
      // Revert if failed
      hideLikes.value = mySettingModel!.userSetting.hideLikes;
      AppDialog.taostMessage("Failed to update settings");
    }
  }

  Future<bool> changePassword() async {
    isLoading.value = true;
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "user/resetPassword",
      body: {
        "old_password": oldPassword.text.trim(),
        "new_password": newPassword.text.trim(),
        "confirm_password": confirmPassword.text.trim(),
      },
    );

    isLoading.value = false;
    if (response != null && response['success'] == true) {
      // ✅ Show success toast
      AppDialog.taostMessage("password_changed_successfully".tr);

      // ✅ Close current screen
      Get.back();

      return true;
    } else {
      // ❌ Error case — show error toast
      AppDialog.taostMessage(
        response?['message'] ?? "something_went_wrong".tr,
      );
      return false;
    }
  }


  Future<void> mySettings() async {
    print("MySettingModel");
    isLoading.value = true;
    mySettingModel = await ApiRepository.mySettings();
    hideLikes.value = mySettingModel!.userSetting.hideLikes;
    isLoading.value = false;
  }

  mySettingsUpdate() {
    ApiRepository.mySettingsUpdate(
      lastSeen: mySettingModel!.userSetting.lastSeen,
      commentsAllowed: mySettingModel!.userSetting.commentsAllowed,
      chatNotification: mySettingModel!.userSetting.chatNotification,
      feedNotification: mySettingModel!.userSetting.feedNotification,
      language: mySettingModel!.userSetting.language,
      hideLikes: mySettingModel!.userSetting.hideLikes,
    );
  }




/*  Future<void> mySettings() async {
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
        language: mySettingModel!.userSetting.language,
       // hideLikes: mySettingModel!.userSetting.hideLikes
    );
  }*/


}


// if (_formKeyLogin.currentState!.validate()) {
// print("object");
// controller.changePassword();
// }

