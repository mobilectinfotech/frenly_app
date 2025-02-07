import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_model.dart';
import 'package:get/get.dart';

import '../../settings_screen/setting_screen.dart';

class MyProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  late BuildContext context;

  var getUserByIdModelData = GetUserByIdModel().obs;

  GetUserByIdModel get getUserByIdModel => getUserByIdModelData.value;

  RxBool isLoading = false.obs;

  getProfile() async {

    isLoading.value = true;
    final response = await ApiRepository.myProfile();
    getUserByIdModelData(response);
    getUserByIdModelData.refresh();

    isLoading.value = false;
  }
}

void checkUserBlockMyAdminOrNot() async {
  try {
    print("line 38");
    final response = await ApiRepository.myProfile(checkUserBlock: false);
    if (response.user?.status == 0) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: Color(0xff001649),
            // Match primary color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              "access_denied".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "you_have_been_blocked_by_the_admin".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  onTapLogOutBtn();
                  // logoutUser();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "ok".tr,
                  style: TextStyle(
                    color: Color(0xff001649),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false, // Prevent dismissing by tapping outside
      );
    }

  } catch (e, s) {
    print(e);
    print(s);
  }
}
