import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class SplashScreen extends GetWidget<SplashController> {
    SplashScreen({Key? key}) : super(key: key,);

  var name = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 1.v),
            CustomImageView(
              imagePath: "assets/image/splash.png",
              height: 169,
              width: 162,
            ),
          ],
        ),
      ),
    );
  }
}
