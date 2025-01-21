import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/post/post_list/post_list_controller.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import '../../../Widgets/bottom_sheet_widgets.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_image_view.dart';
import 'package:get/get.dart';
import '../../../core/constants/my_colour.dart';
import '../../../core/utils/calculateTimeDifference.dart';
import '../../../data/repositories/api_repository.dart';
import '../../Vlog/vlog_full_view/vlog_view_screen.dart';
import '../post_view/post_view_screen.dart';


class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {

  PostListController controller = Get.put(PostListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary(title: "Posts".tr ,),
      body: SafeArea(
        child: Obx(
              ()=> controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),) : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.aw),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom:10.v),
                  itemCount: controller.postListModel.value?.posts?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(()=>PostViewScreen(id: "${controller.postListModel.value?.posts?[index].id}"));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildUserInfoRow(index),
                          SizedBox(height: 20.ah,),
                          Obx(()=> CustomImageView(
                              radius: BorderRadius.circular(20),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              imagePath: controller.postListModel.value?.posts?[index].imageUrl,
                            ),
                          ),
                          SizedBox(height: 10.ah,),
                          buildVlogDetails(index),
                          SizedBox(height: 8.ah),
                          buildLikeShareSaveRow(index),
                          SizedBox(height: 40.ah),
                        ],
                      ),
                    );
                  },
                ),
              ),
        ),
      ),
    );
  }

  Widget buildUserInfoRow(int index) {
    return Row(
      children: [
        Obx(() {
          final user =   controller.postListModel.value?.posts?[index].user;
          return CustomImageView(
            height: 30.adaptSize,
            width: 30.adaptSize,
            fit: BoxFit.cover,
            onTap: () {
              Get.to(() => UserProfileScreen(userId: "${user?.id}"));
            },
            radius: BorderRadius.circular(50),
            imagePath: user?.avatarUrl,
          );
        }),
        const SizedBox(width: 10),
        Obx(() {
          final handle =controller.postListModel.value?.posts?[index].user?.handle ?? "";
          return Text(
            handle,
            style: TextStyle(
              color: Colors.black.withOpacity(0.90),
              fontWeight: FontWeight.w600,
              fontSize: 12.fSize,
            ),
          );
        }),
        const Spacer(),
        InkWell(
          onTap: () {
            VlogBottomSheets.vlogmenuBottomSheet(
                context: context,
                id:"${controller.postListModel.value?.posts?[index].id}",
                postType: PostType.post,
                userHandle: controller.postListModel.value?.posts?[index].user?.handle ?? '',
                isUrl:  controller.postListModel.value?.posts?[index].imageUrl ?? '',
                userId: "${ controller.postListModel.value?.posts?[index].user?.id}"
            );
          },
          child: Icon(Icons.more_vert_outlined, color: Colors.black.withOpacity(0.90), size: 20),
        ),
      ],
    );
  }
  Widget buildLikeShareSaveRow(int  index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () async {
                if(  controller.postListModel.value!.posts![index].alreadyLiked){
                     controller.postListModel.value?.posts![index].numberOfLikes = (   controller.postListModel.value!.posts![index].numberOfLikes! -1);                       controller.postListModel.value?.posts![index].alreadyLiked=true;
                     controller.postListModel.value?.posts![index].alreadyLiked=false;
                }else{
                     controller.postListModel.value?.posts![index].alreadyLiked=true;
                     controller.postListModel.value?.posts![index].numberOfLikes = (   controller.postListModel.value!.posts![index].numberOfLikes! +1);                       controller.postListModel.value?.posts![index].alreadyLiked=true;
               }
                 controller.postListModel.refresh();
                await ApiRepository.likeVlogBlogPost(userId: "${  controller.postListModel.value?.posts![index].id}", postType:PostType.post);
                // controller.getBlogById(id: widget.id,isLoadingg: false);
              },
              child: Obx(
                    ()=> CustomImageView(
                  imagePath:   controller.postListModel.value?.posts![index].alreadyLiked?? false
                      ? 'assets/image/love_true_blue.svg'
                      : 'assets/image/love_false_blue.svg',
                  width: 21.aw,
                  height: 21.aw,
                ),
              ),
            ),
            const SizedBox(width: 20),
            if(  controller.postListModel.value?.posts![index].commentAllowed ?? true)
              InkWell(
                onTap: () {
                  VlogBottomSheets.commentsBottomSheet(
                    context: context,
                    id: "${ controller.postListModel.value?.posts![index].id}",
                    postType: PostType.post,
                  );
                },
                child: CustomImageView(
                  imagePath: 'assets/image/comments_blue.png',
                  width: 21.aw,
                  height: 21.aw,
                ),
              ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                VlogBottomSheets.shareBottomSheet(
                  context: context,
                  id: "${ controller.postListModel.value?.posts![index].id}",
                  postType: PostType.post,
                  userName:   controller.postListModel.value?.posts![index].user?.handle ?? '',
                  isUrl:   controller.postListModel.value?.posts![index].imageUrl ?? '',
                );
              },
              child: CustomImageView(
                imagePath: 'assets/image/Vector (1).png',
                color: MyColor.primaryColor,
                height: 21.aw,
              ),
            ),
            const Spacer(),
            Obx(() {
              final alreadySaved =   controller.postListModel.value?.posts![index].alreadySaved ?? false;
              return InkWell(
                onTap: () async {
                  if (alreadySaved) {
                    await ApiRepository.saveAllById(
                      postType: PostType.post,
                      id: "${  controller.postListModel.value?.posts![index].id}",
                      categoryId: "0",
                    );
                  } else {
                    await VlogBottomSheets.saveBottomSheet(
                      context: context,
                      id: "${ controller.postListModel.value?.posts![index].id}",
                      postType: PostType.post,
                    );
                  }
               //   controller.getPostByid(id: "${ controller.getAllPostsModel.value!.posts![index].id}",isLoading: false);
                },
                child: CustomImageView(
                  imagePath: alreadySaved
                      ? 'assets/image/save_true_blue.svg'
                      : 'assets/image/save_false_blue.svg',
                  width: 21.aw,
                  height: 21.aw,
                ),
              );
            }),
          ],
        ),
        SizedBox(height: 5.ah,),
        if(  controller.postListModel.value?.posts![index].numberOfLikes != 0)
          Obx(
                ()=> Text(
              '${  controller.postListModel.value?.posts![index].numberOfLikes} likes',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 11.fSize,
              ),
            ),
          ),
        SizedBox(height: 0.ah,),
        if(  controller.postListModel.value?.posts![index].numberOfComments != 0)
          Obx(
                ()=> InkWell(
                  onTap: () {
                    VlogBottomSheets.commentsBottomSheet(
                      context: context,
                      id: "${ controller.postListModel.value?.posts![index].id}",
                      postType: PostType.post,
                    );
                  },
                  child: Text('View all ${ controller.postListModel.value?.posts![index].numberOfComments} comments',
                   style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.fSize,
                                ),
                              ),
                ),
          ),
      ],
    );
  }
  Widget buildVlogDetails( int  index) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Obx(
              //       ()=>  post?.tags != null ?
              //   tags() : SizedBox(),
              // ),
              Obx(() {
                final views = "${controller.postListModel.value?.posts![index].caption}" ?? "0";
                // return Text(
                //   views.capitalizeFirst!,

                // );
                return HighlightHashtags(text: views,);
              }),
              // Obx(() {
              //   final views =   controller.postListModel.value?.posts![index].caption ?? "0";
              //   return Text(
              //     views.capitalizeFirst!,
              //     style: TextStyle(
              //       color: MyColor.primaryColor,
              //       fontWeight: FontWeight.w500,
              //       fontSize: 14.fSize,
              //       letterSpacing: 0.0,
              //     ),
              //   );
              // }),
              const SizedBox(height: 5,),
              Obx(() {
                final createdAt =   controller.postListModel.value?.posts![index].createdAt?.toString() ?? "";
                return Text(
                  calculateTimeDifference(createdAt),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.50),
                    fontWeight: FontWeight.w500,
                    fontSize: 11.fSize,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
