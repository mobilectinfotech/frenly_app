import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/vlog_full_view/vlog_full_view_controller.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';
import '../../Widgets/custom_image_view.dart';
import '../../Widgets/custom_user_card.dart';
import '../../Widgets/custom_vlog_card.dart';
import '../../core/utils/calculateTimeDifference.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/repositories/api_repository.dart';
import '../Vlog/edit_vlog/edit_vlog.dart';
import '../Vlog/vlog_like_commnet_share_common_view.dart';
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
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      }
      _isFullScreen = !_isFullScreen;
    });
  }

  late VideoPlayerController _video_play_controller;
  VlogFullViewController controller = Get.put(VlogFullViewController());

  @override
  void initState() {
    super.initState();
    controller.getVlogById(vlogId: widget.vlogId);
    _video_play_controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            _video_play_controller.play();
            setState(() {});
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _video_play_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _toggleFullScreen();
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            _isFullScreen = true;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _video_play_controller.value.isPlaying
                                      ? _video_play_controller.pause()
                                      : _video_play_controller.play();
                                });
                              },
                              child: Center(
                                  child: _video_play_controller
                                          .value.isInitialized
                                      ? SizedBox(
                                          width:MediaQuery.of(context).size.width,
                                          height: 200,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: VideoPlayer(
                                                _video_play_controller),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 200.0,
                                          height: 100.0,
                                          child: Container(
                                            width:MediaQuery.of(context).size.width,
                                            height: 200,
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
                    Obx(
                      () => controller.isLoadingVlogById.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                userLikeViewShare1(context),
                                SizedBox(
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
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.41,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        VlogLikeCommentsShareView(
                                          vlog: controller.vlogByIdModel.vlog!,
                                          colors: true,
                                        ),
                                        Spacer(),
                                        // Text("data${ PrefUtils().getUserId()}"),
                                        // Text("data${controller.vlogByIdModel.vlog!.user?.id}"),
                                        PrefUtils().getUserId() ==
                                                "${controller.vlogByIdModel.vlog!.user?.id}"
                                            ? const SizedBox()
                                            : InkWell(
                                                onTap: () async {
                                                  if (controller.vlogByIdModel
                                                          .vlog!.isFollowed ==
                                                      false) {
                                                    await ApiRepository.follow(
                                                        userId:
                                                            "${controller.vlogByIdModel.vlog!.user?.id}");
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
                                                    color:
                                                        const Color(0xFF001649),
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
                                                                  .vlog!
                                                                  .isFollowed ==
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                    ),


                    discoverUsers(),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => controller.isLoadingGetVlog.value
                        ? Container()
                        : ListView.builder(
                            itemCount:
                                controller.trendingVlogModel.vlogs?.length ?? 0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return CustomVlogCard(
                                vlog:
                                    controller.trendingVlogModel.vlogs![index],
                              );
                            },
                          ))
                  ],
                ),
              ),
            );
          } else {
            _isFullScreen = false;
            return InkWell(
              onTap: () {
                setState(() {
                  _video_play_controller.value.isPlaying
                      ? _video_play_controller.pause()
                      : _video_play_controller.play();
                });
              },
              child: Stack(
                children: [
                  Center(
                    child: _video_play_controller.value.isInitialized
                        ? ClipRRect(
                            child: VideoPlayer(_video_play_controller),
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 170.ah,
                            child: const Center(
                                child: CircularProgressIndicator()),
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
            );
          }
        },
      ),
    );
  }

  Widget userLikeViewShare1(BuildContext context001) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          // color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                height: 50.ah,
                width: 50.ah,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(50),
                imagePath: controller.vlogByIdModel.vlog?.user?.avatarUrl,
              ),
              SizedBox(
                width: 10.aw,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${controller.vlogByIdModel.vlog?.title}'.capitalizeFirst!,
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
                          color: Colors.black.withOpacity(.50),
                          fontWeight: FontWeight.w600,
                          fontSize: 11.fSize,
                        ),
                      ),
                      Text(
                        '${controller.vlogByIdModel.vlog?.numberOfViews} views :  ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.50),
                          fontWeight: FontWeight.w600,
                          fontSize: 11.fSize,
                        ),
                      ),
                      Builder(builder: (context) {
                        DateTime currentDate = DateTime.now();
                        DateTime createdAtDate = DateTime.parse(
                            "${controller.vlogByIdModel.vlog?.createdAt}");

                        return Text(
                          calculateTimeDifference(controller
                              .vlogByIdModel.vlog!.createdAt
                              .toString()),
                          style: TextStyle(
                            color: Colors.black.withOpacity(.50),
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
              PrefUtils().getUserId() ==
                      "${controller.vlogByIdModel.vlog?.user?.id}"
                  ? InkWell(
                      onTap: () {
                        _bottomSheetWidget3(
                            vlogId: '${controller.vlogByIdModel.vlog?.id}');
                      },
                      child: CustomImageView(
                        imagePath: "assets/image/ic_info_outline_24px.png",
                        height: 25,
                        color: Colors.red,
                      ))
                  : InkWell(
                      onTap: () {
                        _bottomSheetWidget2();
                      },
                      child: CustomImageView(
                        imagePath: "assets/image/ic_info_outline_24px.png",
                        height: 25,
                      )),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ),
      ],
    );
  }

  _bottomSheetWidget3({required String vlogId}) {
    showBottomSheet(
        context: controller.context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .25,
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () async {
                                await ApiRepository.deleteVlog(
                                    postId: "${vlogId}");
                                // myProfileControllerasd.getProfile();
                                Get.back();
                              },
                              child: Row(
                                children: [
                                  CustomImageView(
                                    height: 38,
                                    width: 38,
                                    imagePath: "assets/image/delete (1).png",
                                  ),
                                  //Pramodvishwakarma08/colleage_thriver
                                  //Pramodvishwakarma08/colleage_thriver
                                  //Pramodvishwakarma08/colleage_thriver
                                  SizedBox(
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    child: Text("Delete this Blog"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                //   Get.to(()=>BlogsEditScreen(getBlogByIdModel: vlogId,));
                                Get.to(() => EditVlogScreen(
                                      vlogByIdModel: controller.vlogByIdModel,
                                    ));
                              },
                              child: Row(
                                children: [
                                  CustomImageView(
                                    height: 38,
                                    width: 38,
                                    imagePath:
                                        "assets/image/edit_with_container.png",
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    child: Text("Edit this Blog"),
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

  _bottomSheetWidget2() {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .50,
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.infinity,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              "Description",
                              style: TextStyle(
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
                ),
              ));
        }).closed.then((value) {});
  }

  Widget discoverUsers() {
    VlogFullViewController controller = Get.put(VlogFullViewController());
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
                      child:CustomUserCard( users: users,),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
