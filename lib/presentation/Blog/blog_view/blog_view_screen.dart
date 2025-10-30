// // ignore_for_file: unused_import
//
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
// import 'package:frenly_app/Widgets/bottom_sheet_widgets.dart';
// import 'package:frenly_app/Widgets/custom_appbar.dart';
// import 'package:frenly_app/Widgets/custom_image_view.dart';
// import 'package:frenly_app/core/utils/size_utils.dart';
// import 'package:frenly_app/presentation/Blog/blog_edit/blogs_edit_screen.dart';
// import 'package:frenly_app/presentation/search/search_page.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:get/get.dart';
//
// import '../../../Widgets/custom_textfield.dart';
// import '../../../data/models/blog_model.dart';
// import 'package:frenly_app/data/repositories/api_repository.dart';
// import '../../Vlog/blog_like_commnet_share_common_view.dart';
// import '../../Vlog/vlog_like_commnet_share_common_view.dart';
// import '../../auth/my_profile_view/my_profile_controller.dart';
// import '../../user_profile_screen/user_profile_screen.dart';
// import '../blogListModel.dart';
// import 'blog_view_controller.dart';
//
// class BlogsFullViewScreen extends StatefulWidget {
//   final String id;
//   final bool ? isOwn;
//   const BlogsFullViewScreen({super.key, required this.id ,this.isOwn});
//
//   @override
//   State<BlogsFullViewScreen> createState() => _BlogsFullViewScreenState();
// }
//
// class _BlogsFullViewScreenState extends State<BlogsFullViewScreen> {
//
//   BlogFullViewController controller =Get.put(BlogFullViewController());
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller.getBlogById(id: widget.id);
//   }
//
//
//   void deleteFun(
//       BuildContext context,
//       ) async {
//     await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               title: Text('delete_post'.tr,
//                 style: TextStyle(
//                   color: const Color(0XFF111111),
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18.adaptSize,
//                   fontFamily: 'Roboto',
//                 ),
//               ),
//               actions: <Widget>[
//                 Center(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: Container(
//                           height: 44.adaptSize,
//                           width: 110.adaptSize,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color:Color(0xff001649),width: 1.aw)),
//                           child: Center(
//                             child: Text(
//                               'cancel'.tr,
//                               style: TextStyle(
//                                 color: const Color(0XFF001649),
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15.adaptSize,
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 15.aw),
//                       InkWell(
//                         onTap: () async{
//                           Get.back();
//                           Get.back();
//                           await  ApiRepository.deleteBlog(blogId: "${controller.blogByIdModel.blog?.id}");
//                           if(Get.isRegistered<MyProfileController>()) {
//                             Get.find<MyProfileController>().getProfile(); //done
//                           }
//                           // await   ApiRepository.deletePost(postId: "${postSingleViewModel?.post?.id}");
//                           // Get.back();
//                           // Get.back();
//                           // if(Get.isRegistered<MyProfileController>()) {
//                           //   Get.find<MyProfileController>().getProfile(); //asdfg
//                           // }
//                         },
//                         child: Container(
//                           height: 44.adaptSize,
//                           width: 110.adaptSize,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: const Color(0xff001649),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Delete'.tr,
//                               style: TextStyle(
//                                 color: const Color(0XFFFFFFFF),
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15.adaptSize,
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]);
//         });
//   }
//
//   TextEditingController reasonController = TextEditingController();
//
//   void reportFun(
//       BuildContext context,
//       ) async {
//     await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               title: Text(
//                   'report_blog_reason'.tr,
//                 style: TextStyle(
//                   color: const Color(0XFF111111),
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18.adaptSize,
//                   fontFamily: 'Roboto',
//                 ),
//               ),
//               actions: <Widget>[
//                 SizedBox(
//                   width: 300,
//                   child: CustomTextFormField(
//                     context: context,
//                     maxLines: 4,
//                     controller: reasonController,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: Container(
//                           height: 44.adaptSize,
//                           width: 110.adaptSize,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                   color: Color(0xff001649), width: 1.aw)),
//                           child: Center(
//                             child: Text(
//                               'cancel'.tr,
//                               style: TextStyle(
//                                 color: const Color(0XFF001649),
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15.adaptSize,
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 30.aw),
//                       InkWell(
//                         onTap: () async {
//                           if(reasonController.text.trim().isEmpty || reasonController.text == "" ){
//                             Get.snackbar("", "please_enter_report_reason".tr, backgroundColor: Color(0xff001649),colorText: Colors.white);
//
//                           }else{
//                             bool isreport =  await ApiRepository.reportPost(postId: widget.id, reason: reasonController.text, postType: "blog");
//                             if(isreport){
//                               reasonController.clear();
//                               Get.back();
//                             }
//                           }
//
//                           // Get.back();
//
//                           // if(Get.isRegistered<MyProfileController>()) {
//                           //   Get.find<MyProfileController>().getProfile(); //asdfg
//                           // }
//                         },
//                         child: Container(
//                           height: 44.adaptSize,
//                           width: 110.adaptSize,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: const Color(0xff001649),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Report'.tr,
//                               style: TextStyle(
//                                 color: const Color(0XFFFFFFFF),
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15.adaptSize,
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]);
//         });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           appBar: AppBar(),
//           body:  Obx(()=> controller.isLoading.value ? Center(child: CircularProgressIndicator(strokeWidth: 1,)) : Padding(
//             padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
//             child: ListView(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Get.to(()=> UserProfileScreen(userId: "${controller.blogByIdModel.blog?.user?.id}"));
//                   },
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       CustomImageView(
//                         height: 50.ah,
//                         width: 50.ah,
//                         imagePath: controller.blogByIdModel.blog?.user?.avatarUrl,
//                         radius: BorderRadius.circular(60.ah),
//                         fit: BoxFit.cover,
//                       ),
//                       SizedBox(width: 10.aw),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("${controller.blogByIdModel.blog?.user?.fullName}".capitalizeFirst!,
//                             style: TextStyle(
//                               color: Colors.black,fontWeight: FontWeight.w700,fontSize:20.fSize,
//                             ),),
//                           Text("${controller.blogByIdModel.blog?.user?.handle}",
//                             style: TextStyle(
//                               color: Colors.grey,fontWeight: FontWeight.w500,fontSize:14.fSize,
//                             ),),
//                         ],
//                       ),
//                       const Spacer(),
//                       widget.isOwn ==true ? InkWell(
//                         onTap: () {
//                           // This is left empty as the PopupMenuButton handles the tap
//                         },
//                         child: PopupMenuButton<String>(
//                           icon: const Icon(
//                             Icons.more_vert_outlined,
//                             size: 30,
//                           ),
//                           onSelected: (String result) async{
//                             // Handle the selection from the menu
//                             print(result);
//                             if(result=="1"){
//                               Get.to(()=> BlogsEditScreen(getBlogByIdModel: controller.blogByIdModel,));
//
//                             }
//                             if(result=="2"){
//                               // Get.back();
//                               deleteFun(context);
//                             }
//
//                           },
//                           itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                              PopupMenuItem<String>(
//                               value: '1',
//                               child: Text('edit_blog'.tr),
//                             ),
//                              PopupMenuItem<String>(
//                               value: '2',
//                               child: Text('Delete'.tr),
//                             ),
//                           ],
//                         ),
//                       ) : InkWell(
//                         onTap: () {
//                           reportFun(context);
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.only(bottom: 4.0),
//                           child: Icon(Icons.report),
//                         ),
//                       ),
//                       SizedBox(width: 10.aw),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 Center(
//                   child: CustomImageView(
//                     height: 185.ah,
//                     width: 351.aw,
//                     imagePath: controller.blogByIdModel.blog?.imageUrl,
//                     radius: BorderRadius.circular(25),
//                     fit: BoxFit.cover,
//                   ),
//                  ),
//                 SizedBox(height: 20.ah),
//                 tags(),
//                 SizedBox(height: 20.ah),
//                 Text(
//                   "${controller.blogByIdModel.blog?.title!.capitalizeFirst}".tr,
//                   style:  TextStyle(
//                       color: const Color(0xFF000000),
//                       fontSize: 18.adaptSize,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w700,
//                       height: 1.2),
//                ),
//                 SizedBox(height: 20.ah),
//                 Text(
//                   "${controller.blogByIdModel.blog?.body!.capitalizeFirst}".tr,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16.adaptSize,
//                     fontFamily: 'Roboto',
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 20.ah),
//                 SizedBox(height: 50.ah),
//               ],
//             ),
//           )),
//
//
//           bottomNavigationBar: Obx(()=> controller.isLoading.value ? Center(child: CircularProgressIndicator(strokeWidth: 1,)) :
//           BottomAppBar(
//             color: HexColor('#001649'),
//             height: 108.ah,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 25.0,right: 25),
//               child: SizedBox(
//                   child: Column(
//                     children: [
//                       BlogLikeCommentsShareView(blog: controller.blogByIdModel.blog!,),
//                     ],
//                   )),
//             ),
//           )));
//   }
//
//   Widget tags(){
//     String jsonString = "${controller.blogByIdModel.blog?.tags}";
//     List<String> tagsList = json.decode(jsonString).cast<String>();
//     return    Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         for (int i = 0;
//         i < (tagsList.length);
//         i++)
//           InkWell(
//             onTap: () {
//               print("object$i");
//               Get.to(()=>SearchScreen(hastag:tagsList[i],postType: PostType.blog,));
//             },
//             child: Padding(
//               padding: EdgeInsets.only(left: 5.0.aw),
//               child: Container(
//                 // width: 60,
//                 height: 20,
//                 decoration: ShapeDecoration(
//                   color: const Color(0xFFEEEEEE),
//                   shape: RoundedRectangleBorder(
//                     side:const BorderSide(width: 0.30),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                 ),
//                 child: Center(
//                   child: Opacity(
//                     opacity: .50,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 5.0, right: 5),
//                       child: Text(
//                         tagsList[i].tr,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w500,
//                           height: 0.08,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
//




// ignore_for_file: unused_import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../Widgets/VideoPlayerWidget.dart';
import '../../../Widgets/bottom_sheet_widgets.dart';
import '../../../Widgets/custom_image_view.dart';
import '../../../Widgets/custom_textfield.dart';
import '../../../Widgets/custom_user_card.dart';
import '../../../Widgets/custom_vlog_card.dart';
import '../../../core/constants/my_colour.dart';
import '../../../core/constants/textfield_validation.dart';
import '../../../core/utils/calculateTimeDifference.dart';
import '../../../core/utils/pref_utils.dart';
import '../../../data/models/cateogry_model.dart';
import '../../../data/models/vlog_model.dart';
import '../../../data/repositories/api_repository.dart';
import '../../Vlog/add_new_category/add_new_cateogry_bottom_sheet.dart';
import '../../Vlog/edit_vlog/edit_vlog.dart';
import '../../Vlog/vlog_full_view/vlog_view_controller.dart';
import '../../Vlog/vlog_full_view/vlog_view_screen.dart';
import '../../Vlog/vlog_like_commnet_share_common_view.dart';
import '../../auth/my_profile_view/my_profile_controller.dart';
import '../../chat/Pages/all_frined/CreateChatModel.dart';
import '../../dashboard_screen/dashboardcontroller.dart';
import '../../search/search_page.dart';
import '../../user_profile_screen/user_profile_screen.dart';


class BlogViewScreen extends StatefulWidget {
  final bool ? isOwn;
  final String id;
  BlogViewScreen({Key? key, required this.id,  this.isOwn}) : super(key: key);

  @override
  State<BlogViewScreen> createState() => _BlogViewScreenState();
}

class _BlogViewScreenState extends State<BlogViewScreen> {

  final VlogFullViewController controller = Get.put(VlogFullViewController());

  @override
  void initState() {
    super.initState();
         controller.getBlogById(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blog".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
          ()=> controller.isLoadingBolg.value ? Center(child: CircularProgressIndicator()) : ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 15.ah),
            buildUserInfoRow(),
            Padding(
              padding:  EdgeInsets.all(20.0.aw),
              child: Obx(()=> InstaImageViewer(
                  child: CustomImageView(
                    radius: BorderRadius.circular(20),
                    imagePath: controller.blogByIdModel.value?.blog?.imageUrl,
                  ),
                ),
              ),
            ),
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
            final user = controller.blogByIdModel.value?.blog?.user;
            Get.to(() => UserProfileScreen(userId: "${user?.id}"));
          },
          child: Row(
            children: [
              Obx(() {
                final user = controller.blogByIdModel.value?.blog?.user;
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
                final handle = controller.blogByIdModel.value?.blog?.user?.handle ?? "";
                return Text( handle,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.90),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.fSize,
                  ),
                );
              }),
            ],
          ),
        ),

        const Spacer(),
        InkWell(
          onTap: () {
            VlogBottomSheets.vlogmenuBottomSheet(
                context: context,
                id: widget.id,
                postType: PostType.blog,
                userHandle: controller.blogByIdModel.value?.blog?.user?.handle ?? '',
                isUrl: controller.blogByIdModel.value?.blog?.imageUrl ?? '',
                userId: "${controller.blogByIdModel.value?.blog?.user?.id}"
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
                  if(controller.blogByIdModel.value!.blog!.alreadyLiked){
                    controller.blogByIdModel.value!.blog!.numberOfLikes = (controller.blogByIdModel.value!.blog!.numberOfLikes! -1);                    controller.blogByIdModel.value!.blog!.alreadyLiked=true;
                    controller.blogByIdModel.value!.blog!.alreadyLiked=false;
                  }else{
                    controller.blogByIdModel.value!.blog!.alreadyLiked=true;
                    controller.blogByIdModel.value!.blog!.numberOfLikes = (controller.blogByIdModel.value!.blog!.numberOfLikes! +1);                    controller.blogByIdModel.value!.blog!.alreadyLiked=true;
                  }
                  controller.blogByIdModel.refresh();
                //  await ApiRepository.likeVlogBlogPost(userId: "${controller.blogByIdModel.value?.blog?.id}", postType:PostType.blog);
                //  controller.getBlogById(id: widget.id,isLoadingg: false);
                },
                child: Obx(
                      ()=> CustomImageView(
                    imagePath: controller.blogByIdModel.value?.blog?.alreadyLiked?? false
                        ? 'assets/image/love_true_blue.svg'
                        : 'assets/image/love_false_blue.svg',
                    width: 21.aw,
                    height: 21.aw,
                  ),
                ),
              ),
              const SizedBox(width: 20),
               if(controller.blogByIdModel.value?.blog?.commentAllowed ?? true)
                InkWell(
                  onTap: () {
                    VlogBottomSheets.commentsBottomSheet(
                      context: context,
                      id: widget.id,
                      postType: PostType.blog,
                    );
                  },
                  child: CustomImageView(
                    imagePath: 'assets/image/comments_blue.png',
                    width: 21.aw, height: 21.aw,
                  ),
                ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  VlogBottomSheets.shareBottomSheet(
                    context: context,
                    id: widget.id,
                    postType: PostType.blog,
                    userName: controller.blogByIdModel.value?.blog?.user?.handle ?? '',
                    isUrl: controller.blogByIdModel.value?.blog?.imageUrl ?? '',
                  );
                },
                child: CustomImageView(
                  imagePath: 'assets/image/Vector (1).png',
                  color: MyColor.primaryColor,
                  height: 21.aw
                ),
              ),
              const Spacer(),
              Obx(() {
                final alreadySaved = controller.blogByIdModel.value?.blog?.alreadySaved ?? false;
                return InkWell(
                  onTap: () async {
                    if (alreadySaved) {
                      await ApiRepository.saveAllById(
                        postType: PostType.blog,
                        id: "${controller.blogByIdModel.value?.blog?.id}",
                        categoryId: "0",
                      );
                    } else {
                     await VlogBottomSheets.saveBottomSheet(
                        context: context,
                        id: widget.id,
                        postType: PostType.blog,
                      );
                    }
                    controller.getBlogById(id: widget.id,isLoading: false);
                  },
                  child: CustomImageView(
                    imagePath: alreadySaved
                        ? 'assets/image/save_true_blue.svg'
                        : 'assets/image/save_false_blue.svg',
                    width: 21.aw, height: 21.aw,
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: 5.ah,),
          if(controller.blogByIdModel.value?.blog?.numberOfLikes != 0)
          Obx(
          ()=> Text('${controller.blogByIdModel.value?.blog?.numberOfLikes} likes',
              style: TextStyle( color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 11.fSize,
              ),
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
                Obx( ()=> controller.blogByIdModel.value?.blog?.tags != null ?
                  tags() : SizedBox(),
                ),
                Obx(() {
                  final views = controller.blogByIdModel.value?.blog?.title ?? "0";
                  return Text("$views".capitalizeFirst!,
                    style: TextStyle(
                      color: MyColor.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.fSize,
                        letterSpacing: 0.0
                    ),
                  );
                }),
                SizedBox(height: 5,),
                Obx(() {
                  final handle = controller.blogByIdModel.value?.blog?.user?.handle ?? "";
                  final body = controller.blogByIdModel.value?.blog?.body ?? "";
                  return Text("$body",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.60),
                      fontWeight: FontWeight.w500,
                      fontSize: 14.fSize
                    ),
                  );
                }),
                SizedBox(height: 5,),
                Obx(() {
                  final createdAt = controller.blogByIdModel.value?.blog?.createdAt?.toString() ?? "";
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

  Widget tags(){
    String jsonString = "${controller.blogByIdModel.value?.blog?.tags}";
    List<String> tagsList =controller.blogByIdModel.value?.blog?.tags  == null ? [] : json.decode(jsonString).cast<String>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 0;
        i < (tagsList.length);
        i++)
          InkWell(
            onTap: () {
              print("object$i");
              Get.to(()=>SearchScreen(hastag:tagsList[i],postType: PostType.blog,));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.0.aw),
              child: Center(
                child: Text( "#${tagsList[i]}",
                  style: TextStyle(
                    color: MyColor.primaryColor,
                    fontSize: 16, fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}



