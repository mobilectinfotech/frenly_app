import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/Widgets/custom_vlog_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/my_follwers/my_followers.dart';
import 'package:frenly_app/presentation/settings_screen/setting_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../Widgets/custom_blog_card.dart';
import '../../Vlog/vlog_like_commnet_share_common_view.dart';
import '../../my_following/my_followings.dart';
import '../../photos/photo_view_screen.dart';
import '../../vlog_full_view/vlog_full_view.dart';
import '../edit_profile_screen/edit_profile_screen.dart';
import 'my_profile_controller.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  MyProfileController controller = Get.put(MyProfileController());

  var selectone;
  late TabController tabController;
  int activeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProfile();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(strokeWidth: 1),
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                imageView(),
                SizedBox(height: 10.ah),
                bioTexts(),
                SizedBox(height: 20.ah),
                Padding(
                  padding: EdgeInsets.only(left: 16.0.aw, right: 16.aw),
                  child: Container(
                    height: 52.ah,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.adaptSize)),
                    child: Padding(
                      padding: EdgeInsets.all(6.0.adaptSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              activeIndex = 0;
                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              width: 112,
                              decoration: BoxDecoration(
                                  color: activeIndex == 0
                                      ? Color(0xff001649)
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(9.adaptSize)),
                              child: Center(
                                  child: Text(
                                'Vlogs'.tr,
                                style: TextStyle(
                                    color: activeIndex == 0
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              activeIndex = 1;
                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              width: 112,
                              decoration: BoxDecoration(
                                  color: activeIndex == 1
                                      ? Color(0xff001649)
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(9.adaptSize)),
                              child: Center(
                                  child: Text(
                                'Blogs'.tr,
                                style: TextStyle(
                                    color: activeIndex == 1
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              activeIndex = 2;
                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              width: 112,
                              decoration: BoxDecoration(
                                  color: activeIndex == 2
                                      ? Color(0xff001649)
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(9.adaptSize)),
                              child: Center(
                                  child: Text(
                                'Photos'.tr,
                                style: TextStyle(
                                    color: activeIndex == 2
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.ah),
                Column(
                  children: [
                    activeIndex == 0 ? _vlogs() : SizedBox(),
                    activeIndex == 1 ? _blogs() : SizedBox(),
                    activeIndex == 2 ? _photos() : SizedBox(),
                  ],
                ),
                SizedBox(height: 80.ah),
              ],
            ),
    );
  }

  Widget backAndSettingIconRow() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.aw, right: 20.aw, top: 30.ah),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          // Image.asset('assets/image/arrow.png', height: 20.aw, width: 20.aw),
          InkWell(
            onTap: () {
              Get.to(() => SettingScreen(
                    isAccountPrivate:
                        controller.getUserByIdModel.user?.isPrivate ?? false,
                  ));
            },
            child: Image.asset(
              'assets/image/ic_settings_24px.png',
              height: 20.aw,
              width: 20.aw,
            ),
          ),
        ],
      ),
    );
  }

  Widget imageView() {
    return Container(
      height: 390 ,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 217 + 100.ah,
            width: double.infinity,
            child: CustomImageView(
              radius: BorderRadius.only(
                  bottomRight: Radius.circular(25.adaptSize),
                  bottomLeft: Radius.circular(25.adaptSize)),
              fit: BoxFit.cover,
              imagePath: controller.getUserByIdModel.user?.coverPhotoUrl,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 121.aw,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(500)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomImageView(
                  width: 140.ah,
                  height: 140.ah,
                  fit: BoxFit.cover,
                  imagePath: controller.getUserByIdModel.user?.avatarUrl,
                  radius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(top: 30, right: 10, child: backAndSettingIconRow()),
        ],
      ),
    );
  }

  Widget bioTexts() {
    return Padding(
      padding: EdgeInsets.only(left: 16.aw, right: 16.aw),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${controller.getUserByIdModel.user?.fullName}'
                        .capitalizeFirst!,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.fSize),
                  ),
                  Text(
                    '${controller.getUserByIdModel.user?.handle ?? ""}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.fSize),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                                getUserByIdModel: controller.getUserByIdModel,
                              )));
                },
                child: Container(
                  height: 34.ah,
                  width: 98.aw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: HexColor('#001649')),
                  child: Center(
                    child: Text(
                      'Edit Profile'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.fSize),
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            '${controller.getUserByIdModel.user?.bio ?? ""}'.tr,
            style: TextStyle(
              height: 1.5,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 16.fSize,
            ),
          ),
          SizedBox(height: 15.ah),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${controller.getUserByIdModel.user?.numberOfPosts}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.fSize,
                    ),
                  ),
                  Text('Posts'.tr,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.fSize,
                    ),
                  ),
                ],
              ),

              InkWell(
                onTap: () {
                  Get.to(() => const MyFollowersScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${controller.getUserByIdModel.user?.numberOfFollower}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.fSize,
                      ),
                    ),
                    Text(
                      'Followers'.tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.fSize,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const MyFollowingScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${controller.getUserByIdModel.user?.numberOfFollowing}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.fSize,
                      ),
                    ),
                    Text(
                      'Following'.tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.fSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //vlogs
  Widget _vlogs() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0.aw, right: 10.0.aw),
      child: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: controller.getUserByIdModel.user!.vlogs!.length,
          padding: const EdgeInsets.only(bottom: 10),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  print("sdfghjgfdsfghj");
                  Get.to(() => VlogFullViewNewScreen(
                        videoUrl:
                            '${controller.getUserByIdModel.user!.vlogs![index].videoUrl}',
                        vlogId: controller
                            .getUserByIdModel.user!.vlogs![index].id
                            .toString(),
                      ));
                },
                child: CustomVlogCard(
                    vlog: controller.getUserByIdModel.user!.vlogs![index]));
          },
        ),
      ),
    );
  }

  Widget vlogInLocationRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
      child: SizedBox(
        height: 40.ah,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                'assets/image/location-outline.png',
                width: 21.ah,
                height: 21.ah,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                '${controller.getUserByIdModel.user?.city}, ',
                style: TextStyle(
                  color: HexColor('#FFFFFF'),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.fSize,
                ),
              ),
            ),
            Text(
              '${controller.getUserByIdModel.user?.country}',
              style: TextStyle(
                color: HexColor('#FFFFFF'),
                fontWeight: FontWeight.w600,
                fontSize: 11.fSize,
              ),
            ),
            Spacer(),
            SizedBox(
              width: 22.aw,
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget userLikeViewShare(int index) {
    DateTime currentDate = DateTime.now();
    DateTime createdAtDate = DateTime.parse(
        "${controller.getUserByIdModel.user!.vlogs?[index].createdAt}");
    int differenceInDays = currentDate.difference(createdAtDate).inDays;
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 15, top: 116.ah),
      child: SizedBox(
        height: 160.ah,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                '${controller.getUserByIdModel.user?.vlogs![index].title}'.tr,
                style: TextStyle(
                    color: HexColor('#FFFFFF'),
                    fontWeight: FontWeight.w700,
                    fontSize: 16.fSize,
                    height: 1.5),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10.ah),
                    CustomImageView(
                      height: 30.ah,
                      width: 30.ah,
                      imagePath: controller.getUserByIdModel.user!.avatarUrl,
                      radius: BorderRadius.circular(60),
                    ),
                    Text(
                      '  ${controller.getUserByIdModel.user!.fullName}  ',
                      style: TextStyle(
                        color: HexColor('#FFFFFF'),
                        fontWeight: FontWeight.w600,
                        fontSize: 11.fSize,
                      ),
                    ),
                    Text(
                      '${controller.getUserByIdModel.user?.vlogs![index].numberOfViews} views  ',
                      style: TextStyle(
                        color: HexColor('#FFFFFF'),
                        fontWeight: FontWeight.w600,
                        fontSize: 11.fSize,
                      ),
                    ),
                    Text(
                      '${differenceInDays} days ago',
                      style: TextStyle(
                        color: HexColor('#FFFFFF'),
                        fontWeight: FontWeight.w600,
                        fontSize: 11.fSize,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                VlogLikeCommentsShareView(
                  vlog: controller.getUserByIdModel.user!.vlogs![index],
                ),
                SizedBox(width: 15.0.aw)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _blogs() {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: controller.getUserByIdModel.user!.blogs!.length,
        padding: const EdgeInsets.only(bottom: 10),
        itemBuilder: (context, index) {
          String jsonString = "${controller.getUserByIdModel.user!.blogs![index].tags}";
          List<String> tagsList = json.decode(jsonString).cast<String>();
          return CustomBlogCard(
            isown: true,
            blog: controller.getUserByIdModel.user!.blogs![index],
            tagsList: tagsList,
          );
        },
      ),
    );
  }

  Widget _photos() {
    List<int> cont = [
      1,
      1,
      1,
      1,
      2,
      1,
      2,
      1,
      1,
    ];
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(10.0),
        child: StaggeredGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: List.generate(
            controller.getUserByIdModel.user!.posts!.length,
            (index) => StaggeredGridTile.count(
              crossAxisCellCount: cont[index % 9],
              mainAxisCellCount: cont[index % 9],
              child: Center(
                  child: InkWell(
                onTap: () {
                  Get.to(() => PostFullViewScreen(
                        loadPostByid:
                            "${controller.getUserByIdModel.user?.posts![index].id}",
                        own: true,
                      ));
                },
                child: CustomImageView(
                  imagePath:
                      controller.getUserByIdModel.user?.posts![index].imageUrl,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(10),
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
