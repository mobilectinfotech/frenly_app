import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/photos/photo_view_screen.dart';
import 'package:frenly_app/presentation/photos/photo_list/post_view_all_contorller.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_image_view.dart';
import 'package:get/get.dart';
import '../PostLikeCommentsShareView.dart';



class PhotoViewAllNewScreen extends StatefulWidget {
  const PhotoViewAllNewScreen({super.key});

  @override
  State<PhotoViewAllNewScreen> createState() => _PhotoViewAllNewScreenState();
}

class _PhotoViewAllNewScreenState extends State<PhotoViewAllNewScreen> {

  PostAllViewController controller = Get.put(PostAllViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary(title: "Posts".tr ,),
      body: SafeArea(
        child: Obx(
          ()=> controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),) : Padding(
              padding:  EdgeInsets.only(left: 15.h,right: 15.h,),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom:10.v),
                itemCount: controller.getAllPostsModel.posts?.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(8.0.adaptSize),
                        child: InkWell(
                          onTap: () {
                            Get.to(()=>UserProfileScreen(userId: "${controller.getAllPostsModel.posts?[index].user?.id}"));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomImageView(
                                height: 50.ah,
                                width: 50.ah,
                                imagePath: controller.getAllPostsModel.posts?[index].user?.avatarUrl,
                                radius: BorderRadius.circular(60.ah),
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10.aw),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${controller.getAllPostsModel.posts?[index].user?.fullName}".capitalizeFirst!,
                                    style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.w700,fontSize:20.fSize,
                                    ),),
                                  Text("${controller.getAllPostsModel.posts?[index].user?.handle}",
                                    style: TextStyle(
                                      color: Colors.grey,fontWeight: FontWeight.w500,fontSize:14.fSize,
                                    ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.ah),
                      Stack(
                        children: [
                          CustomImageView(
                            width: 385.adaptSize,
                            height: 385.adaptSize,
                            imagePath: controller.getAllPostsModel.posts?[index].imageUrl,
                            radius: BorderRadius.circular(25),
                            fit: BoxFit.cover,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(()=>PostFullViewScreen(loadPostByid: "${ controller.getAllPostsModel.posts?[index].id}"));
                            },
                            child: Container(
                                width: 385.adaptSize,
                                height: 385.adaptSize,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 335.adaptSize,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15),
                                      child: Text("${controller.getAllPostsModel.posts?[index].caption}".capitalizeFirst!,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.adaptSize ,fontWeight: FontWeight.w400,color: Colors.white),),
                                    ),
                                  ],
                                )

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.ah),
                      PostLikeCommentsShareView(post: controller.getAllPostsModel.posts![index],),
                      SizedBox(height: 20.ah),
                    ],
                  );
                },
              )
          ),
        ),
      ),
    );
  }

}
