import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class NoInternetScreen extends StatelessWidget {
  NoInternetScreen({Key? key}) : super(key: key,);

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
            Text("Connect to the internet"),
            SizedBox(height: 20.v),
            Text("You're offline. Check your connection."),
            SizedBox(height: 20.v),
            OutlinedButton(onPressed: () {
              Get.offAll(()=>const DashBoardScreen());
            }, child: const Text("Retry"))

            // CustomImageView(
            //   imagePath: "assets/image/splash.png",
            //   height: 169,
            //   width: 162,
            // ),
          ],
        ),
      ),
    );
  }
}
