import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/core/constants/my_textfieldbutton.dart';
import 'package:uni_links3/uni_links.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../Widgets/custom_textfield.dart';
import '../../../core/constants/my_textfield.dart';
import '../../../core/constants/textfield_validation.dart';
import '../../../core/utils/text_field_input_formatters.dart';
import '../login_screen/login_screen.dart';
import 'controller/signup_controller.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());
  final _formKeyLogin = GlobalKey<FormState>();

  bool isAbalable = false;
  bool _isAuthenticating = false;
  String? _authOrderRef;
  StreamSubscription? _sub;
  final RxBool apiLoading=true.obs;

  @override
  void initState() {
    super.initState();
    toggel();
    _listenForDeepLinks();
  }

  Future<void> toggel() async {
    apiLoading.value = true;
    var dio = Dio();
    var response = await dio.request(
      'https://www.frenly.se:4000/user/getToggleStatus',
      options: Options(method: 'GET'),
    );

    if (response.statusCode == 200) {
      final data = response.data;

      // Get the toggle value from admin
      controller.bankIdToggle.value = data['admin']['bankIdToggle'];
      print('Bank ID Toggle value: controller.bankIdToggle.value');
      print(controller.bankIdToggle.value);

      // You can now store it or use it elsewhere
    } else {
      print('Error: ${response.statusMessage}');
    } apiLoading.value = false;
  }

  Future<http.Client> getHttpClient() async {
    SecurityContext context = SecurityContext();

    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }

  String generateNonce() => Uuid().v4();

  Future<void> startBankIDAuth() async {
    controller.isLoading2(true);
    setState(() => _isAuthenticating = true);
    final client = await getHttpClient();
    final iPAddress = await getPublicIPAddress();
    //final iPAddress = await getIPAddress();
    print("object");
    print(iPAddress);
    final Uri bankIDApiUrl = Uri.parse("https://www.frenly.se:4000/auth/start");

    final requestBody = {
      "endUserIp": iPAddress,
    };

    try {
      final response = await client.post(
        bankIDApiUrl,
        //headers: {"Content-Type": "application/json"},
        body: requestBody,
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _authOrderRef = responseData["orderRef"];
        print("object");
        print(_authOrderRef);
        print(iPAddress);
        print(responseData["autoStartToken"]);
        String autoLaunchUrl = "bankid:///?autostarttoken=${responseData["autoStartToken"]}&redirect=bankidapp://auth";
        await launchUrl(Uri.parse(autoLaunchUrl), mode: LaunchMode.externalApplication);
      } else {
        print("BankID Authentication Error: ${response.body}");
      }
    } catch (e) {
      print("Exception during BankID authentication: $e");
    } finally {
      setState(() => _isAuthenticating = false);
    }
  }

  void _listenForDeepLinks() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) handleDeepLink(uri);
    });
    getInitialUri().then((Uri? uri) {
      if (uri != null) handleDeepLink(uri);
    });
  }

  void handleDeepLink(Uri uri) {
    if (uri.scheme == "bankidapp" && uri.host == "auth") {
      verifyBankIDAuth();
    }
  }

  Future<void> verifyBankIDAuth() async {
    if (_authOrderRef == null) return;
    final Uri verifyUrl = Uri.parse("https://www.frenly.se:4000/auth/collect");
    try {
      final response = await http.post(
        verifyUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"orderRef": _authOrderRef}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Authentication Failed: ${responseData}");
        if (responseData["success"] == true) {
          var personalNumber = responseData['user']['personalNumber'];
          var name = responseData['user']['name'];
          print('Personal Number: $personalNumber');
          print('Personal Number: $personalNumber');
          controller.loginWithBankIDCheck(personalNumber);
          print("Authentication Successful");
        } else {
          print("Authentication Failed: ${responseData["status"]}");
        }
      } else {
        print("Verification Error: ${response.body}");
      }
    } catch (e) {
      print("Error verifying authentication: $e");
    }
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      body: Obx(() {if(apiLoading.value)return Center(child: CircularProgressIndicator(),);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: HexColor('#001649'),
            child: Form(
              key: _formKeyLogin,
              child: ListView(children: [
                SizedBox(height: 80.ah),
                Padding(
                  padding: EdgeInsets.only(left: 10.h, right: 10.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'createacc'.tr,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 35.fSize, height: 1.2.ah),
                      ),
                      // Spacer(),
                      Container(
                        height: 100.ah,
                        width: 100.aw,
                        child: CustomImageView(imagePath: "assets/icons/transparent bakgrund.svg"),
                      ),
                      SizedBox(width: 20.aw),
                      // Image.asset('assets/image/image 1.png',height: 74.ah,width:74.aw,)
                    ],
                  ),
                ),
                //  const Spacer(),
                SizedBox(height: 40.ah),
                Padding(
                  padding: EdgeInsets.only(left: 10.h, right: 10.h),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: Get.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.h, right: 15.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            if (controller.bankIdToggle.value == 1) {
                              // BankID Button
                              return SignUpWithBankIdBtn();
                            } else {
                              // Regular form
                              return Padding(
                                padding: EdgeInsets.only(left: 15.h, right: 15.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30.ah),
                                    names("fullnm"),
                                    SizedBox(height: 10.ah),
                                    CustomTextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: Validator.validateFullName,
                                      controller: controller.fullNameController,
                                      context: context,
                                      hintText: "john smith",
                                    ),
                                    SizedBox(height: 20.ah),
                                    names("user_name".tr),
                                    SizedBox(height: 10.ah),
                                    CustomTextFormField(
                                      inputFormatters: InputFormatters.spaceRestricted(),
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value?.length == null || (value?.trim() ?? "").isEmpty) {
                                          return "username_not_be_empty".tr;
                                        } else if (isAbalable) {
                                          return null;
                                        } else {
                                          return 'username_already_registered'.tr;
                                        }
                                      },
                                      controller: controller.userNameController,
                                      context: context,
                                      hintText: "jonesmith004",
                                      onChanged: (p0) async {
                                        if (p0.length > 2) {
                                          isAbalable = await ApiRepository.checkUsername(checkUsername: "${p0}");
                                          setState(() {});
                                        }
                                      },
                                    ),
                                    SizedBox(height: 10.ah),
                                    names("emailn"),
                                    SizedBox(height: 10.ah),
                                    CustomTextFormField(
                                      inputFormatters: InputFormatters.spaceRestricted(),
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: Validator.validateEmail,
                                      controller: controller.emailController,
                                      context: context,
                                      hintText: "johnsmith@gmail.com",
                                    ),
                                    SizedBox(height: 15.ah),
                                    names("Passw"),
                                    SizedBox(height: 10.ah),
                                    Obx(() => CustomTextFormField(
                                      validator: Validator.validateStrongPassword,
                                      controller: controller.passwordController,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      textInputAction: TextInputAction.done,
                                      suffix: InkWell(
                                        onTap: () {
                                          controller.isShowPassword.value = !controller.isShowPassword.value;
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
                                          child: controller.isShowPassword.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                        ),
                                      ),
                                      hintText: "Passw".tr,
                                      suffixConstraints: BoxConstraints(maxHeight: 44.v),
                                      obscureText: controller.isShowPassword.value,
                                      context: context,
                                    )),
                                    SizedBox(height: 15.ah),
                                    names("REPassw"),
                                    SizedBox(height: 10.ah),
                                    Obx(() => CustomTextFormField(
                                      validator: (val) {
                                        if (val == null) {
                                          return 'please_enter_your_confirm_password'.tr;
                                        } else if (val != controller.passwordController.text) {
                                          return "passwords_do_not_match".tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      controller: controller.confirmpasswordController,
                                      textInputAction: TextInputAction.done,
                                      suffix: InkWell(
                                        onTap: () {
                                          controller.isShowCPassword.value = !controller.isShowCPassword.value;
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
                                          child: controller.isShowCPassword.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                        ),
                                      ),
                                      hintText: "Passw".tr,
                                      suffixConstraints: BoxConstraints(maxHeight: 44.v),
                                      obscureText: controller.isShowCPassword.value,
                                      context: context,
                                    )),
                                    SizedBox(height: 30.ah),
                                    Obx(
                                          () => CustomPrimaryBtn1(
                                        title: 'sg'.tr,
                                        isLoading: controller.isLoading.value,
                                        onTap: () {
                                          if (_formKeyLogin.currentState!.validate()) {
                                            controller.signUp();
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10.ah),
                                    SizedBox(height: 10.ah),
                                    Center(
                                      child: Text(
                                        'Alredy'.tr,
                                        style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                      ),
                                    ),
                                    SizedBox(height: 10.ah),
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                        },
                                        child: Text(
                                          'Log'.tr,
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.fSize),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30.ah),
                                  ],
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ),

                //Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).viewInsets.bottom),)
              ]),
            ),
          ),
        );
      },),
    );
  }

  Center SignUpWithBankIdBtn() {
    return Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 200),
                                child: CustomPrimaryBtn2(
                                  title: '_signupwithbankid'.tr,
                                  isLoading: controller.isLoading2.value,
                                  onTap: startBankIDAuth,
                                ),
                              ),
                            );
  }

  Widget names(String name) {
    return Padding(
      padding: EdgeInsets.only(left: 10.h),
      child: Text(
        name.tr,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15.fSize),
      ),
    );
  }
}
