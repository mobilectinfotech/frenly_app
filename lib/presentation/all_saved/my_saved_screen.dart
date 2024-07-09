import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/Widgets/custom_vlog_card.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/models/cateogry_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/custom_blog_card.dart';
import '../../data/repositories/api_repository.dart';
import '../Blog/blog_full_view_screen/blogs_full_view_screen.dart';
import '../photos/photo_view_screen.dart';
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
                      padding: EdgeInsets.only(left: 20.aw,top: 20.aw,right: 20.aw),
                      width: double.infinity,
                      child: ListView(

                        children: [
                          SizedBox(
                            height: 6.ah,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                            ],
                          ),
                          SizedBox(
                            height: 24.ah,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

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
                              child:const Text("All" ?? "")),
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
                  child: CircularProgressIndicator(strokeWidth: 1,),
                )
              : ListView(
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
    );
  }

  Widget _vlogs() {
    return Obx(() {
      if (controller.mySavedVlogs.value == null) {
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 1,
            color: MyColor.primaryColor,
          ),
        );
      }
      return SizedBox(
        width: double.infinity,
        child: controller.filteredMySavedVlogs.isEmpty
            ? Center(
          child: Padding(
            padding: EdgeInsets.only(top: 240.0.ah),
            child:const Text("No data found"),
          ),
        )
            : Obx(
              () => controller.isLoadingVlogs.value
              ? const Center(
            child: CircularProgressIndicator(strokeWidth: 1,),
          )
              : Padding(
            padding: const EdgeInsets.only(left: 16 ,right : 16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: controller.filteredMySavedVlogs.value.length,
              padding: const EdgeInsets.only(bottom: 10),
              itemBuilder: (context, index) {
                return CustomVlogCard(vlog: controller.filteredMySavedVlogs[index].vlog!,);
              },
            ),
          ),
        ),
      );
    });
  }



//  Blogs

  Widget _blogs() {
    return SizedBox(
      width: double.infinity,
      child: Obx(
            () {
          if (controller.saveBlogModel.value == null) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 1,),
            );
          }
          return Container(
            child: controller.isLoadingBlog.value
                ? const CircularProgressIndicator(strokeWidth: 1,)
                : controller.filteredSaveBlogModel.isEmpty
                ? Center(
              child: Padding(
                padding: EdgeInsets.only(top: 240.0.ah),
                child: const Text("No data found"),
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: controller.filteredSaveBlogModel.length,
              padding: const EdgeInsets.only(bottom: 10),
              itemBuilder: (context, index) {
                String jsonString = "${controller.filteredSaveBlogModel[index].blog?.tags}";
                List<String> tagsList = json.decode(jsonString).cast<String>();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 5),
                  child: InkWell(
                    onTap: () {
                      print('blogsId==>${controller..filteredSaveBlogModel[index].blog?.id}');
                      Get.to(() => BlogsFullViewScreen(
                        id: controller
                            .filteredSaveBlogModel[index].blog!.id
                            .toString(),
                      ));
                    },
                    child: CustomBlogCard(
                      blog: controller.filteredSaveBlogModel[index].blog!, tagsList: tagsList,


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
            if (controller.filteredMySavedPosts.value == null) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 1,),
              );
            }
            return Container(
              child: controller.filteredMySavedPosts.isEmpty
                  ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 240.0.ah),
                  child:const Text("No data found"),
                ),
              )
                  : Obx(
                    () => controller.isLoadingPosts.value
                    ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 1,),
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
                      child: InkWell(
                        onTap: () {
                          Get.to(()=> PostFullViewScreen(loadPostByid: "${controller.filteredMySavedPosts![index].post?.id}",));
                        },
                        child: Center(child: CustomImageView(
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
              ),
            );
          },
        ));
  }
}
