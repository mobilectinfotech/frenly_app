import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/Widgets/custom_vlog_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_model.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Widgets/custom_blog_card.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import '../photos/photo_view_screen.dart';
import '../user_follwers/user_followers_screen.dart';
import '../user_follwings_page/user_followings_screen.dart';
import '../vlog_full_view/vlog_full_view.dart';


class UserProfileScreen extends StatefulWidget {
  final String userId;
  final bool ? isOwnn;

  const UserProfileScreen({super.key, required this.userId, this.isOwnn});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  GetUserByIdModel getUserByIdModel = GetUserByIdModel();

  RxBool isLoadingUserById =true.obs;
  RxBool isLoadingGetProfile =true.obs;

  getUserById({required String userId}) async {
    isLoadingUserById.value =true;
    getUserByIdModel =await ApiRepository.getUserById(userId: userId);
    isLoadingUserById.value =false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserById(userId: widget.userId);
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => isLoadingUserById.value
            ? const Center(
                child: CircularProgressIndicator(strokeWidth: 1,),
              )
            : ListView(
             padding: EdgeInsets.zero,
              children: [
                imageView(),
                Obx(
                    ()=> AnimatedContainer(
                    duration:const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height:  _isZoomed.value? 130.h : 10.ah,
                  ),
                ),
               // Obx(() => SizedBox(height: _isZoomed.value? 125.h : 10.ah)),
                 bioTexts(),
                SizedBox(height: 20.ah),
                ((getUserByIdModel.user?.isPrivate == true &&
                            getUserByIdModel.user!.followState ==
                                0) ||
                        (getUserByIdModel.user?.isPrivate ==
                                true &&
                            getUserByIdModel.user!.followState ==
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
                                        Text('this_account'.tr,
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
                                            'follow this account'.tr,
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
      padding: EdgeInsets.only(left: 10.0.aw, right: 10.aw, top: 0.ah),
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
          Container(
            child: InkWell(
                onTap: () {
                  //_bottomSheetWidget2(context001: context, vlogId: '2');
                   ApiRepository.blockUser(userId: "${ getUserByIdModel.user?.id}");
                },
                child: PopupMenuButton<String>(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  icon: SvgPicture.asset('assets/icons/more option.svg',height: 23,fit: BoxFit.cover,),
                  onSelected: (String result) async{
                    // Handle the selection from the menu
                    print(result);
                    if(result=="1"){
                      ApiRepository.blockUser(userId: "${ getUserByIdModel.user?.id}");
                      Get.back();
                      Get.back();
                      // Get.to(()=> BlogsEditScreen(getBlogByIdModel: controller.blogByIdModel,));
                    }

                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                     PopupMenuItem<String>(
                      value: '1',
                      child: Text('block_this'.tr),
                    ),

                  ],
                )
                //const Icon(Icons.more_vert_outlined)
            ),
          ),
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
              imagePath: getUserByIdModel.user?.coverPhotoUrl,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 121.aw,
            child:  ProfileZoom(imageUrl: getUserByIdModel.user?.avatarUrl,),
            // child: InkWell(
            //   onTap: () {
            //     ProfileZoom(imageUrl: getUserByIdModel.user?.avatarUrl ??"",);
            //     // showDialog(context: context, builder: (BuildContext context) {
            //     //   return CustomImageView(
            //     //     width: 140.ah,
            //     //     height: 140.ah,
            //     //     fit: BoxFit.cover,
            //     //     imagePath: getUserByIdModel.user?.avatarUrl,
            //     //     radius: BorderRadius.circular(100),
            //     //   );
            //     // });
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(500)),
            //     child: Padding(
            //       padding: const EdgeInsets.all(4.0),
            //       child: CustomImageView(
            //         width: 140.ah,
            //         height: 140.ah,
            //         fit: BoxFit.cover,
            //         imagePath: getUserByIdModel.user?.avatarUrl,
            //         radius: BorderRadius.circular(100),
            //       ),
            //     ),
            //   ),
            // ),
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
                    '${getUserByIdModel.user?.fullName?.trim()}'
                        .capitalizeFirst!,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.fSize),
                  ),
                  Text(
                    getUserByIdModel.user?.handle?.trim() ?? "",
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
                      if (getUserByIdModel.user?.followState == 0) {
                        getUserByIdModel.user?.followState = 1;
                        setState(() {});
                        ApiRepository.follow(
                            userId: "${getUserByIdModel.user!.id!}");
                      } else {
                        getUserByIdModel.user?.followState = 0;
                        setState(() {});
                        ApiRepository.unfollow(
                            userId: "${getUserByIdModel.user!.id!}");
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
                      getUserByIdModel.user?.followState == 1
                          ? getUserByIdModel.user?.isPrivate == false
                              ? "Following".tr
                              : "Requested".tr
                          : getUserByIdModel.user?.followState == 0
                              ? "Follow".tr
                              : "Following".tr,
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
            (getUserByIdModel.user?.bio??'').capitalizeFirst ?? "",
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
                    '${getUserByIdModel.user?.numberOfPosts}',
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
                  if (getUserByIdModel.user!.isPrivate!) {
                    if (getUserByIdModel.user!.followState == 2) {
                      Get.to(() => UserFollowersScreen(
                            userId: '${getUserByIdModel.user!.id}',
                          ));
                    }
                  } else {
                    Get.to(() => UserFollowersScreen(
                          userId: '${getUserByIdModel.user!.id}',
                        ));
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${getUserByIdModel.user?.numberOfFollower}',
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
                  if (getUserByIdModel.user!.isPrivate!) {
                    if (getUserByIdModel.user!.followState == 2) {
                      Get.to(() => UserFollowingsScreen(
                            userId: '${getUserByIdModel.user!.id}',
                          ));
                    }
                  } else {
                    Get.to(() => UserFollowingsScreen(
                          userId: '${getUserByIdModel.user!.id}',
                        ));
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${getUserByIdModel.user?.numberOfFollowing}',
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
          itemCount: getUserByIdModel.user!.vlogs!.length,
          padding: const EdgeInsets.only(bottom: 10),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(() => VlogFullViewNewScreen(
                      videoUrl:
                          '${getUserByIdModel.user!.vlogs![index].videoUrl}',
                      vlogId: getUserByIdModel.user!.vlogs![index].id
                          .toString(),
                    ));
              },
              child: CustomVlogCard(
                vlog: getUserByIdModel.user!.vlogs![index],
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
        itemCount: getUserByIdModel.user!.blogs!.length,
        padding: const EdgeInsets.only(bottom: 10),
        itemBuilder: (context, index) {
          String jsonString =
              "${getUserByIdModel.user!.blogs![index].tags}";
          List<String> tagsList = json.decode(jsonString).cast<String>();
          return CustomBlogCard(blog: getUserByIdModel.user!.blogs![index], tagsList: tagsList,);

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
          getUserByIdModel.user!.posts!.length,
              (index) => StaggeredGridTile.count(
            crossAxisCellCount: cont[index % 9],
            mainAxisCellCount: cont[index % 9],
            child: Center(
                child: InkWell(
                  onTap: () {
                    Get.to(()=>PostFullViewScreen( loadPostByid: "${getUserByIdModel.user?.posts![index].id}", ));
                  },
                  child: CustomImageView(
                    imagePath:
                    getUserByIdModel.user?.posts![index].imageUrl,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(10),
                  ),
                )),
          ),
        ),
      ),
    );
  }



}


RxBool _isZoomed = false.obs;
class ProfileZoom extends StatefulWidget {
   String ? imageUrl;

  ProfileZoom({required this.imageUrl});

  @override
  _ProfileZoomState createState() => _ProfileZoomState();
}

class _ProfileZoomState extends State<ProfileZoom> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 3.0).animate(_controller);
  }

  void _zoomImage() {
    setState(() {
      if (_isZoomed.value) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isZoomed.value = !_isZoomed.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _zoomImage,
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
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
                    imagePath: widget.imageUrl,
                    radius: BorderRadius.circular(100),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
