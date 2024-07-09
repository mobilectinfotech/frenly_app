import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../Widgets/bottom_sheet_widgets.dart';
import '../../Widgets/custom_image_view.dart';
import '../../data/models/post_model.dart';
import '../../data/repositories/api_repository.dart';
import '../chat/Pages/all_frined/all_friend_controller.dart';
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
                  CustomBottomSheets.commentsBottomSheet(context: context, id: '${widget.post?.id}', postType: PostType.post);
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
                //  CustomBottomSheets.shareBottomSheet(context: context, id: '${widget.post?.id}', postType: PostType.post,userName:'${widget.post?.user?.handle}' );
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
                        print("line_119${widget.post?.alreadySaved}");
                        bool name  =   await  CustomBottomSheets.saveBottomSheet(context: context, id: "${widget.post?.id ?? 0}", postType: PostType.post, );
                         print(  "$name ==>dfsdfsfsfsf ");
                        if(name){
                          widget.post!.numberOfSaves  = widget.post!.numberOfSaves! + 1;
                          widget.post?.alreadySaved = true;
                        }

                         setState(() {});},
                      child: CustomImageView(
                        imagePath: "assets/image/save_false_blue.svg",
                        width: 21.aw,
                        height: 21.aw,
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        print("line_130${widget.post?.alreadySaved}");
                        widget.post?.alreadySaved = false;
                        widget.post!.numberOfSaves  = widget.post!.numberOfSaves! - 1;
                        setState(() {});
                       await ApiRepository.saveAllById(postType: PostType.post, id: "${widget.post?.id ?? 0}", categoryId: "0");

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






}
