import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Vlog/vlog_like_commnet_share_common_view.dart';
import 'package:get/get.dart';
import '../../Widgets/bottom_sheet_widgets.dart';
import '../../Widgets/custom_image_view.dart';
import '../../core/constants/app_dialogs.dart';
import '../../core/constants/my_colour.dart';
import '../../core/utils/calculateTimeDifference.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/models/blog_model.dart';
import '../../data/repositories/api_repository.dart';
import '../Blog/blog_full_view_screen/blog_full_view_controller.dart';
import '../chat/Pages/all_frined/CreateChatModel.dart';
import '../chat/Pages/all_frined/all_friend_controller.dart';
import '../chat/Pages/chats/chats_controller.dart';
import '../dashboard_screen/dashboardcontroller.dart';

class BlogLikeCommentsShareView extends StatefulWidget {
  final Blog blog;
  bool? colors;

  BlogLikeCommentsShareView({super.key, required this.blog, this.colors});

  @override
  State<BlogLikeCommentsShareView> createState() =>
      _BlogLikeCommentsShareViewState();
}

class _BlogLikeCommentsShareViewState extends State<BlogLikeCommentsShareView> {
  DashBoardController controller = Get.find();
  BlogFullViewController blogFullViewController = Get.put(BlogFullViewController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            widget.blog.alreadyLiked == false
                ? InkWell(
                    onTap: () async {
                      widget.blog.alreadyLiked = true;
                      widget.blog.numberOfLikes =
                          widget.blog.numberOfLikes! + 1;
                      setState(() {});
                      bool isLiked = await ApiRepository.blogLike(
                          userId: "${widget.blog.id}");
                    },
                    child: CustomImageView(
                      imagePath: widget.colors == true
                          ? "assets/image/love_false_blue.svg"
                          : 'assets/image/love_false_white.svg',
                      width: 21.aw,
                      height: 21.aw,
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      widget.blog.alreadyLiked = false;
                      widget.blog.numberOfLikes =
                          widget.blog.numberOfLikes! - 1;

                      setState(() {});
                      bool isLiked = await ApiRepository.blogLike(
                          userId: "${widget.blog.id}");
                    },
                    child: CustomImageView(
                      imagePath: widget.colors == true
                          ? "assets/image/love_true_blue.svg"
                          : 'assets/image/love_true_white.svg',
                      width: 21.aw,
                      height: 21.aw,
                    )),
            SizedBox(
              height: 4,
            ),
            Text(
              "${widget.blog.numberOfLikes}",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            )
          ],
        ),

        SizedBox(width: 11.aw),
        if (widget.blog.commentAllowed == true)
          Column(
            children: [
              InkWell(
                onTap: () {
                  controller.bottomBarShow.value = false;
                  CustomBottomSheets.commentsBottomSheet(context: context, id: '${widget.blog.id}', postType: PostType.blog);
                },
                child: CustomImageView(
                  imagePath: widget.colors == true
                      ? "assets/image/comments_blue.png"
                      : 'assets/image/Union (2).png',
                  width: 21.aw,
                  height: 21.aw,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "${widget.blog.numberOfComments}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              )
            ],
          ),

        if (widget.blog.commentAllowed == true)
          widget.colors == true ? SizedBox() : SizedBox(width: 11.aw),



        InkWell(
          onTap: () {
            _bottomSheetWidget2(context001: context, vlogId: '${widget.blog.id}');
          },
          child: Column(
            children: [
              Image.asset(
                'assets/image/Vector (1).png',
                width: 22.aw,
                height: 21.aw,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "${widget.blog.numberOfShares}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              )
            ],
          ),
        ),
        SizedBox(width: 11.aw),
        //   save

        Column(
          children: [
            widget.blog.alreadySaved == false
                ? InkWell(
                 // onTap: (){
                 //   // widget.vlog.alreadySaved =true;
                 //   setState(() {
                 //
                 //   });
                 // },
                    onTap: () async {
                      print("line158");
                      showModalBottomSheet(
                        context: context,
                        builder: (c) {
                          return CategoryWidget(
                            vlog3_Post1_Blog2: '2',
                            vlogId: widget.blog.id!,
                            contexttt: context,
                          );
                        },
                      ).then((value) async {
                        print("line169");
                        print("fdsffdsffsffdsffdsfa#${value}");
                        if ("$value" == "true") {
                          print("fdsffdsffsffdsffdsfa#2345674567${value}");
                          widget.blog.alreadySaved = true;
                          print("line 180${widget.blog.alreadySaved}");
                          setState(() {});
                          Future.delayed(Duration(seconds: 3)).then((value) {
                            print("line 183${widget.blog.alreadySaved}");
                          });
                        }
                      });
                    },
                    child: CustomImageView(
                      imagePath: widget.colors == true
                          ? "assets/image/save_false_blue.svg"
                          : 'assets/image/save_false_white.svg',
                      width: 21.aw,
                      height: 21.aw,
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      print("line189");

                        setState(() {
                          ApiRepository.blogSave(userId: "${widget.blog.id}");
                          widget.blog.alreadySaved =false;
                        });
                      // ApiRepository.blogSave(userId: "${widget.vlog.id}").then((value) {
                      //   widget.vlog.alreadySaved == false;
                      //   setState(() {});
                      // });
                    },
                    child: CustomImageView(
                      imagePath: widget.colors == true
                          ? "assets/image/save_true_blue.svg"
                          : 'assets/image/save_true_white.svg',
                      width: 21.aw,
                      height: 21.aw,
                    ),
                  ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "${widget.blog.numberOfSaves}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            )
          ],
        ),

        //save end
      ],
    );
  }


  DashBoardController trendingVlogController = Get.find();

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
                                          CreateChatModel createChatModel =
                                              CreateChatModel();
                                          createChatModel =
                                              await ApiRepository.createChat(
                                                  userId:
                                                      "${dashBoardController.getAllFriendsModel.friends?[index].id}");
                                          ApiRepository.sendMessage(
                                              typeBlog2VLog3Photo1: "2",
                                              message:
                                                  ' Sent a Post by ${widget.blog.user?.handle}',
                                              chatId:
                                                  '${createChatModel.payload?.id}',
                                              isLinkId: "${widget.blog.id}",
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
  AllFriendController allFriendController = Get.put(AllFriendController());

  ChatScreenController chatScreenController = Get.put(ChatScreenController());

  Widget customCard(int index) {
    int indexxx =
        "${chatScreenController.chatsModel.chats![index].participants![0].id}" ==
                PrefUtils().getUserId()
            ? 1
            : 0;

    return InkWell(
      onTap: () {
        ApiRepository.sendMessage(
            message: ' Sent a Blog by ${widget.blog.user?.handle}',
            chatId: '${chatScreenController.chatsModel.chats![index].id}',
            isLinkId: "${widget.blog.id}",
            isUrl: " ",
            typeBlog2VLog3Photo1: "2");
        AppDialog.taostMessage(
            "Blog Shared Successfully${"${widget.blog.id}"}");
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
