
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  final SignUpController controller = Get.put(SignUpController());
  final _formKeyLogin = GlobalKey<FormState>();

  bool isAbalable = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: HexColor('#001649'),
          child: Form(
            key: _formKeyLogin,
            child: ListView(
                children: [
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
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 35.fSize,
                              height: 1.2.ah),
                        ),
                       // Spacer(),
                        Container(
                          height: 74.ah,
                          width: 74.aw,
                          child: Image.asset("assets/logo/transparent_bakgrund_logo.png"),
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
                            SizedBox(height: 30.ah),
                            names("fullnm"),
                            SizedBox(
                              height: 10.ah,
                            ),
                            CustomTextFormField(
                              // inputFormatters: InputFormatters.(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: Validator.validateFullName,
                              controller: controller.fullNameController, context: context,
                              hintText: "john smith",
                            ),

                            SizedBox(height: 20.ah),
                            names("Username"),
                            SizedBox(height: 10.ah,),

                            CustomTextFormField(
                              inputFormatters: InputFormatters.spaceRestricted(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if(value?.length == null||(value?.trim()??"").isEmpty){
                                  return "username not be empty";
                                }else
                                if (isAbalable) {
                                  return null;
                                }else{
                                  return 'username Already Registered';
                                }

                              },

                              controller: controller.userNameController, context: context,
                              hintText: "jonesmith004",

                              onChanged: (p0) async {
                                if(p0.length > 2){
                                  isAbalable = await  ApiRepository.checkUsername(checkUsername: "${p0}");
                                  setState(() {
                                  });

                                }
                              },
                            ),

                            SizedBox(
                              height: 10.ah,
                            ),
                            names("emailn"),

                            SizedBox(
                              height: 10.ah,
                            ),
                            CustomTextFormField(
                              inputFormatters: InputFormatters.spaceRestricted(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: Validator.validateEmail,
                              controller: controller.emailController, context: context,
                              hintText: "johnsmith@gmail.com",
                            ),

                            SizedBox(height: 15.ah,),
                            names("Passw"),
                            SizedBox(
                              height: 10.ah,
                            ),
                            Obx(() => CustomTextFormField(
                              validator: Validator.validatePassword,
                              controller: controller.passwordController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.done,
                              suffix: InkWell(
                                  onTap: () {
                                    controller.isShowPassword.value = !controller.isShowPassword.value;
                                  },
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
                                      child:controller.isShowPassword.value ? const Icon(Icons.visibility_off)  :
                                      const Icon(Icons.visibility)
                                  )),
                              hintText: "Passw".tr,
                              suffixConstraints: BoxConstraints(maxHeight: 44.v),
                              obscureText: controller.isShowPassword.value, context: context,)),

                            SizedBox(
                              height: 15.ah,
                            ),
                            names("REPassw"),
                            SizedBox(
                              height: 10.ah,
                            ),
                            Obx(() => CustomTextFormField(
                              validator: (val ){
                                print("dggsdggfs${val}");
                                if(val ==null) {
                                  return 'Please enter your confirm password';
                                }else
                                if(val != controller.passwordController.text) {
                                  return "Passwords do not match";
                                }else{
                                  print("return${val}");
                                  return null;
                                }
                              }  ,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: controller.confirmpasswordController,
                              textInputAction: TextInputAction.done,
                              suffix: InkWell(
                                  onTap: () {
                                    controller.isShowCPassword.value = !controller.isShowCPassword.value;
                                  },
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
                                      child:controller.isShowCPassword.value ? const Icon(Icons.visibility_off)  :
                                      const Icon(Icons.visibility)
                                  )),
                              hintText: "Passw".tr,
                              suffixConstraints: BoxConstraints(maxHeight: 44.v),
                              obscureText: controller.isShowCPassword.value, context: context,)),
                            SizedBox(height: 30.ah,),
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
                            Center(
                              child: Text(
                                'Alredy'.tr,
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.fSize),
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
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.fSize),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 30.ah,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).viewInsets.bottom),)
                ]),
          ),
        ),
      ),
    );
  }

  Widget names(String name){
    return    Padding(
      padding: EdgeInsets.only(left: 10.h),
      child: Text(
        name.tr,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 15.fSize),
      ),
    );

  }
}
