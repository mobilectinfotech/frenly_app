import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/auth/login_screen/login_screen.dart';
import 'package:frenly_app/presentation/auth/signup_screen/signup_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import '../../../core/constants/my_textfield.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}
const colors = [
  Color(0xFF001649),
  Color(0xFF001649),
  Color(0xFF001649),
];

class _CreatePasswordState extends State<CreatePassword> {

  bool passwordVisible5=false;
  bool passwordVisible6=false;

  @override
  void initState(){
    super.initState();
    passwordVisible5=true;
    passwordVisible6=true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.ah),
                    Padding(
                      padding:  EdgeInsets.only(left:15.h),
                      child: Text('creatnpass'.tr,
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
                        //Image.asset('assets/image/image 1.png',height: 151.ah,width: 148.aw,)
                    )
                  ],
                ),

                Spacer(),
                Padding(
                  padding:  EdgeInsets.only(left: 10.h,right: 10.h),
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
                        children: [
                          SizedBox(height: 30.ah),
                          Padding(
                            padding:  EdgeInsets.only(left:10.h),
                            child: Text('Passw'.tr,
                              style: TextStyle(
                                  color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize
                              ),
                            ),
                          ),

                          SizedBox(height: 10.ah,),
                          SizedBox(
                            height: 44.ah,
                            child: TextField(
                              obscureText: passwordVisible5,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                    color: HexColor('#B5B5B5'),
                                    width: 1.aw,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                    color: HexColor('#B5B5B5'),
                                    width: 1.aw,
                                  ),
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.aw,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                    color: Color(0xff001649), width: 1.aw,),),
                                hintText: "Passw".tr,

                                hintStyle:  TextStyle(
                                    color: Colors.black.withOpacity(.40),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.fSize),
                                // labelText: "Password",
                                // helperText:"Password must contain special character",
                                // helperStyle:TextStyle(color:Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      passwordVisible5
                                      ? Icons.visibility_off
                                      :Icons.visibility ),
                                  onPressed: () {
                                    setState(
                                          () {
                                        passwordVisible5 = !passwordVisible5;
                                      },
                                    );
                                  },
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                            ),
                          ),

                          SizedBox(height: 10.ah,),
                          Padding(
                            padding:  EdgeInsets.only(left:10.h),
                            child: Text('REPassw'.tr,
                              style: TextStyle(
                                  color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.fSize
                              ),
                            ),
                          ),

                          SizedBox(height: 10.ah,),
                          SizedBox(
                            height: 44.ah,
                            child: TextField(
                              obscureText: passwordVisible6,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                    color: HexColor('#B5B5B5'),
                                    width: 1.aw,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                    color: HexColor('#B5B5B5'),
                                    width: 1.aw,
                                  ),
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.aw,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.h),
                                  borderSide: BorderSide(
                                    color: Color(0xff001649), width: 1.aw,),),
                                hintText: "Passw".tr,

                                hintStyle:  TextStyle(
                                    color: Colors.black.withOpacity(.40),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.fSize),
                                // labelText: "Password",
                                // helperText:"Password must contain special character",
                                // helperStyle:TextStyle(color:Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(passwordVisible6
                                      ? Icons.visibility_off
                                      :Icons.visibility ),
                                  onPressed: () {
                                    setState(
                                          () {
                                            passwordVisible6 = !passwordVisible6;
                                      },
                                    );
                                  },
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                            ),
                          ),

                          SizedBox(height:30.ah,),

                          Center(
                            child: CustomPrimaryBtn1(
                              title: 'reep'.tr,
                              isLoading: false,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen()));
                              },
                            ),
                          ),

                          SizedBox(height: 10.ah),
                          Center(
                            child: Text('Donthave'.tr,
                              style: TextStyle(
                                  color: Colors.black38,fontWeight: FontWeight.w500,fontSize: 16.fSize
                              ),
                            ),
                          ),
                          SizedBox(height: 10.ah),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => SignUpScreen() ));
                              },
                              child: Text('sg'.tr,
                                style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20.fSize
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.ah),

                        ],
                      ),
                    )
                  ),
                ),

               // Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).viewInsets.bottom),),

              ]
          ),
        ),
      ),
    );
  }
}
