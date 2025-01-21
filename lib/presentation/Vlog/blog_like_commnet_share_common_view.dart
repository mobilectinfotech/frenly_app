import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../Widgets/bottom_sheet_widgets.dart';
import '../../Widgets/custom_image_view.dart';
import '../../data/models/blog_model.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

class BlogLikeCommentsShareView extends StatefulWidget {
  final Blog blog;
  bool? colors;

  BlogLikeCommentsShareView({super.key, required this.blog, this.colors});

  @override
  State<BlogLikeCommentsShareView> createState() =>
      _BlogLikeCommentsShareViewState();
}

class _BlogLikeCommentsShareViewState extends State<BlogLikeCommentsShareView> {
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
                    )

            ),
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
                  CustomBottomSheets.commentsBottomSheet(
                      context: context,
                      id: '${widget.blog.id}',
                      postType: PostType.blog);

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
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w500, fontSize: 12),
              )
            ],
          ),

        if (widget.blog.commentAllowed == true)
          widget.colors == true ? SizedBox() : SizedBox(width: 11.aw),

        InkWell(
          onTap: () {
            CustomBottomSheets.shareBottomSheet(
              isUrl: "aa",
                context: context,
                id: '${widget.blog.id}',
                postType: PostType.blog,
                userName: '${widget.blog.user?.handle}');
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
                    onTap: () async {
                      print("line_119${widget.blog?.alreadySaved}");
                      bool name = await CustomBottomSheets.saveBottomSheet(
                        context: context,
                        id: "${widget.blog.id ?? 0}",
                        postType: PostType.blog,
                      );
                      print("$name ==>viratkohli ");
                      if (name) {
                        widget.blog.numberOfSaves =
                            widget.blog.numberOfSaves! + 1;
                        widget.blog.alreadySaved = true;
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
                      print("line_130${widget.blog.alreadySaved}");
                      widget.blog.alreadySaved = false;
                      widget.blog.numberOfSaves =
                          widget.blog.numberOfSaves! - 1;
                      await ApiRepository.saveAllById(
                          postType: PostType.blog,
                          id: "${widget.blog.id ?? 0}",
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
            Text(
              "${widget.blog.numberOfSaves}",
              style: TextStyle(color: Colors.white),
            )


          ],
        ),
      ],
    );
  }
}
