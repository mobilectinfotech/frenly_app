import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/dashboard_screen/dashboardcontroller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/my_colour.dart';
import '../core/utils/calculateTimeDifference.dart';
import '../core/utils/pref_utils.dart';
import '../data/data_sources/remote/api_client.dart';
import '../data/models/GetCommentsModel.dart';
import '../data/models/cateogry_model.dart';
import '../data/repositories/api_repository.dart';
import '../presentation/Vlog/add_new_category/add_new_cateogry_bottom_sheet.dart';
import '../presentation/chat/Pages/all_frined/AllFriendsModel.dart';
import '../presentation/chat/Pages/chats/chats_model.dart';
import 'custom_image_view.dart';
import 'package:intl/intl.dart';


enum PostType {
  vlog,
  post,
  blog,
}

class CustomBottomSheets {

  ///comments boottom sheet
  static Future<void> commentsBottomSheet(
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
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.aw, right: 20.aw),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.ah,
                        ),
                        const Center(
                          child: Text(
                            'Comments',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                                  child: CircularProgressIndicator(strokeWidth: 1,

                                  ),
                                )
                              : Expanded(
                                  child: commentsController.getCommentsModel
                                              .comments?.length ==
                                          0
                                      ? const Center(
                                          child: Text(
                                            "No comments yet",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      : ListView.builder(
                                          reverse: true,
                                          itemCount: commentsController
                                              .getCommentsModel
                                              .comments
                                              ?.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10.0.ah),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      CustomImageView(
                                                        width: 40.adaptSize,
                                                        height: 40.adaptSize,
                                                        imagePath:
                                                            commentsController
                                                                .getCommentsModel
                                                                .comments?[
                                                                    index]
                                                                .user
                                                                ?.avatarUrl,
                                                        fit: BoxFit.cover,
                                                        radius: BorderRadius
                                                            .circular(
                                                                45.adaptSize),
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
                                                                "${commentsController.getCommentsModel.comments?[index].user?.fullName}  ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14
                                                                      .adaptSize,
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              Text(
                                                                calculateTimeDifference(
                                                                    "${commentsController.getCommentsModel.comments?[index].createdAt}"),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .50),
                                                                  fontSize: 14,
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
                                                                width: 230.aw,
                                                                child: Text(
                                                                  "${commentsController.getCommentsModel.comments?[index].content}",
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
                                                              ),
                                                              if ("${commentsController.getCommentsModel.comments?[index].user?.id}" ==
                                                                  PrefUtils()
                                                                      .getUserId())
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    commentsController.deleteComments(
                                                                        id: id,
                                                                        postType:
                                                                            postType,
                                                                        commentId:
                                                                            "${commentsController.getCommentsModel.comments?[index].id}");
                                                                  },
                                                                  child: Text(
                                                                    "Delete",
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
                                                                ),
                                                            ],
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
                              SizedBox(
                                width: 290.aw,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15),
                                      disabledBorder: InputBorder.none,
                                      hintText: "Add a comment ..."),
                                  onTap: () {},
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    commentsController.postComments(
                                        id: id,
                                        postType: postType,
                                        comment:
                                            commentsController.commnetsTc.text);
                                  },
                                  controller: commentsController.commnetsTc,
                                  textInputAction: TextInputAction.send,
                                ),
                              ),
                              SizedBox(
                                width: 10.v,
                              ),
                              InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  commentsController.postComments(
                                      id: id,
                                      postType: postType,
                                      comment:
                                          commentsController.commnetsTc.text);
                                },
                                child: const Text(
                                  'Post',
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
  }

  static Future<void> shareBottomSheet(
      {required BuildContext context,
      required String id,
      required PostType postType,
      required String userName ,
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
                child: Padding(
                  padding: EdgeInsets.only(left: 0.0.aw, right: 0.aw,top: 40),
                  child: ListView(children: [
                    const Center(
                      child: Text(
                        'Share',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.98,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.ah),
                    Obx(
                      ()=> controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),) : Container(height: 90.adaptSize,
                        child: ListView.builder(
                          itemCount: controller.allFriendsModel.friends?.length ?? 0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                          return Padding(
                            padding:  EdgeInsets.all(10.0.adaptSize),
                            child: InkWell(
                              onTap: () {

                              },
                              child: Container(
                                height: 70.adaptSize,width: 70.adaptSize,
                                child:CustomImageView(
                                  height: 70.adaptSize,
                                  width: 70.adaptSize,
                                  imagePath: controller
                                      .allFriendsModel
                                      .friends?[index]
                                      .avatarUrl,
                                  fit: BoxFit.cover,
                                  radius: BorderRadius.circular(
                                      45.adaptSize),
                                ) ,
                              ),
                            ),
                          );
                        },),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Obx(()=> controller.isLoadingChatModel.value  ? Container(height: 100,width: 100,color: Colors.red,) :

                    controller.chatsModel.chats!.length == 0 ? Center(child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text("No chats found"),
                    ),) :
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.chatsModel.chats!.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: () async {
                            final response = await ApiRepository.sendMessageWithShare(
                                message: ' Sent a ${postType.name} by $userName',
                                chatId: '${controller.chatsModel.chats![index].id}',
                                postType: postType,
                                isUrl: isUrl,
                                isLinkId: id);
                            Get.back();
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 15.aw,),
                                  CustomImageView(
                                    radius: BorderRadius.circular(30),
                                    height: 55,
                                    width: 55,
                                    imagePath: controller.chatsModel.chats![index].participants?[index].avatarUrl,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 10.aw,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "${controller.chatsModel.chats![index].participants![index].fullName}".capitalizeFirst!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.aw,
                                        child: Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          controller.chatsModel.chats![index].lastMessage?.content ?? "",
                                          style: const TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(DateFormat('hh:mm a').format(controller.chatsModel.chats![index].lastMessage?.createdAt!.toLocal() ?? DateTime.now()),),
                                      const SizedBox(height: 8,),
                                      if(controller.chatsModel.chats![index].unreadCount != 0)Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: MyColor.primaryColor
                                            ),
                                            child: Center(child: Padding(
                                              padding: const EdgeInsets.only(top: 4.0,bottom: 4,left: 9,right: 9),
                                              child: Text("${controller.chatsModel.chats![index].unreadCount}" , style: TextStyle(fontSize: 12.adaptSize,color: Colors.white),),
                                            )),
                                          ),
                                        ],
                                      ),
                                      if(controller.chatsModel.chats![index].unreadCount == 0)if(controller.chatsModel.chats![index].lastMessage?.content != null)const Icon(Icons.done_all),
                                    ],
                                  ),
                                  SizedBox(width: 20.aw,),
                                ],
                              ),
                              SizedBox(height : 20.aw,),
                            ],
                          ),
                        );
                      },

                    ) )

                    //
                  ]),
                ),
              ));
        });

    Get.find<DashBoardController>().bottomBarShow.value = true;

  }

  static Future<bool> saveBottomSheet(
      {required BuildContext context,
        required String id,
        required PostType postType,
      }) async {


      SaveController controller ;
     if (Get.isRegistered<SaveController>()) {
        controller =Get.find<SaveController>();
     } else {
       controller = Get.put(SaveController());
      print("MyController is not initialized.");
    }

     bool issave  = false;
     bool name = await showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          Get.find<DashBoardController>().bottomBarShow.value = true;
          return FractionallySizedBox(
              heightFactor: .55,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // Get.back(t);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20.aw,right: 20.aw,top: 20.aw,),
                  width: double.infinity,
                  child: ListView(
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
                            "Save post too...",
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
                                const Text("New Category")
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.ah,
                      ),

                      for (Category data in (controller.cateogoryModel.value?.categories ?? []))
                        InkWell(
                          onTap: () async {
                            print("Line539==$issave");
                            issave = await ApiRepository.saveAllById(
                                postType: postType,
                                id: id,
                                categoryId: "${data.id}");
                            print("Line544==$issave");
                            Get.back();

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
                  ),
                ),
              ));
        }).closed.then((value) => issave);
     return name;
  }

  



}




class ComnetsController extends GetxController {
  GetCommentsModel getCommentsModel = GetCommentsModel();
  RxBool isLoading = false.obs;

  TextEditingController commnetsTc = TextEditingController();

  getComments({required String id, required PostType postType}) async {
    isLoading.value = true;
    getCommentsModel =
        await ApiRepository.getCommentsAll(id: id, postType: postType);
    isLoading.value = false;
  }

  RxBool isLoadingPostCommnets = false.obs;

  postComments({
    required String id,
    required PostType postType,
    required String comment,
  }) async {
    isLoadingPostCommnets.value = true;
    await ApiRepository.postCommentAll(
        id: id, postType: postType, comment: comment);
    commnetsTc.clear();
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

class ShareController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFriends();
    getchats();
  }


  RxBool isLoading = false.obs;
  AllFriendsModel allFriendsModel = AllFriendsModel();
  getFriends() async {
    isLoading.value = true;
    allFriendsModel = await ApiRepository.getFriends();
    isLoading.value = false;
  }



  ChatsModel chatsModel =ChatsModel();
  RxBool isLoadingChatModel =false.obs;
  Future<void> getchats() async {
    isLoadingChatModel.value=true;
    final response =await ApiClient().getRequest(endPoint: "chat");
    chatsModel= ChatsModel.fromJson(response);
    isLoadingChatModel.value=false;
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

  void getCategory(){
    isloading.value = true;
    ApiRepository.getCategories().then((value) {
      cateogoryModel.value = value;
    });
    isloading.value = false;
  }



}


