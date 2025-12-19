import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/core/constants/textfield_validation.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/dashboard_screen/dashboardcontroller.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/calculateTimeDifference.dart';
import '../core/utils/pref_utils.dart';
import '../data/models/GetCommentsModel.dart';
import '../data/models/cateogry_model.dart';
import '../data/repositories/api_repository.dart';
import '../presentation/Blog/blog_view/blog_view_controller.dart';
import '../presentation/Vlog/add_new_category/add_new_cateogry_bottom_sheet.dart';
import '../presentation/chat/Pages/all_frined/AllFriendsModel.dart';
import '../presentation/chat/Pages/all_frined/CreateChatModel.dart';
import 'custom_image_view.dart';

enum PostType {
  vlog,
  post,
  blog,
}

class CustomBottomSheets {
  ///comments boottom sheet pramod code
/*  static Future<void> commentsBottomSheet(
      {required BuildContext context,
      required String id,
      required PostType postType}) async {
    ComnetsController commentsController = Get.put(ComnetsController());
    commentsController.getComments(id: id, postType: postType);

    await showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .55,
              child: GestureDetector(
                onTap: () {
                  // Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.aw, right: 20.aw),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.ah,
                        ),
                        Center(
                          child: Text(
                            'comments'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.98,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.ah),
                        Obx(
                          () => commentsController.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ),
                                )
                              : Expanded(
                                  child:
                                      commentsController.getCommentsModel.value.comments?.length ==
                                              0
                                          ? Center(
                                              child: Text(
                                                "no_comment".tr,
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          : ListView.builder(
                                              reverse: true,
                                              itemCount: commentsController
                                                  .getCommentsModel
                                                  .value.comments
                                                  ?.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10.0.ah),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomImageView(
                                                            width: 40.adaptSize,
                                                            height:
                                                                40.adaptSize,
                                                            imagePath:
                                                                commentsController
                                                                    .getCommentsModel
                                                                    .value.comments?[
                                                                        index]
                                                                    .user
                                                                    ?.avatarUrl,
                                                            fit: BoxFit.cover,
                                                            radius: BorderRadius
                                                                .circular(45
                                                                    .adaptSize),
                                                            onTap: () {
                                                              Get.back();
                                                              Get.to(() =>
                                                                  UserProfileScreen(
                                                                      userId: "${commentsController.getCommentsModel.value.comments?[index].user?.id}"));
                                                            },
                                                          ),
                                                          SizedBox(
                                                            width: 18.aw,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "${commentsController.getCommentsModel.value.comments?[index].user?.fullName}  ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14.adaptSize,
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    calculateTimeDifference(
                                                                        "${commentsController.getCommentsModel.value.comments?[index].createdAt}"),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .50),
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        230.aw,
                                                                    child: Text(
                                                                      "${commentsController.getCommentsModel.value.comments?[index].content}",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(.50),
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        20.aw,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Obx(
                                                                        () => InkWell(
                                                                            onTap: () async {
                                                                            //  Get.snackbar("title", "${commentsController.getCommentsModel.comments?[index].id}");
                                                                            //  print("object_sdfdsfdfdsf");
                                                                              Get.snackbar("", '',backgroundColor:  const Color(0xFF001649),colorText: Colors.white,titleText:const Text("Please write something",style: TextStyle(color: Colors.white),));
                                                                              commentsController.getCommentsModel.value.comments?[index].isLikedByMe.value = !commentsController.getCommentsModel.value.comments![index].isLikedByMe.value;
                                                                              if (commentsController.getCommentsModel.value.comments?[index].isLikedByMe.value == true) {
                                                                                commentsController.getCommentsModel.value.comments?[index].numberOfLikes.value = (commentsController.getCommentsModel.value.comments?[index].numberOfLikes.value ?? 1) + 1;
                                                                              } else {
                                                                                commentsController.getCommentsModel.value.comments?[index].numberOfLikes.value = (commentsController.getCommentsModel.value.comments?[index].numberOfLikes.value ?? 1) - 1;
                                                                              }

                                                                              // setState(() {});
                                                                              // widget.blog.alreadyLiked = false;
                                                                              // widget.blog.numberOfLikes =
                                                                              //     widget.blog.numberOfLikes! - 1;
                                                                              // setState(() {});
                                                                              bool isLiked = await ApiRepository.commnetLikeONvlog(volgId: "${commentsController.getCommentsModel.value.comments?[index].id}",postType: postType);
                                                                            },
                                                                            child: CustomImageView(
                                                                              imagePath: commentsController.getCommentsModel.value.comments?[index].isLikedByMe.value == true ? "assets/image/love_true_blue.svg" : 'assets/image/love_false_blue.svg',
                                                                              width: 21.aw,
                                                                              height: 21.aw,
                                                                            )),
                                                                      ),
                                                                      Obx(() {
                                                                        return Text(
                                                                          "${commentsController.getCommentsModel.value.comments?[index].numberOfLikes.value == 0 ? "" : commentsController.getCommentsModel.value.comments?[index].numberOfLikes}",
                                                                        );
                                                                      }),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              if ("${commentsController.getCommentsModel.value.comments?[index].user?.id}" == PrefUtils().getUserId())
                                                                InkWell(
                                                                  onTap: () async {
                                                                    commentsController.deleteComments(id: id, postType: postType, commentId: "${commentsController.getCommentsModel.value.comments?[index].id}");
                                                                  },
                                                                  child: Text(
                                                                    "Delete".tr,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12.adaptSize,
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                ),
                        ),
                        SizedBox(
                          height: 10.v,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              Form(
                                key: commentsController.formKey,
                                child: SizedBox(
                                  width: 290.aw,
                                  child: TextFormField(
                                    maxLines: null,  // Allows unlimited lines; use a fixed number like 5 if you want a limit
                                    minLines: 1,     // Starts with 1 line, expands as needed
                                    expands: false,  // Set to true if you want it to fill available height (but false is better for comments)

                                    // Keyboard type for multiline (allows Enter to add new lines)
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 15),
                                        disabledBorder: InputBorder.none,
                                        hintText: "add_comment".tr
                                    ),
                                    onTap: () {},
                                    validator: Validator.pleaseWriteSomething,
                                    onEditingComplete: () {
                                      if(commentsController.formKey.currentState!.validate()){
                                        FocusScope.of(context).unfocus();
                                        commentsController.postComments(
                                            id: id,
                                            postType: postType,
                                            comment: commentsController.commnetsTc.text.trim());
                                      }
                                    },
                                    controller: commentsController.commnetsTc,
                                    textInputAction: TextInputAction.send,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.v,
                              ),
                              InkWell(
                                onTap: () {
                                  if(commentsController.formKey.currentState!.validate()){
                                    FocusScope.of(context).unfocus();
                                    commentsController.postComments(
                                        id: id,
                                        postType: postType,
                                        comment: commentsController.commnetsTc.text.trim());
                                  }
                                },
                                child: Text(
                                  'Postt'.tr,
                                  style: TextStyle(
                                    color: Color(0xFF001649),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
              ));
        });
    print("pramod");
    Get.find<DashBoardController>().bottomBarShow.value = true;
  }*/
  static Future<void> commentsBottomSheet({
    required BuildContext context,
    required String id,
    required PostType postType,
  })
  async {

    final ComnetsController commentsController =
    Get.isRegistered<ComnetsController>()
        ? Get.find<ComnetsController>()
        : Get.put(ComnetsController());

    commentsController.getComments(id: id, postType: postType);

    await Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: .55,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(left: 20.aw, right: 20.aw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 20.ah),

                Center(
                  child: Text(
                    'comments'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.98,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                SizedBox(height: 20.ah),

                Obx(() {
                  if (commentsController.isLoading.value) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ),
                    );
                  }

                  final comments =
                      commentsController.getCommentsModel.value.comments ?? [];

                  if (comments.isEmpty) {
                    return const Expanded(
                      child: Center(child: Text("No comments")),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: comments.length,
                      itemBuilder: (_, index) {
                        final comment = comments[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.ah),
                          child: Text(comment.content ?? ""),
                        );
                      },
                    ),
                  );
                }),

                SizedBox(height: 10.v),

                /// COMMENT INPUT
                Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: commentsController.formKey,
                        child: TextFormField(
                          controller: commentsController.commnetsTc,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.send,
                          validator: Validator.pleaseWriteSomething,
                          decoration: InputDecoration(
                            hintText: "add_comment".tr,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onEditingComplete: () {
                            if (commentsController.formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              commentsController.postComments(
                                id: id,
                                postType: postType,
                                comment:
                                commentsController.commnetsTc.text.trim(),
                              );
                            }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    InkWell(
                      onTap: () {
                        if (commentsController.formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          commentsController.postComments(
                            id: id,
                            postType: postType,
                            comment:
                            commentsController.commnetsTc.text.trim(),
                          );
                        }
                      },
                      child: Text(
                        'Post'.tr,
                        style: const TextStyle(
                          color: Color(0xFF001649),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    /// CLEANUP (VERY IMPORTANT)
    Get.delete<ComnetsController>();

    Get.find<DashBoardController>().bottomBarShow.value = true;
  }


  static Future<void> shareBottomSheet({
    required BuildContext context,
    required String id,
    required PostType postType,
    required String userName,
    required String isUrl,
  }) async {
    ShareController controller = Get.find<ShareController>();
    await showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .55,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  // Container(
                  //   height: 8,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey,
                  //
                  //   ),
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                    child: Center(
                      child: Text(
                        'share'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.98,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  Obx(
                    () => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * .40,
                            child: controller.allFriendsModel.value.friends?.length == 0
                                ? Center(child: Text("no_friends_found".tr))
                                : ListView.builder(
                                    //  shrinkWrap: true,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.allFriendsModel.value.friends?.length ?? 0,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(10.0.adaptSize),
                                        child: InkWell(
                                         /*
                                         onTap: () async {
                                            Get.back();

                                            CreateChatModel createChatModel =
                                                await ApiRepository.createChat(
                                                    userId:
                                                        "${controller.allFriendsModel.friends?[index].id}");
                                            int indexxx =
                                                "${createChatModel.payload?.participants?[0].id}" ==
                                                        PrefUtils().getUserId()
                                                    ? 1
                                                    : 0;
                                            print("chatId $indexxx");
                                            // "send_a_vlog": "Send a Vlog of",
                                            // "send_a_blog": "Send a blog of",
                                            // "send_a_post": "Send a post of",


                                            var msg = ".";
                                            var post = "send_a_post".tr;
                                            var vlog = "send_a_vlog".tr;
                                            var blog = "send_a_blog".tr;
                                            if (postType.name == "post") {
                                              msg = "${post} $userName";
                                            }
                                            if (postType.name == "vlog") {
                                              msg = "${vlog} $userName";
                                            }
                                            if (postType.name == "blog") {
                                              msg = "${blog} $userName";
                                            }

                                            final response = await ApiRepository
                                                .sendMessageWithShare(
                                                    message: msg,
                                                    chatId: createChatModel
                                                        .payload!.id
                                                        .toString(),
                                                    postType: postType,
                                                    isUrl: isUrl,
                                                    isLinkId: id);
                                          },
                                          */

                                          onTap: () async {
                                            Get.back();
                                            CreateChatModel createChatModel = await ApiRepository.createChat(
                                              userId: "${controller.allFriendsModel.value.friends?[index].id}",
                                            );

                                            int indexxx = "${createChatModel.payload?.participants?[0].id}" == PrefUtils().getUserId() ? 1 : 0;

                                            // 🧠 Fetch translations at runtime, after language is already active
                                            String post = 'send_a_post'.tr;
                                            String vlog = 'send_a_vlog'.tr;
                                            String blog = 'send_a_blog'.tr;

                                            String msg = '';
                                            if (postType.name == "post") {
                                              msg = "$post $userName";
                                            } else if (postType.name == "vlog") {
                                              msg = "$vlog $userName";
                                            } else if (postType.name == "blog") {
                                              msg = "$blog $userName";
                                            }

                                            print('🗣️ Message Sent in Locale: ${Get.locale}');
                                            print('📝 Message: $msg');

                                            final response = await ApiRepository.sendMessageWithShare(
                                              message: msg,
                                              chatId: createChatModel.payload!.id.toString(),
                                              postType: postType,
                                              isUrl: isUrl,
                                              isLinkId: id,
                                            );
                                          },

                                          child: Row(
                                            children: [
                                              Container(
                                                height: 60.adaptSize,
                                                width: 60.adaptSize,
                                                child: CustomImageView(
                                                  height: 60.adaptSize,
                                                  width: 60.adaptSize,
                                                  imagePath: controller.allFriendsModel.value.friends?[index].avatarUrl,
                                                  fit: BoxFit.cover,
                                                  radius: BorderRadius.circular(45.adaptSize),
                                                ),
                                              ),

                                              SizedBox(width: 10),
                                              Text("${controller.allFriendsModel.value.friends?[index].fullName}")
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                  ),
                ]),
              ));
        });
    Get.find<DashBoardController>().bottomBarShow.value = true;
  }

  static Future<bool> saveBottomSheet({
    required BuildContext context,
    required String id,
    required PostType postType,
  }) async {
    SaveController controller;
    if (Get.isRegistered<SaveController>()) {
      controller = Get.find<SaveController>();
    } else {
      controller = Get.put(SaveController());
      print("MyController is not initialized.");
    }

    bool issave = false;
    RxBool apiLoading = false.obs;
    bool name = await showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          Get.find<DashBoardController>().bottomBarShow.value = true;
          return FractionallySizedBox(
              heightFactor: .55,
              child: GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                  // Get.back(t);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20.aw,
                    right: 20.aw,
                    top: 20.aw,
                  ),
                  width: double.infinity,
                  child: Obx(() {
                    if (apiLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView(
                      children: [
                        SizedBox(
                          height: 6.ah,
                        ),
                        SizedBox(
                          height: 24.ah,
                        ),
                        Row(
                          children: [
                            Text(
                              "save_post".tr,
                              style: GoogleFonts.roboto().copyWith(
                                  fontSize: 22.fSize,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                onTapAddNewCategory(context: context);
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.add),
                                  SizedBox(
                                    width: 5.aw,
                                  ),
                                  Text("NewCategoryy".tr)
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.ah,
                        ),
                        for (Category data
                            in (controller.cateogoryModel.value?.categories ??
                                []))
                          InkWell(
                            onTap: () async {
                              apiLoading.value = true;
                              issave = await ApiRepository.saveAllById(
                                  postType: postType,
                                  id: id,
                                  categoryId: "${data.id}");
                              print("Line544==$issave");
                              Get.back();
                              apiLoading.value = false;
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_box_outline_blank),
                                    SizedBox(
                                      width: 5.aw,
                                    ),
                                    Text(data.name ?? "")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 20.ah,
                        )
                      ],
                    );
                  }),
                ),
              ));
        }).closed.then((value) => issave);
    return name;
  }
}

class ComnetsController extends GetxController {
 // GetCommentsModel getCommentsModel = GetCommentsModel();
  Rx<GetCommentsModel> getCommentsModel = GetCommentsModel().obs;

  RxBool isLoading = false.obs;

  TextEditingController commnetsTc = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxInt numberOfCommnets = 0.obs;

  getComments({required String id, required PostType postType}) async {
    isLoading.value = true;
    getCommentsModel.value =
    await ApiRepository.getCommentsAll(id: id, postType: postType);
    numberOfCommnets.value = getCommentsModel.value.comments?.length ?? 2000;
    isLoading.value = false;
  }

  RxBool isLoadingPostCommnets = false.obs;

  postComments({
    required String id,
    required PostType postType,
    required String comment,
  }) async {
    isLoadingPostCommnets.value = true;
    final res =   await ApiRepository.postCommentAll(id: id, postType: postType, comment: comment);
  //  commnetsTc.clear();
    if (res.success == true && res.comment != null) {
      getCommentsModel.value.comments ??= [];
      getCommentsModel.value.comments!.insert(0, res.comment!);
      commnetsTc.clear();
      getCommentsModel.refresh();
    }

    if (postType.name == "blog") {
   //   Get.find<BlogViewController>().getBlogById(id: id,isLoadingg: false);
      if (Get.isRegistered<BlogViewController>()) {
        Get.find<BlogViewController>().getBlogById( id: id);
      }

    }
    if (postType.name == "post") {
      //Todo 001
   //   Get.find<PostAllViewController>().getPostByid(id: id,isLoading: false);
    }
    isLoadingPostCommnets.value = false;
    getComments(id: id, postType: postType);
  }

  RxBool isLoadingDeletCommnets = false.obs;

  deleteComments({
    required String id,
    required PostType postType,
    required String commentId,
  }) async {
    isLoadingPostCommnets.value = true;
    await ApiRepository.deleteCommentAll(
        id: id, postType: postType, commentId: commentId);
    isLoadingPostCommnets.value = false;
    getComments(id: id, postType: postType);
  }
}

// class ShareController extends GetxController {
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     getFriends();
//   }
//
//   RxBool isLoading = false.obs;
//   AllFriendsModel allFriendsModel = AllFriendsModel();
//
//   getFriends() async {
//     isLoading.value = true;
//     allFriendsModel = await ApiRepository.getFriends();
//     isLoading.value = false;
//   }
//
// //
// }

class ShareController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getFriends(); // initial load
  }

  RxBool isLoading = false.obs;

  Rx<AllFriendsModel> allFriendsModel = AllFriendsModel().obs;

  Future<void> getFriends({bool force = false}) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final data = await ApiRepository.getFriends();
      allFriendsModel.value = data;
    } catch (e) {
      debugPrint("ShareController error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}


class SaveController extends GetxController {
  Rxn<CategoryModel> cateogoryModel = Rxn();

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  var isloading = false.obs;

  void getCategory() {
    isloading.value = true;
    ApiRepository.getCategories().then((value) {
      cateogoryModel.value = value;
    });
    isloading.value = false;
  }
}


class PostCommentResponse {
  int? status;
  bool? success;
  String? message;
  Comment? comment;

  PostCommentResponse({
    this.status,
    this.success,
    this.message,
    this.comment,
  });

  factory PostCommentResponse.fromJson(Map<String, dynamic> json) {
    return PostCommentResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      comment: json['comment'] != null
          ? Comment.fromJson(json['comment'])
          : null,
    );
  }
}


