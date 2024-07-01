import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/popular_city/popular_city_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import '../../Widgets/custom_image_view.dart';
import 'user_by_city_screen.dart';

class PopularsCityScreen extends StatefulWidget {
  const PopularsCityScreen({super.key});

  @override
  State<PopularsCityScreen> createState() => _PopularsCityScreenState();
}

class _PopularsCityScreenState extends State<PopularsCityScreen> {
  PopularController controller =Get.put(PopularController());



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppbar(context: context,title: "Popular".tr ,),
        body: Obx(
            ()=> controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) : Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10,),
                Text('Allcit'.tr,
                  style: const TextStyle(
                      color: Colors.black,fontWeight: FontWeight.w600,fontSize:24
                  ),
                ),
                allCity(),
              ],
            ),
          ),
        ),
      ),
    );


  }

  Widget allCity(){
    return Expanded(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 165.ah,
        child:   controller.liveUserModel.activeFriends?.length == 0 ? const Center(child:Text("No active user found"),): ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: controller.liveUserModel.activeFriends?.length,
          padding: const EdgeInsets.only(bottom: 10,),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                String city = "${controller.liveUserModel.activeFriends?[index].city}";
                Get.to(()=> UserByCityScreen(city: city,));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${controller.liveUserModel.activeFriends?[index].city}',
                          style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w700,fontSize:17.fSize,
                          ),),
                        Text('${controller.liveUserModel.activeFriends?[index].country}',
                          style: TextStyle(
                            color: Colors.grey,fontWeight: FontWeight.w500,fontSize:15.fSize,
                          ),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:CrossAxisAlignment.center ,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int i = 0; i < controller.liveUserModel.activeFriends![index].users!.length; i++)
                                Align(
                                  widthFactor: 0.5,
                                  child: CustomImageView(
                                    height: 30,
                                    width: 30,
                                    radius: BorderRadius.circular(70),
                                    fit: BoxFit.cover,
                                    imagePath: controller.liveUserModel.activeFriends![index].users![i].avatarUrl,
                                  ),
                                )
                            ],
                          ),
                        ),
                        SizedBox(width:10.aw,),
                        Text('${controller.liveUserModel.activeFriends![index].userCount}\nActives'.tr,
                          style: TextStyle(
                            color: HexColor('#111111'),fontWeight: FontWeight.w600,fontSize:12.3.fSize,
                          ),
                        ),
                      ],)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



