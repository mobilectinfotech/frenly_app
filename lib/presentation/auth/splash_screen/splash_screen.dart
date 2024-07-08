import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class SplashScreen extends StatelessWidget {
    SplashScreen({Key? key}) : super(key: key,);

    SplashController splashController =Get.put(SplashController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 1.v),
            Padding(
              padding:  EdgeInsets.all(80.0.adaptSize),
              child: CustomImageView(
                imagePath: "assets/logo/bakgrund_logo.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
