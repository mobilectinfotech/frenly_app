import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/bottom_sheet_widgets.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/search/search_page.dart';
import 'package:get/get.dart';
import '../../Widgets/custom_image_view.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import '../auth/my_profile_view/my_profile_controller.dart';
import '../user_profile_screen/user_profile_screen.dart';
import 'PostLikeCommentsShareView.dart';
import 'photo_list/post_view_all_contorller.dart';

class PostFullViewScreen extends StatefulWidget {
  final bool  ? own ;
  final String ? loadPostByid ;
  const PostFullViewScreen({super.key ,this.own,this.loadPostByid});

  @override
  State<PostFullViewScreen> createState() => _PostFullViewScreenState();
}

class _PostFullViewScreenState extends State<PostFullViewScreen> {



  PostAllViewController controller = Get.put(PostAllViewController());

  void deleteFun(
      BuildContext context,
      ) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text('delete_post'.tr,
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
                            child: Text('cancel'.tr,
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
                          await ApiRepository.deletePost(postId: "${controller.postSingleViewModel?.post?.id}");
                          if(Get.isRegistered<MyProfileController>()) {
                            Get.find<MyProfileController>().getProfile(); //asdfg
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
                            child: Text('Delete'.tr,
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
    // TODO: implement initState
    super.initState();
    if(widget.loadPostByid !=null) {
      controller.getPostByid(id: widget.loadPostByid!);
    }
  }

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       appBar: AppBar(),
       body:   Obx(
        ()=> controller.isLoadingPostsingle.value ? Center(child: CircularProgressIndicator(strokeWidth: 1,),) : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.all(8.0.adaptSize),
              child: InkWell(
                onTap: () {
                  if(widget.own ==true){
                  }else{
                    Get.to(()=> UserProfileScreen(userId: "${controller.postSingleViewModel?.post?.user?.id}"));
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImageView(
                      height: 50.ah,
                      width: 50.ah,
                      imagePath: controller.postSingleViewModel?.post?.user?.avatarUrl,
                      radius: BorderRadius.circular(60.ah),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10.aw),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${controller.postSingleViewModel?.post?.user?.fullName}".capitalizeFirst!,
                          style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w700,fontSize:20.fSize,
                          ),),
                        Text("${controller.postSingleViewModel?.post?.user?.handle}",
                          style: TextStyle(
                            color: Colors.grey,fontWeight: FontWeight.w500,fontSize:14.fSize,
                          ),),
                      ]
                    ),
                    Spacer(),
                    widget.own ==true ? InkWell(
                        onTap: () async{
                          deleteFun(context);
                        // await   ApiRepository.deletePost(postId: "${postSingleViewModel?.post?.id}");
                        // Get.back();
                        // if(Get.isRegistered<MyProfileController>()) {
                        //   Get.find<MyProfileController>().getProfile(); //asdfg
                        // }
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          size: 30,
                        )) : SizedBox(),
                          SizedBox(width: 10.aw),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.ah),
            Stack(
              children: [
                CustomImageView(
                  width: MediaQuery.of(context).size.width,
                  imagePath:controller.postSingleViewModel?.post?.imageUrl,
                  fit: BoxFit.cover,
                ),
                InkWell(
                  onTap: () {
                 //   Get.to(()=>PostFullViewScreen(post: widget.post!));
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width,

                            decoration: BoxDecoration(
                              //color: Colors.red,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.black.withOpacity(0.25),
                                 spreadRadius: -1,
                                 blurRadius: 2,
                                 offset: Offset(0, 2),
                               ),
                             ]
                            ),
                            child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
                              child: HashtagText(caption:"${controller.postSingleViewModel?.post?.caption}" ),
                            ),
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.only(left: 15,right: 15),
                          //   child: Text("${controller.postSingleViewModel?.post?.caption}".capitalizeFirst!,overflow: TextOverflow.ellipsis,
                          //     style: TextStyle(fontSize: 16.adaptSize ,
                          //         fontWeight: FontWeight.w400,color: Colors.white),),
                          // ),
                        ],
                      )

                  ),
                ),
              ],
            ),
             SizedBox(height: 40.ah),

            PostLikeCommentsShareView(post: controller.postSingleViewModel?.post,),
          ],
        ),
      )
    );
  }

}
class HashtagText extends StatelessWidget {
  final String caption;

  HashtagText({required this.caption});

  @override
  Widget build(BuildContext context) {
    // Regular expression to match hashtags
    final RegExp hashtagRegExp = RegExp(r"(#[a-zA-Z0-9_]+)");

    // Splitting the text into parts to handle each word
    List<TextSpan> spans = [];
    caption.splitMapJoin(
      hashtagRegExp,
      onMatch: (Match match) {
        // On matching a hashtag, create a green TextSpan with a GestureRecognizer
        spans.add(
          TextSpan(
            text: match.group(0),
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.adaptSize ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
              Get.to(()=>SearchScreen(postType: PostType.post,hastag: "${match.group(0)}",));
                // Action on hashtag click
                print('Clicked on ${match.group(0)}');
              },
          ),
        );
        return '';
      },
      onNonMatch: (String nonMatch) {
        // For non-hashtag parts, create a regular TextSpan
        spans.add(TextSpan(text: nonMatch));
        return '';
      },
    );

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(fontSize: 16.adaptSize ,
            fontWeight: FontWeight.w400,color: Colors.white), // Default text color
      ),
    );
  }
}

