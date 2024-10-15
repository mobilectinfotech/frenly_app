import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/auth/login_screen/login_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../Widgets/custom_textfield.dart';
import '../../../core/constants/my_textfield.dart';
import 'package:get/get.dart';
import '../../../core/constants/textfield_validation.dart';
import '../../../core/utils/text_field_input_formatters.dart';
import 'controller/forget_password_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: HexColor('#001649'),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 80.ah),
                  Padding(
                    padding:  EdgeInsets.only(left:15.h),
                    child: Text('Forgg'.tr,
                      style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.w700,fontSize: 35.fSize,
                        height: 1.ah
                      ),
                    ),
                  ),
                  SizedBox(height: 110.ah),
                  Center(
                    child: Container(
                    height: 151.ah,width: 148.aw,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(35)),
                        color: Color(0x305B5B5B),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/image/frenly_logo.png'),
                        )),
                    // child: Center(child: Text(firestore.currentUser!.displayName!.toUpperCase().characters.first.toString(), style: TextStyle(fontSize: 20.fSize,fontWeight: FontWeight.w400),)),
                  ),
                  // Image.asset('assets/image/image 1.png',height: 151.ah,width: 148.aw,)
                  ),

                  Spacer(),
                  Padding(
                    padding:  EdgeInsets.only(left:10.h,right:10.h),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(left: 15.h,right: 15.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 30.ah),
                            Padding(
                              padding:  EdgeInsets.only(left:10.h),
                              child: Text('emailn'.tr,
                                style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize
                                ),
                              ),
                            ),

                            SizedBox(height: 10.ah,),
                            CustomTextFormField(
                              inputFormatters: InputFormatters.spaceRestricted(),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: Validator.validateEmail,
                              controller: forgetPasswordController.emailforgetcontr, context: context,
                              hintText: "johnsmith@gmail.com",
                            ),

                            SizedBox(height:30.ah,),
                            Obx(()=> Center(
                                child:  CustomPrimaryBtn1(
                                  title: 'Contin'.tr,
                                  isLoading: forgetPasswordController.isLoadig.value,
                                  onTap: () {
                                    if(_formKey.currentState!.validate()) {
                                      forgetPasswordController.forgotPassword();
                                    }


                                    },
                                ),
                              ),
                            ),

                            SizedBox(height: 10.ah),
                            Center(
                              child: Text('alr'.tr,
                                style: TextStyle(
                                    color: Colors.black38,fontWeight: FontWeight.w500,fontSize: 16.fSize
                                ),
                              ),
                            ),

                            SizedBox(height: 10.ah),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              },
                              child: Center(
                                child: Text('Log'.tr,
                                  style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20.fSize
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.ah)
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}


