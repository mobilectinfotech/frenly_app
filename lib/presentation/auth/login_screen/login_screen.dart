import 'package:flutter/material.dart';
import 'package:frenly_app/core/constants/my_textfieldbutton.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/auth/forget_password/forget_password_screen.dart';
import 'package:frenly_app/presentation/auth/signup_screen/signup_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_textfield.dart';
import '../../../core/constants/my_textfield.dart';
import '../../../core/constants/textfield_validation.dart';
import '../../../core/utils/text_field_input_formatters.dart';
import 'controller/login_controller.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

// import 'package:uni_links3/uni_links.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  StreamSubscription? _sub;
  String? _authOrderRef;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }




  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  final LoginController loginController = Get.put(LoginController());

  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: HexColor('#001649'),
          child: Form(
            key: _formKeyLogin,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height:80.ah),
                  Padding(
                    padding:  EdgeInsets.only(left: 15.h),
                    child: Text(
                      'hello'.tr,
                      style:  TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 35,
                          height: 1.2.ah
                      ),
                    ),
                  ),
                  SizedBox(height: 60.ah),
                  // Center(
                  //   child: SizedBox(
                  //       height: 100,
                  //    //   child: CustomImageView(imagePath:  "assets/icons/transparent bakgrund.svg")),
                  //   // Image.asset('assets/image/image 1.png',height: 151.ah,width: 148.aw,)
                  // ),
                  const Spacer(),
                  Padding(
                    padding:  EdgeInsets.only(left: 10.h, right: 10.h),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(left: 15.h,right: 15.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 30.ah,),
                            Padding(
                              padding:  EdgeInsets.only(left:10.h),
                              child: Text(
                                'emailn'.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.fSize),
                              ),
                            ),
                            SizedBox(
                              height: 10.ah,
                            ),
                            CustomTextFormField(
                              inputFormatters: InputFormatters.spaceRestricted(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: Validator.validateEmail,
                              controller: loginController.emaillController, context: context,
                              hintText: "john.smith@gmail.com",
                            ),

                            SizedBox(height: 15.ah,),
                            Padding(
                              padding:  EdgeInsets.only(left:10.h),
                              child: Text(
                                'Passw'.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.fSize),
                              ),
                            ),
                            SizedBox(height: 10.ah,),
                            Obx(() => CustomTextFormField(
                                validator: Validator.notEmpty,
                                controller: loginController.passworddController,
                                textInputAction: TextInputAction.done,
                                suffix: InkWell(
                                    onTap: () {
                                      loginController.isShowPassword.value = !loginController.isShowPassword.value;
                                    },
                                    child: Container(
                                        margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
                                        child:loginController.isShowPassword.value ? const Icon(Icons.visibility_off)  :
                                        const Icon(Icons.visibility)
                                    )),
                                 hintText: "Passw".tr,
                                suffixConstraints: BoxConstraints(maxHeight: 44.v),
                                obscureText: loginController.isShowPassword.value, context: context,)),

                            SizedBox(height: 30.ah,),
                            Obx(() => CustomPrimaryBtn1(
                              title: 'Log'.tr,
                              isLoading: loginController.isLoading.value,
                              onTap: onTapLogin,
                            )),
                           SizedBox(height: 10.ah),
                            Center(
                              child: InkWell(
                                onTap: (){
                               //   Get.to(()=>FCMTokenScreen());
                                },
                                child: Text(
                                  'Donthave'.tr,
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.fSize),
                                ),
                              ),
                            ),
                           SizedBox(height: 10.ah),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()));
                                },
                                child: Text(
                                  'sg'.tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.fSize),
                                ),
                              ),
                            ),
                           SizedBox(height: 10.ah),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ForgetPassword()));
                              },
                              child: Center(
                                child: Text(
                                  'Forg'.tr,
                                  style: TextStyle(
                                      color: HexColor('#001649'),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.fSize),
                                ),
                              ),
                            ),

                            SizedBox(height: 30.ah)
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
  onTapLogin() {
    if (_formKeyLogin.currentState!.validate()) {
      print("object");
      loginController.loginWithEmail();
    }
  }


}


Future<String?> getIPAddress() async {
  try {
    // Check if device has internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Try to find a valid IPv4 address from network interfaces
      var interfaces = await NetworkInterface.list();
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            return addr.address; // Returns the first IPv4 address found
          }
        }
      }
    } else {
      return "No internet connection"; // Handle no internet connection
    }
  } catch (e) {
    print("Failed to get IP address: $e"); // Log the error
    return "Error fetching IP address"; // Return error message
  }
  return "No IP address found"; // Return this if no IP address was found
}

Future<String?> getPublicIPAddress() async {
  try {
    final response = await http.get(Uri.parse('https://api.ipify.org'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Failed to get public IP";
    }
  } catch (e) {
    return "Error: $e";
  }
}