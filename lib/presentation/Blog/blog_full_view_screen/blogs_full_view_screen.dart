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
import '../../user_profile_screen/user_profile_screen.dart';
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


  void deleteFun(
      BuildContext context,
      ) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text('Are you sure, you want to delete this post?',
                style: TextStyle(
                  color: const Color(0XFF111111),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.adaptSize,
                  fontFamily: 'Roboto',
                ),
              ),
              actions: <Widget>[
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
                              border: Border.all(color:Color(0xff001649),width: 1.aw)),
                          child: Center(
                            child: Text(
                              'Cancel',
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
                      SizedBox(width: 15.aw),
                      InkWell(
                        onTap: () async{
                          Get.back();
                          Get.back();
                          await  ApiRepository.deleteBlog(blogId: "${controller.blogByIdModel.blog?.id}");
                          if(Get.isRegistered<MyProfileController>()) {
                            Get.find<MyProfileController>().getProfile(); //done
                          }
                          // await   ApiRepository.deletePost(postId: "${postSingleViewModel?.post?.id}");
                          // Get.back();
                          // Get.back();
                          // if(Get.isRegistered<MyProfileController>()) {
                          //   Get.find<MyProfileController>().getProfile(); //asdfg
                          // }
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
                              'Delete',
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
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(),
          body:  Obx(()=> controller.isLoading.value ? Center(child: CircularProgressIndicator(strokeWidth: 1,)) : Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
            child: ListView(

              children: [
                InkWell(
                  onTap: () {
                    Get.to(()=> UserProfileScreen(userId: "${controller.blogByIdModel.blog?.user?.id}"));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                        height: 50.ah,
                        width: 50.ah,
                        imagePath: controller.blogByIdModel.blog?.user?.avatarUrl,
                        radius: BorderRadius.circular(60.ah),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10.aw),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${controller.blogByIdModel.blog?.user?.fullName}".capitalizeFirst!,
                            style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w700,fontSize:20.fSize,
                            ),),
                          Text("${controller.blogByIdModel.blog?.user?.handle}",
                            style: TextStyle(
                              color: Colors.grey,fontWeight: FontWeight.w500,fontSize:14.fSize,
                            ),),
                        ],
                      ),
                      const Spacer(),
                      widget.isOwn ==true ? InkWell(
                        onTap: () {
                          // This is left empty as the PopupMenuButton handles the tap
                        },
                        child: PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_vert_outlined,
                            size: 30,
                          ),
                          onSelected: (String result) async{
                            // Handle the selection from the menu
                            print(result);
                            if(result=="1"){
                              Get.to(()=> BlogsEditScreen(getBlogByIdModel: controller.blogByIdModel,));

                            }
                            if(result=="2"){
                              // Get.back();
                              deleteFun(context);
                            }

                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: '1',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<String>(
                              value: '2',
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ) : SizedBox(),
                      SizedBox(width: 10.aw),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
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
          )),
          bottomNavigationBar: Obx(()=> controller.isLoading.value ? Center(child: CircularProgressIndicator(strokeWidth: 1,)) : BottomAppBar(
            color: HexColor('#001649'),

            height: 108.ah,

            child: Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: SizedBox(
                  child: Column(
                    children: [BlogLikeCommentsShareView(blog: controller.blogByIdModel.blog!,),
                    ],
                  )),
            ),
          )));
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
}

