import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/core/constants/app_dialogs.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Widgets/bottom_sheet_widgets.dart';
import '../../Widgets/custom_image_view.dart';
import '../../core/constants/my_colour.dart';
import '../../core/utils/calculateTimeDifference.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/data_sources/remote/api_client.dart';
import '../../data/models/post_model.dart';
import '../../data/repositories/api_repository.dart';
import '../Vlog/vlog_like_commnet_share_common_view.dart';
import '../chat/Pages/all_frined/CreateChatModel.dart';
import '../chat/Pages/all_frined/all_friend_controller.dart';
import '../chat/Pages/chats/chats_controller.dart';
import '../dashboard_screen/dashboardcontroller.dart';

class PostLikeCommentsShareView extends StatefulWidget {
  final Post? post;
  final bool? colors;
  const PostLikeCommentsShareView({super.key, required this.post, this.colors});

  @override
  State<PostLikeCommentsShareView> createState() =>
      _PostLikeCommentsShareViewState();
}

class _PostLikeCommentsShareViewState extends State<PostLikeCommentsShareView> {
  DashBoardController controller = Get.find();
  AllFriendController allFriendController = Get.put(AllFriendController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              widget.post?.alreadyLiked == false
                  ? InkWell(
                      onTap: () async {
                        widget.post?.alreadyLiked = true;
                        setState(() {});
                        bool isLiked = await ApiRepository.postLike(
                            userId: "${widget.post?.id}");
                      },
                      child: CustomImageView(
                        imagePath: widget.colors == true
                            ? "assets/image/blue_unliked.svg"
                            : 'assets/image/blue_unliked.svg',
                        width: 24.aw,
                        height: 24.aw,
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        widget.post?.alreadyLiked = false;
                        setState(() {});
                        bool isLiked = await ApiRepository.postLike(
                            userId: "${widget.post?.id}");
                      },
                      child: CustomImageView(
                        imagePath: widget.colors == true
                            ? "assets/image/liked_blue_filled.svg"
                            : 'assets/image/liked_blue_filled.svg',
                        width: 24.aw,
                        height: 24.aw,
                      )),
              Text("${widget.post?.numberOfLikes}")
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  controller.bottomBarShow.value = false;
                  CustomBottomSheets.commentsBottomSheet(context001: context, id: "${widget.post?.id}");
              //    _bottomSheetWidget(vlogId: "${widget.post?.id}", context001: context);
                },
                child: CustomImageView(
                  imagePath: "assets/image/comments_blue.png",
                  width: 21.aw,
                  height: 21.aw,
                ),
              ),
              Text("${widget.post?.numberOfComments}")
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  _bottomSheetWidget2(
                      vlogId: "${widget.post?.id}", context001: context);
                },
                child: Image.asset(
                  'assets/image/Vector (1).png',
                  width: 22.aw,
                  height: 21.aw,
                  color: Colors.black,
                ),
              ),
              Text("${widget.post?.numberOfShares}")
            ],
          ),
          Column(
            children: [
              widget.post?.alreadySaved == false
                  ? InkWell(
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (c) {
                            return CategoryWidget(
                              vlogId: widget.post?.id ?? 0,
                              vlog3_Post1_Blog2: '1',
                              contexttt: context,
                            );
                          },
                        ).then((value) {
                          print('sdfghjkhgfdfghj,$value');
                          if (value == true) {
                            widget.post?.alreadySaved = true;
                            setState(() {});
                          }
                          setState(() {});
                        });
                        // widget.vlog.alreadySaved = true;
                        // setState(() {});
                        // bool isLiked = await  ApiRepository.vlogSave(userId:"${widget.vlog.id}" );
                      },
                      child: CustomImageView(
                        imagePath: "assets/image/save_false_blue.svg",
                        width: 21.aw,
                        height: 21.aw,
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        widget.post?.alreadySaved = false;
                        setState(() {});
                        bool isLiked = await ApiRepository.postSave(
                            userId: "${widget.post?.id}");
                      },
                      child: CustomImageView(
                        imagePath: "assets/image/save_true_blue.svg",
                        width: 21.aw,
                        height: 21.aw,
                      ),
                    ),
              Text("${widget.post?.numberOfSaves}")
            ],
          ),
        ],
      ),
    );
  }

  _bottomSheetWidget(
      {required BuildContext context001, required String vlogId}) {
    dashBoardController.getComments(vlogId: vlogId, post: true);
    showBottomSheet(
        context: context001,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .85,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.ah, right: 20.ah),
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
                          () => dashBoardController.isLoadingONComments.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ),
                                )
                              : Expanded(
                                  child: Obx(
                                    () =>
                                        dashBoardController.getCommentsModel
                                                .comments!.isEmpty
                                            ? const Center(
                                                child: Text(
                                                  "No comments yet",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )
                                            : ListView.builder(
                                                reverse: true,
                                                itemCount: dashBoardController
                                                    .getCommentsModel
                                                    .comments
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
                                                              width:
                                                                  40.adaptSize,
                                                              height:
                                                                  40.adaptSize,
                                                              imagePath: dashBoardController
                                                                  .getCommentsModel
                                                                  .comments?[
                                                                      index]
                                                                  .user
                                                                  ?.avatarUrl,
                                                              fit: BoxFit.cover,
                                                              radius: BorderRadius
                                                                  .circular(45
                                                                      .adaptSize),
                                                            ),
                                                            SizedBox(
                                                              width: 18.aw,
                                                            ),
                                                            Container(
                                                              width: 300.aw,
                                                              child: Column(
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
                                                                        "${dashBoardController.getCommentsModel.comments?[index].user?.fullName}  ",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14.adaptSize,
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        calculateTimeDifference(dashBoardController
                                                                            .getCommentsModel
                                                                            .comments![index]
                                                                            .createdAt!
                                                                            .toString()),
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
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 250
                                                                            .aw,
                                                                        child:
                                                                            Text(
                                                                          "${dashBoardController.getCommentsModel.comments?[index].content}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black.withOpacity(.50),
                                                                            fontSize:
                                                                                14,
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if ("${dashBoardController.getCommentsModel.comments?[index].user?.id}" ==
                                                                          "${PrefUtils().getUserId()}")
                                                                        InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            await ApiRepository.deletePostComment(
                                                                                postId: "${widget.post?.id}",
                                                                                commentId: "${dashBoardController.getCommentsModel.comments?[index].id}");
                                                                            dashBoardController.getComments(vlogId: vlogId);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Delete",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black.withOpacity(.50),
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
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
                        ),
                        SizedBox(
                          height: 10.v,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 300.aw,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15),
                                      disabledBorder: InputBorder.none,
                                      hintText: "Add a comment ..."),
                                  onTap: () {},
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    dashBoardController.postCommnetOnVlog(
                                        vlogId: vlogId, post: true);
                                  },
                                  controller:
                                      dashBoardController.commentController,
                                  textInputAction: TextInputAction.send,
                                ),
                              ),
                              SizedBox(
                                width: 10.v,
                              ),
                              InkWell(
                                onTap: () {
                                  dashBoardController.postCommnetOnVlog(
                                      vlogId: vlogId, post: true);
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
        }).closed.then((value) {
      controller.bottomBarShow.value = true;
    });
  }

  _bottomSheetWidget2(
      {required BuildContext context001, required String vlogId}) {
    dashBoardController.getFriends();
    showBottomSheet(
        context: context001,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .65,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.ah, right: 20.ah),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 45.ah,
                        ),
                        SizedBox(
                          height: 74.ah,
                          child: Obx(
                            () => dashBoardController.isLoadingONShare.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: dashBoardController
                                        .getAllFriendsModel.friends?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () async {
                                          print("qwertyuiuytrewertyuytrewertg");
                                          CreateChatModel createChatModel =
                                              CreateChatModel();
                                          createChatModel =
                                              await ApiRepository.createChat(
                                                  userId:
                                                      "${dashBoardController.getAllFriendsModel.friends?[index].id}");
                                          ApiRepository.sendMessage(
                                              typeBlog2VLog3Photo1: "2",
                                              message:
                                                  ' Sent a Post by ${widget.post?.user?.handle}',
                                              chatId:
                                                  '${createChatModel.payload?.id}',
                                              isLinkId: "${widget.post?.id}",
                                              isUrl: " ");
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: CustomImageView(
                                              height: 65.adaptSize,
                                              width: 65.adaptSize,
                                              imagePath: dashBoardController
                                                  .getAllFriendsModel
                                                  .friends?[index]
                                                  .avatarUrl,
                                              fit: BoxFit.cover,
                                              radius: BorderRadius.circular(
                                                  45.adaptSize),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        Container(
                          height: 20.ah,
                        ),
                        Obx(
                          () => dashBoardController.isLoadingONShare.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ),
                                )
                              : Expanded(
                                  child: Obx(
                                    () => allFriendController.isLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : ListView.builder(
                                            itemCount: chatScreenController
                                                .chatsModel.chats!.length,
                                            itemBuilder: (context, index) =>
                                                customCard(index),
                                          ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 10.v,
                        ),
                      ]),
                ),
              ));
        }).closed.then((value) {
      controller.bottomBarShow.value = true;
    });
  }

  DashBoardController dashBoardController = Get.find();
  ChatScreenController chatScreenController = Get.put(ChatScreenController());

  Widget customCard(int index) {
    int indexxx =
        "${chatScreenController.chatsModel.chats![index].participants![0].id}" ==
                PrefUtils().getUserId()
            ? 1
            : 0;

    return InkWell(
      onTap: () async {
        final response = await ApiRepository.sendMessage(
            message: ' Sent a Post by ${widget.post?.user?.handle}',
            chatId: '${chatScreenController.chatsModel.chats![index].id}',
            typeBlog2VLog3Photo1: "1",
            isUrl: " ",
            isLinkId: "${widget.post?.id}");
        Get.back();
      },
      child: Column(
        children: [
          ListTile(
            leading: CustomImageView(
              radius: BorderRadius.circular(30),
              height: 55,
              width: 55,
              imagePath: chatScreenController
                  .chatsModel.chats![index].participants![indexxx].avatarUrl,
              fit: BoxFit.cover,
            ),
            title: Text(
              "${chatScreenController.chatsModel.chats![index].participants![indexxx].fullName}"
                  .capitalizeFirst!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                if (chatScreenController.chatsModel.chats![index].unreadCount ==
                    0)
                  if (chatScreenController
                          .chatsModel.chats![index].lastMessage?.content !=
                      null)
                    const Icon(Icons.done_all),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  chatScreenController
                          .chatsModel.chats![index].lastMessage?.content ??
                      "",
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //  Text(DateFormat('hh:mm a').format(controller.chatsModel.chats![index].lastMessage?.createdAt!.toLocal() ?? DateTime.now()),),
                const SizedBox(
                  height: 8,
                ),
                if (chatScreenController.chatsModel.chats![index].unreadCount !=
                    0)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColor.primaryColor),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 4, left: 9, right: 9),
                          child: Text(
                            "${chatScreenController.chatsModel.chats![index].unreadCount}",
                            style: TextStyle(
                                fontSize: 12.adaptSize, color: Colors.white),
                          ),
                        )),
                      ),
                    ],
                  )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
