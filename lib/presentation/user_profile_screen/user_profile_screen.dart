import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/Widgets/custom_vlog_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_controller.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Widgets/custom_blog_card.dart';
import '../../data/repositories/api_repository.dart';
import '../photos/photo_view_screen.dart';
import '../user_follwers/user_followers_screen.dart';
import '../user_follwings_page/user_followings_screen.dart';
import '../vlog_full_view/vlog_full_view.dart';

//
// class UserProfileScreen extends StatefulWidget {
//   final String userId;
//
//   const UserProfileScreen({super.key, required this.userId});
//
//   @override
//   State<UserProfileScreen> createState() => _UserProfileScreenState();
// }
//
// class _UserProfileScreenState extends State<UserProfileScreen> {
//   UserProfileController controller = Get.put(UserProfileController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller.getUserById(userId: widget.userId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//         backgroundColor: Color(0xffE8E8E8), body: asdklfjnlkasd());
//   }
// }

class UserProfileScreen extends StatefulWidget {
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserProfileController controller = Get.put(UserProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getUserById(userId: widget.userId);
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(strokeWidth: 1,),
              )
            : ListView(
             padding: EdgeInsets.zero,
              children: [
                imageView(),
                SizedBox(height: 10.ah),
                bioTexts(),
                SizedBox(height: 20.ah),
                ((controller.getUserByIdModel.user?.isPrivate == true &&
                            controller.getUserByIdModel.user!.followState ==
                                0) ||
                        (controller.getUserByIdModel.user?.isPrivate ==
                                true &&
                            controller.getUserByIdModel.user!.followState ==
                                1))
                    ? Container(
                        child: Column(
                          children: [
                            Divider(),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0.aw, right: 16.aw, top: 40.ah),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 45.adaptSize,
                                      height: 45.adaptSize,
                                      child:
                                          Icon(Icons.lock_outline_rounded),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: OvalBorder(
                                            side: BorderSide(width: 2)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.0.aw),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 6.ah,
                                        ),
                                        Text(
                                          'This Account is Private',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.09,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.ah,
                                        ),
                                        Opacity(
                                          opacity: 0.50,
                                          child: Text(
                                            'Follow this account to see their photos \nand videos.',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.09,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.only(left: 16.0.aw, right: 16.aw),
                        child: Container(
                          height: 52.ah,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(10.adaptSize)),
                          child: Padding(
                            padding: EdgeInsets.all(6.0.adaptSize),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                            ? const Color(0xff001649)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            9.adaptSize)),
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
                                            ? const Color(0xff001649)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            9.adaptSize)),
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
                                            ? const Color(0xff001649)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            9.adaptSize)),
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
                    activeIndex == 0 ? _vlogs() : const SizedBox(),
                    activeIndex == 1 ? _blogs() : const SizedBox(),
                    activeIndex == 2 ? _photos() : const SizedBox(),
                  ],
                )
              ],
            ),
      ),
    );
  }

  Widget backAndSettingIconRow() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.aw, right: 20.aw, top: 10.ah),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/image/arrow.png',
                  height: 20.aw, width: 20.aw)),
          SizedBox(
              height: 20.aw,
              width: 20.aw,
              child: InkWell(
                  onTap: () {
                    _bottomSheetWidget2(context001: context, vlogId: '2');
                    // ApiRepository.blockUser(userId: "${ controller.getUserByIdModel.user?.id}");
                  },
                  child: const Icon(Icons.more_vert_outlined))),
        ],
      ),
    );
  }

  Widget imageView() {
    return SizedBox(
      height: 290 + 100.ah,
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
          SafeArea(
            child: backAndSettingIconRow(),
          ),
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
                    '${controller.getUserByIdModel.user?.fullName?.trim()}'
                        .capitalizeFirst!,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.fSize),
                  ),
                  Text(
                    controller.getUserByIdModel.user?.handle?.trim() ?? "",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.fSize),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  setState(
                    () {
                      if (controller.getUserByIdModel.user?.followState == 0) {
                        controller.getUserByIdModel.user?.followState = 1;
                        setState(() {});
                        ApiRepository.follow(
                            userId: "${controller.getUserByIdModel.user!.id!}");
                      } else {
                        controller.getUserByIdModel.user?.followState = 0;
                        setState(() {});
                        ApiRepository.unfollow(
                            userId: "${controller.getUserByIdModel.user!.id!}");
                      }
                    },
                  );
                },
                child: Container(
                  height: 40.ah,
                  width: 98.aw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: HexColor('#001649'),
                  ),
                  child: Center(
                    child: Text(
                      controller.getUserByIdModel.user?.followState == 1
                          ? controller.getUserByIdModel.user?.isPrivate == false
                              ? "Following"
                              : "Requested".tr
                          : controller.getUserByIdModel.user?.followState == 0
                              ? "Follow".tr
                              : "Following",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.fSize),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${controller.getUserByIdModel.user?.bio}${controller.getUserByIdModel.user?.isPrivate} "
                    .capitalizeFirst ??
                "",
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 16.fSize),
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
                  Text(
                    '${controller.getUserByIdModel.user?.numberOfPosts}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.fSize,
                    ),
                  ),
                  Text(
                    'Posts'.tr,
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
                  if (controller.getUserByIdModel.user!.isPrivate!) {
                    if (controller.getUserByIdModel.user!.followState == 2) {
                      Get.to(() => UserFollowersScreen(
                            userId: '${controller.getUserByIdModel.user!.id}',
                          ));
                    }
                  } else {
                    Get.to(() => UserFollowersScreen(
                          userId: '${controller.getUserByIdModel.user!.id}',
                        ));
                  }
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
                  if (controller.getUserByIdModel.user!.isPrivate!) {
                    if (controller.getUserByIdModel.user!.followState == 2) {
                      Get.to(() => UserFollowingsScreen(
                            userId: '${controller.getUserByIdModel.user!.id}',
                          ));
                    }
                  } else {
                    Get.to(() => UserFollowingsScreen(
                          userId: '${controller.getUserByIdModel.user!.id}',
                        ));
                  }
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
              // Image.asset(
              //   'assets/image/msg btn.png',
              //   height: 42.ah,
              //   width: 42.aw,
              //   fit: BoxFit.contain,
              // )
            ],
          ),
        ],
      ),
    );
  }

  //vlogs

  Widget _vlogs() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0.aw, right: 10.aw),
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
                Get.to(() => VlogFullViewNewScreen(
                      videoUrl:
                          '${controller.getUserByIdModel.user!.vlogs![index].videoUrl}',
                      vlogId: controller.getUserByIdModel.user!.vlogs![index].id
                          .toString(),
                    ));
              },
              child: CustomVlogCard(
                vlog: controller.getUserByIdModel.user!.vlogs![index],
              ),
            );
          },
        ),
      ),
    );
  }

  //Blogs
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
          String jsonString =
              "${controller.getUserByIdModel.user!.blogs![index].tags}";
          List<String> tagsList = json.decode(jsonString).cast<String>();
          return CustomBlogCard(blog: controller.getUserByIdModel.user!.blogs![index], tagsList: tagsList,);

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
    return Padding(
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
                    Get.to(()=>PostFullViewScreen( loadPostByid: "${controller.getUserByIdModel.user?.posts![index]}", ));
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
    );
  }



  _bottomSheetWidget2(
      {required BuildContext context001, required String vlogId}) {
    showBottomSheet(
        context: context001,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .15,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    // color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.ah, right: 20.ah),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () async {
                                await ApiRepository.blockUser(
                                    userId:
                                        "${controller.getUserByIdModel.user?.id}");
                                Get.back();
                              },
                              child: Row(
                                children: [
                                  CustomImageView(
                                    height: 38,
                                    width: 38,
                                    imagePath: "assets/image/delete (1).png",
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    child: Text("Block this user"),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ));
        }).closed.then((value) {});
  }
}
