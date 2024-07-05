import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/models/cateogry_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/bottom_sheet_widgets.dart';
import '../../Widgets/custom_image_view.dart';
import '../../core/constants/my_colour.dart';
import '../../core/utils/calculateTimeDifference.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/models/vlog_model.dart';
import '../../data/repositories/api_repository.dart';
import '../chat/Pages/all_frined/CreateChatModel.dart';
import '../chat/Pages/all_frined/all_friend_controller.dart';
import '../chat/Pages/chats/chats_controller.dart';
import '../dashboard_screen/dashboardcontroller.dart';
import 'add_new_category/add_new_cateogry_bottom_sheet.dart';

class VlogLikeCommentsShareView extends StatefulWidget {
  final Vlog vlog;
  final bool? colors;
  final bool ? commentsAllowed ;
 const VlogLikeCommentsShareView({super.key, required this.vlog, this.colors, this.commentsAllowed});

  @override
  State<VlogLikeCommentsShareView> createState() =>
      _VlogLikeCommentsShareViewState();
}

class _VlogLikeCommentsShareViewState extends State<VlogLikeCommentsShareView> {
  DashBoardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.vlog.alreadyLiked == false
            ? InkWell(
                onTap: () async {
                  widget.vlog.alreadyLiked = true;
                  setState(() {});
                  bool isLiked =
                      await ApiRepository.vlogLike(userId: "${widget.vlog.id}");
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
                  widget.vlog.alreadyLiked = false;
                  setState(() {});
                  bool isLiked =
                      await ApiRepository.vlogLike(userId: "${widget.vlog.id}");
                },
                child: CustomImageView(
                  imagePath: widget.colors == true
                      ? "assets/image/love_true_blue.svg"
                      : 'assets/image/love_true_white.svg',
                  width: 21.aw,
                  height: 21.aw,
                )),

        widget.vlog.commentAllowed  == false ? Container() : widget.commentsAllowed ==false  ? Container() : SizedBox(width: 11.aw),
        Builder(builder: (context) {
          print("line 75");
          print(widget.vlog.commentAllowed);
          return widget.vlog.commentAllowed == false
              ? Container()
              :widget.commentsAllowed ==false  ? Container() : InkWell(
                  onTap: () {
                    controller.bottomBarShow.value = false;
                    CustomBottomSheets.commentsBottomSheet(context: context, id: '${widget.vlog.id}', postType: PostType.vlog);
                  },
                  child: CustomImageView(
                    imagePath: widget.colors == true
                        ? "assets/image/comments_blue.png"
                        : 'assets/image/Union (2).png',
                    width: 21.aw,
                    height: 21.aw,
                  ),
                );
        }),
        // widget.colors == true ? SizedBox() : SizedBox(width: 11.aw),
        widget.colors == false
            ? SizedBox()
            : InkWell(
                onTap: () {
                  _bottomSheetWidget2(
                      context001: context, vlogId: "${widget.vlog.id}");
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 11.aw),
                  child: Image.asset(
                    'assets/image/Vector (1).png',
                    width: 22.aw,
                    height: 21.aw,
                    color: widget.colors == true
                        ? MyColor.primaryColor
                        : Colors.white,
                  ),
                ),
              ),
        SizedBox(width: 11.aw),

        //   save

        widget.vlog.alreadySaved == false
            ? InkWell(
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (c) {
                      return CategoryWidget(
                        vlogId: widget.vlog.id!,
                        contexttt: context,
                        vlog3_Post1_Blog2: '3',
                      );
                    },
                  ).then((value){
                    print("line 132");
                    print(value);
                    if(value==true){
                      widget.vlog.alreadySaved=true;
                      setState(() {

                      });
                    }
                  });
                  // widget.vlog.alreadySaved = true;
                  // setState(() {});
                  // bool isLiked = await  ApiRepository.vlogSave(userId:"${widget.vlog.id}" );
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
                  widget.vlog.alreadySaved = false;
                  setState(() {});
                  bool isLiked =
                      await ApiRepository.vlogSave(userId: "${widget.vlog.id}");
                },
                child: CustomImageView(
                  imagePath: widget.colors == true
                      ? "assets/image/save_true_blue.svg"
                      : 'assets/image/save_true_white.svg',
                  width: 21.aw,
                  height: 21.aw,
                ),
              ),

        //save end
      ],
    );
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
                        Container(
                          height: 74.ah,
                          child: Obx(
                            () => dashBoardController.isLoadingONShare.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                  )
                                : dashBoardController.getAllFriendsModel.friends?.length == 0 ? Center(child: Text("No user found"),) : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: dashBoardController.getAllFriendsModel.friends?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () async {
                                              CreateChatModel createChatModel =
                                                  CreateChatModel();
                                              createChatModel =
                                                  await ApiRepository.createChat(
                                                      userId:
                                                          "${dashBoardController.getAllFriendsModel.friends?[index].id}");
                                              ApiRepository.sendMessage(
                                                  typeBlog2VLog3Photo1: "3",
                                                  message:
                                                      ' Sent a Vlog by ${widget.vlog.user?.handle}',
                                                  chatId:
                                                      '${createChatModel.payload?.id}',
                                                  isLinkId: "${widget.vlog.id}",
                                                  isUrl:
                                                      "${widget.vlog.videoUrl}");
                                              Get.back();
                                            },
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
                                        : chatScreenController.chatsModel.chats!.length == 0 ? const Center(child: Text("No chats Found"),) :  ListView.builder(
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

  // Future<bool> sendMessage({required String message, required String chatId}) async {
  //   final response = await ApiClient().postRequest(endPoint: "message/${chatId}", body: {"content": message,"isLink" : "3"});
  //   return true;
  // }

  Widget customCard(int index) {
    int indexxx =
        "${chatScreenController.chatsModel.chats![index].participants![0].id}" ==
                PrefUtils().getUserId()
            ? 1
            : 0;

    return InkWell(
      onTap: () {
        ApiRepository.sendMessage(
            typeBlog2VLog3Photo1: "3",
            message: ' Sent a Vlog by ${widget.vlog.user?.handle}',
            chatId: '${chatScreenController.chatsModel.chats![index].id}',
            isLinkId: "${widget.vlog.id}",
            isUrl: "${widget.vlog.videoUrl}");
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

  DashBoardController trendingVlogController = Get.find();
}

class CategoryContoller extends GetxController {
  Rxn<CategoryModel> cateogoryModel = Rxn();

  @override
  void onInit() {
    super.onInit();
    ApiRepository.getCategories().then((value) {
      cateogoryModel.value = value;
    });
  }
}

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    super.key,
    required this.vlogId,
    required this.vlog3_Post1_Blog2,
    required this.contexttt,
  });

  final int vlogId;
  final String vlog3_Post1_Blog2;

  final BuildContext contexttt;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    Get.delete<CategoryContoller>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryContoller contoller = Get.put(CategoryContoller());
    return Obx(() {
      if (contoller.cateogoryModel.value == null) {
        return const Center(
          child: CircularProgressIndicator(
            color: MyColor.primaryColor,
          ),
        );
      }
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.aw),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 6.ah,
            ),
            Opacity(
              opacity: 0.50,
              child: Container(
                width: 48.aw,
                height: 5.ah,
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
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
                    onTapAddNewCategory(context: widget.contexttt);
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
            for (Category data
                in (contoller.cateogoryModel.value?.categories ?? []))
              InkWell(
                onTap: () async {
                  if (widget.vlog3_Post1_Blog2 == "1") {
                    await ApiRepository.savePostBYid(
                        vlogId: widget.vlogId, categoryId: data.id!);
                  }
                  if (widget.vlog3_Post1_Blog2 == "2") {
                    await ApiRepository.saveBlogBYid(
                        vlogId: widget.vlogId, categoryId: data.id!);
                  }
                  if (widget.vlog3_Post1_Blog2 == "3") {
                    await ApiRepository.saveVlogBYId(
                        vlogId: widget.vlogId, categoryId: data.id!);
                  }
                  Get.back(result: true);
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
      );
    });
  }
}
