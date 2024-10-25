import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/vlog_full_view/vlog_full_view_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../Widgets/custom_image_view.dart';
import '../../Widgets/custom_textfield.dart';
import '../../Widgets/custom_user_card.dart';
import '../../Widgets/custom_vlog_card.dart';
import '../../core/utils/calculateTimeDifference.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/models/vlog_model.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import '../Vlog/edit_vlog/edit_vlog.dart';
import '../Vlog/vlog_like_commnet_share_common_view.dart';
import '../auth/my_profile_view/my_profile_controller.dart';
import '../user_profile_screen/user_profile_screen.dart';

class VlogFullViewNewScreen extends StatefulWidget {
  String videoUrl;
  String vlogId;

  VlogFullViewNewScreen(
      {super.key, required this.videoUrl, required this.vlogId});

  @override
  State<VlogFullViewNewScreen> createState() => _VlogFullViewNewScreenState();
}

class _VlogFullViewNewScreenState extends State<VlogFullViewNewScreen> {
  bool _isFullScreen = false;

  void _toggleFullScreen() {
    setState(() {
      if (_isFullScreen) {
        //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
      } else {
        //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      }
      _isFullScreen = !_isFullScreen;
    });
  }

  Rxn<VideoPlayerController> _video_play_controller = Rxn(null);
  VlogFullViewController controller =
      Get.put(VlogFullViewController(), permanent: true);






  TextEditingController reasonController = TextEditingController();

  void reportFun(
      BuildContext context
      ) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'vlog_report_reason'.tr,
                style: TextStyle(
                  color: const Color(0XFF111111),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.adaptSize,
                  fontFamily: 'Roboto',
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  width: 300,
                  child: CustomTextFormField(
                    context: context,
                    maxLines: 4,
                    controller: reasonController,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 44.adaptSize,
                          width: 110.adaptSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xff001649), width: 1.aw)),
                          child: Center(
                            child: Text(
                              'cancel'.tr,
                              style: TextStyle(
                                color: const Color(0XFF001649),
                                fontWeight: FontWeight.w700,
                                fontSize: 15.adaptSize,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30.aw),
                      InkWell(
                        onTap: () async {
                          if(reasonController.text.trim().isEmpty || reasonController.text == "" ){
                            Get.snackbar("", "please_enter_report_reason".tr, backgroundColor: Color(0xff001649),colorText: Colors.white);

                          }else{
                            print("vlogid==>${widget.vlogId}");
                            bool isreport =  await ApiRepository.reportPost(postId: widget.vlogId, reason: reasonController.text,postType: "vlog");
                            if(isreport){
                              reasonController.clear();
                              Get.back();
                            }
                          }
                        },
                        child: Container(
                          height: 44.adaptSize,
                          width: 110.adaptSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff001649),
                          ),
                          child: Center(
                            child: Text(
                              'Report'.tr,
                              style: TextStyle(
                                color: const Color(0XFFFFFFFF),
                                fontWeight: FontWeight.w700,
                                fontSize: 15.adaptSize,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
        });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        controller.getVlogById(vlogId: widget.vlogId);
        _video_play_controller.value =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
              ..initialize().then((_) {
                _video_play_controller.value?.play();
                setState(() {});
              });
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .55,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0.ah, right: 20.ah),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "description".tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 25),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${controller.vlogByIdModel.vlog?.description}",
                      style: TextStyle(fontSize: 18.adaptSize),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheetOwnVlog(BuildContext context, String vlogId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0.ah, right: 20.ah),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () async {
                        await ApiRepository.deleteVlog(postId: "${vlogId}");
                        if (Get.isRegistered<MyProfileController>()) {
                          Get.find<MyProfileController>().getProfile();
                        }
                        Get.back();
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
                          SizedBox(
                            child: Text("delete_this_vlog".tr),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        Get.back();
                        Get.to(() => EditVlogScreen(
                              vlogByIdModel: controller.vlogByIdModel,
                            ));
                      },
                      child: Row(
                        children: [
                          CustomImageView(
                            height: 38,
                            width: 38,
                            imagePath: "assets/image/edit_with_container.png",
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            child: Text("edit_this_vlog".tr),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _video_play_controller.value?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _toggleFullScreen();
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          _isFullScreen = true;
          return Scaffold(
            appBar: appBarPrimary(),
            body: Padding(
              padding: EdgeInsets.only(
                left: 18.0.aw,
                right: 18.0.aw,
              ),
              child: Obx(() {
                if (_video_play_controller.value == null) {
                  return const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xff001649)));
                }
                return ListView(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _video_play_controller.value!.value.isPlaying
                                      ? _video_play_controller.value?.pause()
                                      : _video_play_controller.value?.play();
                                });
                              },
                              child: Center(
                                  child: _video_play_controller
                                          .value!.value.isInitialized
                                      ? SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: VideoPlayer(
                                                _video_play_controller.value!),
                                          ),
                                        )
                                      : SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          child: LinearProgressIndicator(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade200,
                                            backgroundColor:
                                                Colors.grey.shade100,
                                          ),
                                        )),
                            ),
                            // VideoProgressIndicator(
                            //     _controller,
                            //     allowScrubbing: true),
                          ],
                        ),
                        Positioned(
                            right: 20,
                            bottom: 20,
                            child: InkWell(
                              onTap: () {
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.landscapeLeft,
                                  DeviceOrientation.landscapeRight
                                ]);
                              },
                              child: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(height: 15.ah),
                    Obx(
                      () => controller.isLoadingVlogById.value
                          ? Container(
                              height: 130.ah,
                              child: LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                                backgroundColor: Colors.grey.shade100,
                              ))
                          : Container(
                              height: 130.ah,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                        height: 50.ah,
                                        width: 50.ah,
                                        fit: BoxFit.cover,
                                        onTap: () {
                                          Get.to(() => UserProfileScreen(
                                                userId:
                                                    '${controller.vlogByIdModel.vlog?.user?.id}',
                                              ));
                                        },
                                        radius: BorderRadius.circular(50),
                                        imagePath: controller.vlogByIdModel.vlog
                                            ?.user?.avatarUrl,
                                      ),
                                      SizedBox(
                                        width: 10.aw,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${controller.vlogByIdModel.vlog?.title}'
                                                .capitalizeFirst!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.adaptSize,
                                                height: 1.5),
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                '${controller.vlogByIdModel.vlog?.user?.fullName} :  '
                                                    .capitalizeFirst!,
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(.50),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11.fSize,
                                                ),
                                              ),
                                              Text(
                                                '${controller.vlogByIdModel.vlog?.numberOfViews} ${"views".tr} :  ',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(.50),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11.fSize,
                                                ),
                                              ),
                                              Builder(builder: (context) {
                                                DateTime currentDate =
                                                    DateTime.now();

                                                return Text(
                                                  calculateTimeDifference(
                                                      controller.vlogByIdModel
                                                              .vlog?.createdAt
                                                              .toString() ??
                                                          "${currentDate}"),
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(.50),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 11.fSize,
                                                  ),
                                                );
                                              }),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Spacer(),

                                      Column(
                                        children: [
                                          PrefUtils().getUserId() == "${controller.vlogByIdModel.vlog?.user?.id}" ?SizedBox() :  InkWell(
                                            onTap: () {
                                            reportFun(context);
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(bottom: 4.0),
                                              child: Icon(Icons.more_vert_outlined),
                                            ),
                                          ),
                                          PrefUtils().getUserId() == "${controller.vlogByIdModel.vlog?.user?.id}"
                                              ? InkWell(
                                                  onTap: () {
                                                    _showBottomSheetOwnVlog(context,
                                                        "${controller.vlogByIdModel.vlog?.id}");
                                                  },
                                                  child: CustomImageView(
                                                    imagePath:
                                                        "assets/image/ic_info_outline_24px.png",
                                                    height: 25,
                                                  ))
                                              : InkWell(
                                                  onTap: () {
                                                    _showBottomSheet(context);
                                                  },
                                                  child: CustomImageView(
                                                    imagePath:
                                                        "assets/image/ic_info_outline_24px.png",
                                                    height: 25,
                                                  )),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.0.aw, right: 2.aw),
                                    child: SizedBox(
                                      height: 34.ah,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${controller.vlogByIdModel.vlog?.user?.numberOfFollower}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.adaptSize,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -0.41,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.aw,
                                          ),
                                          Opacity(
                                            opacity: 0.50,
                                            child: Text(
                                              'Followers'.tr,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.41,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          VlogLikeCommentsShareView(
                                            vlog:
                                                controller.vlogByIdModel.vlog ??
                                                    Vlog(),
                                            colors: true,
                                          ),
                                          const Spacer(),
                                          // Text("data${ PrefUtils().getUserId()}"),
                                          // Text("data${controller.vlogByIdModel.vlog!.user?.id}"),
                                          PrefUtils().getUserId() ==
                                                  "${controller.vlogByIdModel.vlog?.user?.id}"
                                              ? const SizedBox()
                                              : InkWell(
                                                  onTap: () async {
                                                    if (controller.vlogByIdModel
                                                            .vlog!.isFollowed ==
                                                        false) {
                                                      await ApiRepository.follow(
                                                          userId:
                                                              "${controller.vlogByIdModel.vlog?.user?.id}");
                                                      setState(() {
                                                        controller
                                                            .vlogByIdModel
                                                            .vlog!
                                                            .isFollowed = true;
                                                      });
                                                    } else {
                                                      await ApiRepository.unfollow(
                                                          userId:
                                                              "${controller.vlogByIdModel.vlog!.user?.id}");
                                                      setState(() {
                                                        controller
                                                            .vlogByIdModel
                                                            .vlog!
                                                            .isFollowed = false;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 98.aw,
                                                    height: 34.ah,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFF001649),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        controller
                                                                    .vlogByIdModel
                                                                    .vlog
                                                                    ?.isFollowed ==
                                                                false
                                                            ? "Follow".tr
                                                            : "Unfollow".tr,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                    discoverUsers(),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => controller.isLoadingGetVlog.value
                        ? Container()
                        : ListView.builder(
                            itemCount:
                                controller.trendingVlogModel.vlogs?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return CustomVlogCard(
                                isRedrectRormVlogPage: true,
                                vlog:
                                    controller.trendingVlogModel.vlogs![index],
                              );
                            },
                          ))
                  ],
                );
              }),
            ),
          );
        } else {
          _isFullScreen = false;
          return Scaffold(
            body: InkWell(
              onTap: () {
                setState(() {
                  _video_play_controller.value!.value.isPlaying
                      ? _video_play_controller.value!.pause()
                      : _video_play_controller.value!.play();
                });
              },
              child: Stack(
                children: [
                  Center(
                    child: _video_play_controller.value!.value.isInitialized
                        ? ClipRRect(
                            child: VideoPlayer(_video_play_controller.value!),
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 170.ah,
                            child: const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 1,
                            )),
                          ),
                  ),
                  Positioned(
                      right: 20,
                      bottom: 20,
                      child: InkWell(
                        onTap: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                          ]);
                        },
                        child: const SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.fullscreen,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget discoverUsers() {
    VlogFullViewController controller = Get.find<VlogFullViewController>();
    return SizedBox(
      height: 223.ah,
      child: Obx(
        () => controller.isLoadingDiscoveruser.value
            ? Container()
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller
                        .discoverUsersModelData.value.discoverUsers?.length ??
                    0,
                itemBuilder: (context, index) {
                  var users = controller
                      .discoverUsersModelData.value.discoverUsers![index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => UserProfileScreen(
                              userId: '${users.id}',
                            ));
                      },
                      child: CustomUserCard(
                        users: users,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
