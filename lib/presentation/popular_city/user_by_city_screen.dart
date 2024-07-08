import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'user_by_city_controller.dart';

class UserByCityScreen extends StatefulWidget {
   final String city ;
  const UserByCityScreen({super.key,required this.city});

  @override
  State<UserByCityScreen> createState() => _UserByCityScreenState();
}

class _UserByCityScreenState extends State<UserByCityScreen> {

  UserByCityController controller = Get.put(UserByCityController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getUserByCity(city: widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary(title: "Discover".tr),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top:10),
        child: ListView(
          children: [
            SizedBox(height: 10.ah),
            Text('Profile'.tr,
              style: const TextStyle(
                  color: Colors.black,fontWeight: FontWeight.w600,fontSize:24
              ),),
            SizedBox(height: 20.ah),
           gridView(),
          ],
        ),
      ),

    );
  }

 Widget gridView(){
    return Obx(
        ()=>controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),): GridView.builder(
          itemCount: controller.getUserByCityModel.users?.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,mainAxisExtent: 220.ah,
              mainAxisSpacing: 5,crossAxisSpacing: 5
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(userId: '${controller.getUserByCityModel.users![index].id}',)));
              },
              child: Container(
                height: 220.ah,width: 120.aw,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      //color: HexColor('#FFFFFF'),
                        color: Colors.black12,
                        width:1
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      height: 104.adaptSize,width: 104.adaptSize,
                      imagePath: controller.getUserByCityModel.users?[index].avatarUrl,
                      radius: BorderRadius.circular(109.ah),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('${controller.getUserByCityModel.users?[index].fullName ?? ''}',
                        overflow:TextOverflow.ellipsis ,
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w500,fontSize:13.fSize
                        ),),
                    ),
                    Text( '${controller.getUserByCityModel.users?[index].handle ?? ''}',
                      style: TextStyle(
                          color: Colors.grey,fontWeight: FontWeight.w600,fontSize:12.fSize
                      ),),
                    SizedBox(height:4.ah),
                    Text('${controller.getUserByCityModel.users?[index].numberOfFollower ?? ''}',
                      style: TextStyle(
                          color: Colors.black,fontWeight: FontWeight.w500,fontSize:12.fSize
                      ),),

                    SizedBox(height:10.ah),
                    InkWell(
                      onTap:  () {
                        setState(() {
                          controller.getUserByCityModel.users?[index].isFollowed = !controller.getUserByCityModel.users![index].isFollowed!;
                          if(controller.getUserByCityModel.users![index].isFollowed!){
                             ApiRepository.follow(userId: "${controller.getUserByCityModel.users![index].id!}");
                          }else{
                            ApiRepository.unfollow(userId: "${controller.getUserByCityModel.users![index].id!}");

                          }
                        },
                        );
                      },
                      //http://192.168.29.177:3001
                      child: Container(
                        height: 24.ah,width: 98.aw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: controller.getUserByCityModel.users![index].isFollowed!  ? Colors.red : HexColor('#001649'),
                        ),
                        child:  Center(
                          child: Text(controller.getUserByCityModel.users![index].isFollowed! ?   "UnFollow" :"Follow",
                            style: TextStyle(
                                color: controller.getUserByCityModel.users![index].isFollowed! ? Colors.white : Colors.white,
                                fontWeight: FontWeight.w500,fontSize:14.fSize
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
