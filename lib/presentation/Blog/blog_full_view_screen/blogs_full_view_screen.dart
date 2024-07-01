// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Blog/blog_edit/blogs_edit_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

import '../../../data/models/blog_model.dart';
import '../../../data/repositories/api_repository.dart';
import '../../Vlog/blog_like_commnet_share_common_view.dart';
import '../../Vlog/vlog_like_commnet_share_common_view.dart';
import '../../auth/my_profile_view/my_profile_controller.dart';
import '../PopularBlogModel.dart';
import 'blog_full_view_controller.dart';

class BlogsFullViewScreen extends StatefulWidget {
  final String id;
  final bool ? isOwn;
  const BlogsFullViewScreen({super.key, required this.id ,this.isOwn});

  @override
  State<BlogsFullViewScreen> createState() => _BlogsFullViewScreenState();
}

class _BlogsFullViewScreenState extends State<BlogsFullViewScreen> {

  BlogFullViewController controller =Get.put(BlogFullViewController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getBlogById(id: widget.id);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(()=>controller.isLoading.value ? const Center(child: Scaffold(body: Center(child: CircularProgressIndicator())),) : Scaffold(
          appBar: customAppbarForChat(context: context,name: "${controller.blogByIdModel.blog?.user?.fullName}",handle: "${controller.blogByIdModel.blog?.user?.handle}",imagepath: controller.blogByIdModel.blog?.user?.coverPhotoUrl,editBlogIcon: widget.isOwn== true ? true : false,
            onTap: () {
              _bottomSheetWidget2( vlogId: '');
          },),

            body: Builder(
              builder: (context) {
                controller.context=context;
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CustomImageView(
                            height: 185.ah,
                            width: 351.aw,
                            imagePath: controller.blogByIdModel.blog?.imageUrl,
                            radius: BorderRadius.circular(25),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 20.ah),
                        tags(),
                        SizedBox(height: 20.ah),
                        Text(
                          "${controller.blogByIdModel.blog?.title!.capitalizeFirst}".tr,
                          style:  TextStyle(
                              color: const Color(0xFF000000),
                              fontSize: 18.adaptSize,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.2),
                        ),
                        SizedBox(height: 20.ah),
                        Text(
                          "${controller.blogByIdModel.blog?.body!.capitalizeFirst}".tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.adaptSize,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20.ah),
                        SizedBox(height: 50.ah),
                      ],
                    ),
                  ),
                );
              }
            ),
            bottomNavigationBar: BottomAppBar(
              color: HexColor('#001649'),

              height: 108.ah,

              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25),
                child: SizedBox(
                    child: Column(
                      children: [BlogLikeCommentsShareView(vlog: controller.blogByIdModel.blog!,),
                      ],
                    )),
              ),
            )),
      ),
    );
  }
  Widget tags(){
    String jsonString = "${controller.blogByIdModel.blog?.tags}";
    List<String> tagsList = json.decode(jsonString).cast<String>();
    return    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 0;
        i < (tagsList.length);
        i++)
          Padding(
            padding: EdgeInsets.only(left: 5.0.aw),
            child: Container(
              width: 60,
              height: 20,
              decoration: ShapeDecoration(
                color: Color(0xFFEEEEEE),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.30),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Center(
                child: Opacity(
                  opacity: .50,
                  child: Text(
                    tagsList[i].tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0.08,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
  _bottomSheetWidget2(
      { required String vlogId}) {
    MyProfileController myProfileControllerasd =Get.find();
    BlogFullViewController myProfileController=Get.find();
    showBottomSheet(
        context: myProfileController.context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .25,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Container(
                    // color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.ah, right: 20.ah),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 40,),
                            InkWell(
                              onTap: () async {
                                 await  ApiRepository.deleteBlog(blogId: "${controller.blogByIdModel.blog?.id}");
                                 myProfileControllerasd.getProfile();
                                Get.back();
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
                                  SizedBox(width: 20,),
                                  const SizedBox(
                                    child: Text("Delete this Blog"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            InkWell(
                              onTap: () async {
                                Get.to(()=>BlogsEditScreen(getBlogByIdModel: controller.blogByIdModel,));
                                // Get.to(()=>BlogsEditScreen(getBlogByIdModel: controller.blogByIdModel,));
                              },
                              child: Row(
                                children: [
                                  CustomImageView(
                                    height: 38,
                                    width: 38,
                                    imagePath: "assets/image/edit_with_container.png",
                                  ),
                                  SizedBox(width: 20,),
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
}

