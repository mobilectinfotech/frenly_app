import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


class AppDialog {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //show toast
  static taostMessage(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.blue,
      textColor:Colors.white,
    );
  }

  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(        backgroundColor: Colors.white,

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void snackbar([String? message]) {
    Get.snackbar("Error", "$message",
        colorText: Colors.white,
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black54);
  }

  //show error dialog

  static void showErroDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(        backgroundColor: Colors.white,

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              10.heightBox,
              "Connection Timed Out".text.xl2.bold.make().centered(),
              20.heightBox,
              "   * .Checking the connection....".text.base.make(),
              10.heightBox,
              "   * .Checking the proxy and firewall....".text.base.make(),
              30.heightBox,
              "ERROR_CONNECTION_TIMED_OUT".text.make().centered(),
              40.heightBox,
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    //Get.offAll(() => DashboardPage());
                  },
                  child: const Text('Close',style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void clientExceptionDialog(
      {String title = 'Error', String description = 'Internal sever Error'}) {
    Get.dialog(

      Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              10.heightBox,
              title.text.xl2.bold.make().centered(),
              20.heightBox,
              description.text.base.make(),
              10.heightBox,
              "Something went wrong, please try after sometime"
                  .text
                  .base
                  .make(),
              30.heightBox,
              "ERROR_CONNECTION_TIMED_OUT".text.make().centered(),
              40.heightBox,
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    //Get.offAll(() => DashboardPage());
                  },
                  child: const Text('Close',style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  //
  // static void clientExceptionDialog(
  //     {String title = 'Error', String description = 'Internal sever Error'}) {
  //   Get.dialog(
  //     barrierDismissible: false,
  //     Dialog(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             10.heightBox,
  //             title.text.xl2.bold.make().centered(),
  //             20.heightBox,
  //             description.text.base.make(),
  //             10.heightBox,
  //             "Something went wrong, please try after sometime"
  //                 .text
  //                 .base
  //                 .make(),
  //             30.heightBox,
  //             "ERROR_CONNECTION_TIMED_OUT".text.make().centered(),
  //             40.heightBox,
  //             Align(
  //               alignment: Alignment.bottomRight,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   Get.back();
  //                   Get.offAll(() => DashboardPage());
  //                 },
  //                 child: const Text('Reload'),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static void noInternetDialog(
      {String title = 'Error',
      String? description = 'No Internet Connection available'}) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headlineMedium,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
