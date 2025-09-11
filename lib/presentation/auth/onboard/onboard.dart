import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/auth/signup_screen/signup_screen.dart';
import 'package:get/get.dart';
 import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'widgets/onboard_first.dart';
import 'widgets/onboard_second.dart';
import 'widgets/onboard_third.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  OnBoardViewModel onBoardViewModel = OnBoardViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/bg.png'),
            fit: BoxFit.fill
          )
        ),
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height:  91.ah,),

                Expanded(
                  child: PageView(
                    controller: onBoardViewModel.pageController,
                    children: const [
                      OnBoardFirst(),
                      OnBoardSecond(),
                    //  OnBoardThird(),
                    //  OnBoardThirdd(),
                    ],
                  ),
                ),

                SmoothPageIndicator(
                  controller:
                  onBoardViewModel.pageController, // PageController
                  count: 2,
                  effect: const WormEffect(
                    activeDotColor: Colors.black,
                    dotHeight: 12.0,
                    dotWidth: 12.0,
                  ), // your preferred effect
                  onDotClicked: (index) {},
                ),
                SizedBox(height: 70,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const SignUpScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff001649),
                      minimumSize: Size(MediaQuery.of(context).size.width, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      )),
                  child:Text("Join".tr,style: TextStyle(color: Colors.white),)),
                SizedBox(height: 50)

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardViewModel {
  final PageController pageController = PageController();
}