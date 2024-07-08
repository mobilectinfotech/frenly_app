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
                  CustomBottomSheets.shareBottomSheet(context: context, id: '${widget.vlog.id}', postType: PostType.vlog,userName:'${widget.vlog.user?.handle}' );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 11.aw),
                  child: Image.asset(
                    'assets/image/Vector (1).png',
                    width: 22.aw,
                    height: 21.aw,
                    color: widget.colors == true ? MyColor.primaryColor : Colors.white,
                  ),
                ),
              ),
        SizedBox(width: 11.aw),

        widget.vlog.alreadySaved == false
            ? InkWell(
          onTap: () async {
            print("line_119${widget.vlog?.alreadySaved}");
            bool name = await CustomBottomSheets.saveBottomSheet(
              context: context,
              id: "${widget.vlog.id ?? 0}",
              postType: PostType.vlog,
            );
            print("$name ==>dfsdfsfsfsf ");
            if (name) {
              widget.vlog.numberOfSaves =
                  widget.vlog.numberOfSaves! + 1;
              widget.vlog.alreadySaved = true;
            }

            setState(() {});
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
            print("line_130${widget.vlog.alreadySaved}");
            widget.vlog.alreadySaved = false;
            widget.vlog.numberOfSaves =
                widget.vlog.numberOfSaves! - 1;
            await ApiRepository.saveAllById(
                postType: PostType.vlog,
                id: "${widget.vlog.id ?? 0}",
                categoryId: "0");
            setState(() {});
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
}
