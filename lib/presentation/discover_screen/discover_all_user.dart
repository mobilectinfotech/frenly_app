import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import '../../Widgets/custom_appbar.dart';
import 'discover_controller.dart';

class DiscoverUsersScreen extends StatefulWidget {
  const DiscoverUsersScreen({super.key});

  @override
  State<DiscoverUsersScreen> createState() => _DiscoverUsersScreenState();
}

class _DiscoverUsersScreenState extends State<DiscoverUsersScreen> {


  DiscoverController controller = Get.put(DiscoverController());
  Future<void> _refresh() async {

   controller.discoveryUsers();


  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.discoveryUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppbar(context: context,title: "Discover".tr ,),
        body: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: ListView(
            children: [
              SizedBox(height: 10.ah),
              Text('Profile'.tr,
                style: TextStyle(
                    color: Colors.black,fontWeight: FontWeight.w600,fontSize:24
                ),),
              SizedBox(height: 20.ah),
              RefreshIndicator(
                  onRefresh: _refresh,
                  child: gridView()),
            ],
          ),
        ),
      
      ),
    );
  }

 Widget gridView(){
    return Obx(
        ()=>controller.isLoading.value ? const Center(child: CircularProgressIndicator(),): RefreshIndicator(

          onRefresh: () async{
            controller.discoveryUsers();
          },
          child: GridView.builder(
            itemCount: controller.discoverUsersModel.discoverUsers?.length,
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
                   Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(userId: '${controller.discoverUsersModel.discoverUsers![index].id}',)));
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
                        imagePath: controller.discoverUsersModel.discoverUsers![index].coverPhotoUrl,
                        radius: BorderRadius.circular(109.ah),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('${controller.discoverUsersModel.discoverUsers![index].fullName}',
                          overflow:TextOverflow.ellipsis ,
                          style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w500,fontSize:13.fSize
                          ),),
                      ),
                      Text(controller.discoverUsersModel.discoverUsers![index].handle ?? '',
                        style: TextStyle(
                            color: Colors.grey,fontWeight: FontWeight.w600,fontSize:12.fSize
                        ),),
                      SizedBox(height:4.ah),
                      Text('${controller.discoverUsersModel.discoverUsers![index].numberOfFollower ?? ''}',
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w500,fontSize:12.fSize
                        ),),

                      SizedBox(height:10.ah),
                      InkWell(
                        onTap:  () {
                          setState(
                                () {
                              if (controller.discoverUsersModel.discoverUsers![index].followState == 0) {
                                controller.discoverUsersModel.discoverUsers![index].followState = 1;
                                setState(() {});
                                ApiRepository.follow(userId: "${controller.discoverUsersModel.discoverUsers![index].id!}");

                              }else{
                                controller.discoverUsersModel.discoverUsers![index].followState = 0;
                                setState(() {});
                                ApiRepository.unfollow(userId: "${controller.discoverUsersModel.discoverUsers![index].id!}");
                              }

                            },
                          );

                        },
                        child: Container(
                          height: 24.ah,width: 98.aw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color:  controller.discoverUsersModel.discoverUsers![index].followState == 1  ? Colors.red : HexColor('#001649'),
                          ),
                          child:  Center(
                            child: Text(
                              controller.discoverUsersModel.discoverUsers![index].followState == 1  ? "Requested".tr : controller.discoverUsersModel.discoverUsers![index].followState == 0  ? "Follow".tr  : "Following",
                              style: TextStyle(
                                  color:  Colors.white,
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
        ),
    );
  }
}
