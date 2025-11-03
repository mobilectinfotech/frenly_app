import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:photo_view/photo_view.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/post/post_view/post_view_controller.dart';
import 'package:get/get.dart';
import '../../../../Widgets/bottom_sheet_widgets.dart';
import '../../../../Widgets/custom_image_view.dart';
import '../../../../core/constants/my_colour.dart';
import '../../../../core/utils/calculateTimeDifference.dart';
import '../../../../data/repositories/api_repository.dart';
import '../../Vlog/vlog_full_view/vlog_view_screen.dart';
import '../../auth/my_profile_view/my_profile_screen.dart';
import '../../search/search_page.dart';
import '../../user_profile_screen/user_profile_screen.dart';

class PostViewScreen extends StatefulWidget {
  final bool? own;
  final String? id;
  PostViewScreen({Key? key, required this.id,  this.own}) : super(key: key);

  @override
  State<PostViewScreen> createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  final PostViewController controller = Get.put(PostViewController());

  @override
  void initState() {
    super.initState();
    controller.getPostByid(id: "${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("_post".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(()=> controller.isLoadingPostsingle.value ? Center(child: CircularProgressIndicator()) :
        ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 10.ah,),
            buildUserInfoRow(),

            ///PramodCode
            // Padding(
            //   padding:  EdgeInsets.all(20.0.aw),
            //   child: Obx(()=> CustomImageView(
            //       radius: BorderRadius.circular(20),
            //       fit: BoxFit.cover,
            //     imagePath: controller.postSingleViewModel.value?.post?.imageUrl,
            //     ),
            //   ),
            // ),

            Padding(
              padding: EdgeInsets.all(20.0.aw),
              child: Obx(()=> InstaImageViewer(
                      child: CustomImageView(
                        radius: BorderRadius.circular(20),
                        fit: BoxFit.cover,
                        imagePath: controller.postSingleViewModel.value?.post?.imageUrl,
                 ),
               ),
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.all(20.0.aw),
            //   child: Obx(() {
            //       final imageUrl = controller.postSingleViewModel.value?.post?.imageUrl ?? '';
            //       return ClipRRect(
            //         borderRadius: BorderRadius.circular(20),
            //         child: Container(
            //           height: 200.ah,
            //           width: Get.width,
            //           child: PhotoView(
            //             backgroundDecoration: const BoxDecoration(color: Colors.transparent),
            //             imageProvider: NetworkImage(imageUrl),
            //             minScale: PhotoViewComputedScale.contained,
            //             maxScale: PhotoViewComputedScale.covered * 3.0,
            //             initialScale: PhotoViewComputedScale.contained,
            //             heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),

            buildVlogDetails(),
            const SizedBox(height: 15),
            buildLikeShareSaveRow(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget buildUserInfoRow() {
    return Row(
      children: [
        const SizedBox(width: 20),
        InkWell(
          onTap: () {
          final user = controller.postSingleViewModel.value?.post?.user;
          Get.to(() => UserProfileScreen(userId: "${user?.id}"));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                final user = controller.postSingleViewModel.value?.post?.user;
                return CustomImageView(
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  fit: BoxFit.cover,
                  onTap:(){
                  // Get.to(() => UserProfileScreen(userId: "${user?.id}"));
                   Get.to(() => MyProfileScreen(userId: "${user?.id}"));
                  },
                  radius: BorderRadius.circular(50),
                  imagePath: user?.avatarUrl,
                );
              }),

              const SizedBox(width: 10),
              Obx(() {
                final handle = controller.postSingleViewModel.value?.post?.user?.handle ?? "";
                return Text(handle,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.90),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.fSize));
              }),
            ],
          ),
        ),

        const Spacer(),
        InkWell(
          onTap: () {
            VlogBottomSheets.vlogmenuBottomSheet(
                context: context,
                id:"${widget.id}",
                postType: PostType.post,
                userHandle: controller.postSingleViewModel.value?.post?.user?.handle ?? '',
                isUrl: controller.postSingleViewModel.value?.post?.imageUrl ?? '',
                userId: "${controller.postSingleViewModel.value?.post?.user?.id}"
            );
          },
          child: Icon(Icons.more_vert_outlined, color: Colors.black.withOpacity(0.90), size: 20),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget buildLikeShareSaveRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.aw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  if(controller.postSingleViewModel.value!.post!.alreadyLiked){
                    controller.postSingleViewModel.value!.post!.numberOfLikes = (controller.postSingleViewModel.value!.post!.numberOfLikes! -1);                    controller.postSingleViewModel.value!.post!.alreadyLiked=true;
                    controller.postSingleViewModel.value!.post!.alreadyLiked=false;
                  }else{
                    controller.postSingleViewModel.value!.post!.alreadyLiked=true;
                    controller.postSingleViewModel.value!.post!.numberOfLikes = (controller.postSingleViewModel.value!.post!.numberOfLikes! +1);                    controller.postSingleViewModel.value!.post!.alreadyLiked=true;
                  }
                  controller.postSingleViewModel.refresh();
                    await ApiRepository.likeVlogBlogPost(userId: "${controller.postSingleViewModel.value?.post?.id}", postType:PostType.post);
                    // controller.getBlogById(id: widget.id,isLoadingg: false);
                },
                child: Obx(
                      ()=> CustomImageView(
                    imagePath: controller.postSingleViewModel.value?.post?.alreadyLiked?? false
                        ? 'assets/image/love_true_blue.svg'
                        : 'assets/image/love_false_blue.svg',
                    width: 21.aw,
                    height: 21.aw,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              if(controller.postSingleViewModel.value?.post?.commentAllowed ?? true)
                InkWell(
                  onTap: () {
                    VlogBottomSheets.commentsBottomSheet(
                      context: context,
                      id: "${widget.id}",
                      postType: PostType.post,
                    );
                  },
                  child: CustomImageView(
                    imagePath: 'assets/image/comments_blue.png',
                    width: 21.aw,
                    height: 21.aw,
                  ),
                ),

              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  VlogBottomSheets.shareBottomSheet(
                    context: context,
                    id: "${widget.id}",
                    postType: PostType.post,
                    userName: controller.postSingleViewModel.value?.post?.user?.handle ?? '',
                    isUrl: controller.postSingleViewModel.value?.post?.imageUrl ?? '',
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
                final alreadySaved = controller.postSingleViewModel.value?.post?.alreadySaved ?? false;
                return InkWell(
                  onTap: () async {
                    if (alreadySaved) {
                      await ApiRepository.saveAllById(
                        postType: PostType.post,
                        id: "${controller.postSingleViewModel.value?.post?.id}",
                        categoryId: "0",
                      );
                    } else {
                      await VlogBottomSheets.saveBottomSheet(
                        context: context,
                        id: "${widget.id}",
                        postType: PostType.post,
                      );
                    }
                    controller.getPostByid(id: "${widget.id}",isLoading: false);
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
          if(controller.postSingleViewModel.value?.post?.numberOfLikes != 0)
            Obx(
                  ()=> Row(
                    mainAxisSize: MainAxisSize.min,  // To prevent the Row from taking up more space than necessary
                    children: [
                      Text(
                        '${controller.postSingleViewModel.value?.post?.numberOfLikes}',  // Likes count
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.fSize,
                        ),
                      ),
                      SizedBox(width: 4),  // Adds space between the number of likes and the word "likes"
                      Text(
                        controller.postSingleViewModel.value?.post?.numberOfLikes == 1 ? '_like'.tr : '_likes'.tr,  // The text "likes"
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.fSize,
                        ),
                      ),
                    ],
                  ),

            ),
        ],
      ),
    );
  }

  Widget buildVlogDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.aw),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(
                //       ()=> controller.postSingleViewModel.value?.post?.tags != null ?
                //   tags() : SizedBox(),
                // ),
                Obx(() {
                  final views = "${controller.postSingleViewModel.value?.post?.caption}" ?? "0";
                  // return Text(
                  //   views.capitalizeFirst!,

                  // );
                  return HighlightHashtags(text: views,);
                }),
                SizedBox(height: 5,),
                Obx(() {
                  final createdAt = controller.postSingleViewModel.value?.post?.createdAt?.toString() ?? "";
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
      ),
    );
  }
}

// class HighlightHashtags extends StatelessWidget {
//    String text ;
//    HighlightHashtags({Key? key,required this.text}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return RichText(
//       text: buildHighlightedText(text),
//       textAlign: TextAlign.left,
//     );
//   }
//
//   /// Function to build highlighted text
//   TextSpan buildHighlightedText(String text) {
//     final words = text.split(' ');
//     final List<InlineSpan> spans = words.map((word) {
//       if (word.startsWith('#')) {
//         // Highlight words starting with '#'
//         return TextSpan(
//           text: '$word ',
//           style:  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,
//             fontSize: 16.fSize,
//             letterSpacing: 0.0,
//
//           ),
//         );
//       } else {
//         // Regular text
//         return TextSpan(
//           text: '$word ',
//           style: TextStyle(
//             color: MyColor.primaryColor,
//             fontWeight: FontWeight.w500,
//             fontSize: 16.fSize,
//             letterSpacing: 0.0,
//           ),
//         );
//       }
//     }).toList();
//
//     return TextSpan(children: spans);
//   }
// }

class HighlightHashtags extends StatelessWidget {
  final String text;

  HighlightHashtags({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: buildHighlightedText(text, context),
      textAlign: TextAlign.left,

    );
  }

  /// Function to build highlighted text with tap functionality
  TextSpan buildHighlightedText(String text, BuildContext context) {
    final words = text.split(' ');
    final List<InlineSpan> spans = words.map((word) {
      if (word.startsWith('#')) {
        // Highlight words starting with '#' and add tap gesture
        return TextSpan(
          text: '$word ',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            letterSpacing: 0.0,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
            print("object#$word");
            Get.to(()=>SearchScreen(hastag:word.substring(1),postType: PostType.post,));
              // Navigate to another screen on tap
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => DetailScreen(hashtag: word),
              //   ),
              // );
            },
        );
      } else {
        // Regular text
        return TextSpan(
          text: '$word '.capitalizeFirst,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            letterSpacing: 0.0,
          ),
        );
      }
    }).toList();

    return TextSpan(children: spans);
  }

}

