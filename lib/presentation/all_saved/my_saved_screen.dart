import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/models/cateogry_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../data/repositories/api_repository.dart';
import '../Blog/blog_full_view_screen/blogs_full_view_screen.dart';
import '../Vlog/vlog_like_commnet_share_common_view.dart';
import '../vlog_full_view/vlog_full_view.dart';
import 'my_saved_controller.dart';

class AllSavedScreen extends StatefulWidget {
  const AllSavedScreen({super.key});

  @override
  State<AllSavedScreen> createState() => _AllSavedScreenState();
}

class _AllSavedScreenState extends State<AllSavedScreen>
    with SingleTickerProviderStateMixin {
  SavedController controller = Get.put(SavedController());

  int activeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getSavedVlogs();
    controller.getSavedBlog();
    controller.getSavedPosts();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change this to your desired color
    ));

    return SafeArea(
      child: Scaffold(
        appBar: customAppbar(
            context: context,
            title: "AllSaved".tr,
            rightSideWidget: InkWell(
              onTap: () {
                ApiRepository.getCategories().then((value) {
                  print("line 18");
                  controller.categoryModel.value = value;
                });
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.aw),
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 6.ah,
                          ),
                          Opacity(
                            opacity: 0.50,
                            child: Container(
                              width: 48.aw,
                              height: 5.ah,
                              decoration: ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.ah,
                          ),
                          Row(
                            children: [
                              Text(
                                "Category",
                                style: GoogleFonts.roboto().copyWith(
                                    fontSize: 22.fSize,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                if (activeIndex == 0) {
                                  controller.filteredMySavedVlogs.clear();
                                  controller.mySavedVlogs.value?.mySavedVlogs
                                      ?.forEach((element) {
                                    controller.filteredMySavedVlogs
                                        .add(element);
                                  });
                                }
                                if (activeIndex == 1) {
                                  controller.filteredSaveBlogModel.clear();
                                  controller.saveBlogModel.value?.mySavedBlogs
                                      ?.forEach((element) {
                                    controller.filteredSaveBlogModel
                                        .add(element);
                                  });
                                }
                                if (activeIndex == 2) {
                                  controller.filteredMySavedPosts.clear();
                                  controller.mySavedPosts.value?.mySavedPosts
                                      ?.forEach((element) {
                                    controller.filteredMySavedPosts
                                        .add(element);
                                  });
                                }
                                Get.back();
                              },
                              child: Text("All" ?? "")),
                          for (Category data
                              in (controller.categoryModel.value?.categories ??
                                  []))
                            TextButton(
                                onPressed: () {
                                  if (activeIndex == 0) {
                                    controller.filteredMySavedVlogs.clear();
                                    controller.mySavedVlogs.value?.mySavedVlogs
                                        ?.forEach((element) {
                                      if (element.categoryId == data.id) {
                                        controller.filteredMySavedVlogs
                                            .add(element);
                                      }
                                    });
                                  }
                                  if (activeIndex == 1) {
                                    controller.filteredSaveBlogModel.clear();
                                    controller.saveBlogModel.value?.mySavedBlogs
                                        ?.forEach((element) {
                                      if (element.categoryId == data.id) {
                                        controller.filteredSaveBlogModel
                                            .add(element);
                                      }
                                    });
                                  }
                                  if (activeIndex == 2) {
                                    controller.filteredMySavedPosts.clear();
                                    controller.mySavedPosts.value?.mySavedPosts
                                        ?.forEach((element) {
                                      if (element.categoryId == data.id) {
                                        controller.filteredMySavedPosts
                                            .add(element);
                                      }
                                    });
                                  }
                                  Get.back();
                                  // controller.filteredMySavedVlogs.clear();
                                  // controller.mySavedVlogs.value?.mySavedVlogs?.forEach((element) {
                                  //   if (element.categoryId == data.id) {
                                  //     controller.filteredMySavedVlogs.add(element);
                                  //   }
                                  // });
                                  // Get.back();
                                },
                                child: Text(data.name ?? "")),
                          SizedBox(
                            height: 5.ah,
                          ),
                          SizedBox(
                            height: 20.ah,
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Image.asset(
                "assets/icons/filter_icon.png",
                width: 38.aw,
              ),
            )),
        backgroundColor: const Color(0xffE8E8E8),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : MediaQuery.removePadding(
                  removeTop: true,
                  removeBottom: true,
                  context: context,
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0.aw, right: 16.aw),
                        child: Container(
                          height: 52.ah,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(10.adaptSize)),
                          child: Padding(
                            padding: EdgeInsets.all(6.0.adaptSize),
                            child: Row(
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
                                //
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
                                //
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

                                // Container(height: 40,width: 112,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(9.adaptSize)
                                //   ),
                                //   child: Center(child: Text('Vlogs'.tr)),),
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
                ),
        ),
      ),
    );
  }

  //vlogs
  Widget _vlogs() {
    return Obx(() {
      if (controller.mySavedVlogs.value == null) {
        return Center(
          child: CircularProgressIndicator(
            color: MyColor.primaryColor,
          ),
        );
      }
      return SizedBox(
        width: double.infinity,
        child: controller.filteredMySavedVlogs.length == 0
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 240.0.ah),
                  child: Text("No data found"),
                ),
              )
            : Obx(
                () => controller.isLoadingVlogs.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount:
                            controller.filteredMySavedVlogs.value?.length,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // print("vlogId===>${controller.mySavedVlogs.value.mySavedVlogs![index].vlog?.id.toString()}");
                              Get.to(() => VlogFullViewNewScreen(
                                    videoUrl: '${controller.filteredMySavedVlogs![index].vlog?.videoUrl}',
                                    vlogId: controller.filteredMySavedVlogs![index].vlog!.id.toString(),
                                  ));
                              // VlogFulViewScreen
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 205.ah,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10, bottom: 15),
                                        child: CustomImageView(
                                          height: 400.ah,
                                          width: double.infinity,
                                          radius: BorderRadius.circular(
                                              15.adaptSize),
                                          fit: BoxFit.cover,
                                          // color: Colors.black,
                                          imagePath: controller
                                              .filteredMySavedVlogs![index]
                                              .vlog
                                              ?.thumbnailUrl,
                                        ),
                                      ),
                                      vlogInLocationRow(index),
                                      userLikeViewShare(index),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
      );
    });
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
                '${controller.filteredMySavedVlogs![index].vlog?.user?.city}, '
                    .capitalizeFirst!,
                style: TextStyle(
                  color: HexColor('#FFFFFF'),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.fSize,
                ),
              ),
            ),
            Text(
              '${controller.filteredMySavedVlogs![index].vlog?.user?.city}, '
                  .capitalizeFirst!,
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
    DateTime createdAtDate =
        DateTime.parse("${controller.filteredMySavedVlogs![index].createdAt}");
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
                '${controller.filteredMySavedVlogs![index].vlog?.title}'
                    .capitalizeFirst!,
                overflow: TextOverflow.ellipsis,
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
                      imagePath: controller
                          .filteredMySavedVlogs![index].vlog?.user?.avatarUrl,
                      radius: BorderRadius.circular(60),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 89,
                      child: Text(
                        "  ${'${controller.filteredMySavedVlogs![index].vlog?.user?.handle} '.capitalizeFirst!}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xffFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 11.fSize,
                        ),
                      ),
                    ),
                    Text(
                      '${controller.filteredMySavedVlogs![index].vlog?.numberOfViews} views  ',
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
                SizedBox(
                  height: 20,
                  width: 20,
                ),
                VlogLikeCommentsShareView(
                  vlog: controller.filteredMySavedVlogs![index].vlog!,
                ),
                Spacer()
              ],
            ),
          ],
        ),
      ),
    );
  }

//  Blogs

  Widget _blogs() {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () {
          if (controller.saveBlogModel.value == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            child: controller.isLoadingBlog.value
                ? const CircularProgressIndicator()
                : controller.filteredSaveBlogModel.length == 0
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 240.0.ah),
                          child: Text("No data found"),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.filteredSaveBlogModel.length,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          String jsonString =
                              "${controller.filteredSaveBlogModel[index].blog?.tags}";
                          List<String> tagsList =
                              json.decode(jsonString).cast<String>();
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, right: 5),
                            child: InkWell(
                              onTap: () {
                                print(
                                    'blogsId==>${controller..filteredSaveBlogModel[index].blog?.id}');
                                Get.to(() => BlogsFullViewScreen(
                                      id: controller
                                          .filteredSaveBlogModel[index].blog!.id
                                          .toString(),
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomImageView(
                                    height: 144.ah,
                                    width: 144.ah,
                                    fit: BoxFit.cover,
                                    radius: BorderRadius.circular(10),
                                    imagePath: controller
                                        .filteredSaveBlogModel[index]
                                        .blog
                                        ?.imageUrl,
                                  ),
                                  SizedBox(
                                    width: 10.aw,
                                  ),
                                  SizedBox(
                                    height: 144.ah,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 10.ah,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    (tagsList.length < 2
                                                        ? tagsList.length
                                                        : 2);
                                                i++)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5.0.aw),
                                                child: Container(
                                                  height: 20.ah,
                                                  width: 60.aw,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          Colors.transparent),
                                                  child: Center(
                                                    child: Text(
                                                      tagsList[i].tr,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 10.fSize),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 7.0.aw),
                                          child: SizedBox(
                                            width: 220.aw,
                                            child: Text(
                                              '${controller.filteredSaveBlogModel[index].blog?.title}'
                                                  .tr,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18.fSize),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.ah),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 5.aw),
                                            CustomImageView(
                                              height: 35.ah,
                                              width: 35.ah,
                                              fit: BoxFit.cover,
                                              imagePath: controller
                                                  .filteredSaveBlogModel[index]
                                                  .blog
                                                  ?.user
                                                  ?.avatarUrl,
                                              radius: BorderRadius.circular(32),
                                            ),
                                            SizedBox(width: 10.aw),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${controller.filteredSaveBlogModel[index].blog?.user?.fullName}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.fSize,
                                                  ),
                                                ),
                                                Text(
                                                  '${controller.filteredSaveBlogModel[index].blog?.user?.handle}',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.fSize,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.aw),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
      1,
      1,
      1,
      1,
      1,
    ];
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () {
            if (controller.mySavedPosts.value == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              child: controller.filteredMySavedPosts.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 240.0.ah),
                        child: Text("No data found"),
                      ),
                    )
                  : Obx(
                      () => controller.isLoadingPosts.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : StaggeredGrid.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              children: List.generate(
                                controller.filteredMySavedPosts!.length,
                                (index) => StaggeredGridTile.count(
                                  crossAxisCellCount: cont[index % 9],
                                  mainAxisCellCount: cont[index % 9],
                                  child: Center(
                                      child: CustomImageView(
                                    imagePath: controller
                                        .filteredMySavedPosts![index]
                                        .post
                                        ?.imageUrl,
                                    fit: BoxFit.cover,
                                    radius: BorderRadius.circular(10),
                                  )),
                                ),
                              ),
                            ),
                    ),
            );
          },
        ));
  }
}
