import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_textfield.dart';
import '../../../core/constants/my_textfield.dart';
import '../setting_controller.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKeyLogin = GlobalKey<FormState>();

    SettingsController controller = Get.find();

    return Scaffold(
      // backgroundColor: Color(0xFF121C35),
      appBar: appBarPrimary(title: "change_password".tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.aw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100.ah),

            // CustomTextFormField(hintText: 'EnterYourOldPassword'.tr,
            //   context: context,
            //   controller: controller.oldPassword,
            // ),
            // SizedBox(height: 25.h),

            Obx(() {
              return CustomTextFormField(
                context: context,
                suffix: InkWell(
                    onTap: () {
                      controller.isShowPassword.value =
                      !controller.isShowPassword.value;
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
                        child: controller.isShowPassword.value ? const Icon(
                            Icons.visibility_off) :
                        const Icon(Icons.visibility)
                    )),
                hintText: 'EnterYourOldPassword'.tr,
                controller: controller.oldPassword,
                obscureText: controller.isShowPassword.value,
              );
            }),

            SizedBox(height: 25.h),
            Obx(() {
              return CustomTextFormField(
                context: context,
                suffix: InkWell(
                    onTap: () {
                      controller.isShowPasswordds.value =
                      !controller.isShowPasswordds.value;
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
                        child: controller.isShowPasswordds.value ? const Icon(
                            Icons.visibility_off) :
                        const Icon(Icons.visibility)
                    )),
                hintText: 'EnterYourNewPassword'.tr,
                controller: controller.newPassword,
                obscureText: controller.isShowPasswordds.value,
              );
            }),


            SizedBox(height: 25.h),
            Obx(() {
              return CustomTextFormField(
                context: context,
                suffix: InkWell(
                    onTap: () {
                      controller.isShowPasswordss.value =
                      !controller.isShowPasswordss.value;
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
                        child: controller.isShowPasswordss.value ? const Icon(
                            Icons.visibility_off) :
                        const Icon(Icons.visibility)
                    )),
                hintText: 'EnterYourConfirmPassword'.tr,
                controller: controller.confirmPassword,
                obscureText: controller.isShowPasswordss.value,
              );
            }),


            SizedBox(height: 25.h),

            Spacer(),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.aw),
            //   child: Obx(() {
            //     return kWidgetButtonPrimaryBtn(
            //       title: 'Change Password',
            //       isLoading: controller.apiLoading.value,
            //       onTap: () {
            //        // controller.ChangePasswordFunction();
            //       },
            //     );
            //   }),
            // ),

            Center(
              child: Obx(() {
                return CustomPrimaryBtn1(
                  title: "change_password".tr,
                  isLoading: controller.isLoading.value,
                  onTap: () {
                    print("object81");
                    controller.changePassword();
                    print("object83");

                    // if (_formKeyLogin.currentState!.validate()) {
                    //   if(controller.pikedVideo != null ){
                    //     controller.postVlog();
                    //   }else{
                    //     AppDialog.taostMessage("Video Not be Empty");
                    //   }
                    // changePassword
                    // }
                    // Get.back();


                    // if (_formKeyLogin.currentState!.validate()) {
                    //   print("object");
                    //   controller.changePassword();
                    // }
                  },
                );
              }),
            ),
            SizedBox(height: 40.ah),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
