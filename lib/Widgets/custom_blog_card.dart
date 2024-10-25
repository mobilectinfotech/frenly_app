import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../data/models/blog_model.dart';
import '../presentation/Blog/blog_view/blog_view_screen.dart';
import '../presentation/search/search_page.dart';
import 'bottom_sheet_widgets.dart';
import 'custom_image_view.dart';

class CustomBlogCard extends StatefulWidget {
  bool ? isown;
  Blog blog ;
  List<String> tagsList;
   CustomBlogCard({super.key,required this.blog,required this.tagsList,this.isown});

  @override
  State<CustomBlogCard> createState() => _CustomBlogCardState();
}

class _CustomBlogCardState extends State<CustomBlogCard> {
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
        Get.to(() => BlogViewScreen(id: widget.blog.id.toString(),isOwn: widget.isown ?? false,
        ));
      },
      child: Padding(
        padding:  EdgeInsets.only(bottom: 10, right: 10.aw,left: 10.aw),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomImageView(
                height: 144.ah,
                width: 144.ah,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(10),
                imagePath:widget.blog.imageUrl ?? "assets/icons/imagenotfound.png",
              ),

            SizedBox(width: 10.aw),

            SizedBox(
              height: 144.ah,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [

                  SizedBox(height: 5.ah),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < (widget.tagsList.length < 2 ? widget.tagsList.length : 2); i++)
                        InkWell(
                          onTap: () {
                            Get.to(()=>SearchScreen(hastag:widget.tagsList[i],postType: PostType.blog,));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 5.0.aw),
                            child: Container(
                              height: 20.ah,
                              width: 60.aw,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 0.3),
                                  borderRadius:
                                  BorderRadius.circular(5),
                                  color: Colors.transparent),
                              child: Center(
                                child: Text(
                                  widget.tagsList[i],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.fSize),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 5.ah),
                  SizedBox(
                    width: 200.aw,
                    child: Text(
                      '${widget.blog.title}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.fSize),
                    ),
                  ),
                  Spacer(),
                  SizedBox(height: 5.ah),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImageView(
                        height: 35.ah,
                        width: 35.ah,
                        fit: BoxFit.cover,
                        imagePath: widget.blog?.user?.avatarUrl,
                        radius: BorderRadius.circular(32),
                      ),
                      SizedBox(width: 10.aw),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment:
                      MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.blog.user?.fullName}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.fSize,
                            ),
                          ),
                          Text(
                            '${widget.blog.user?.handle}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.fSize,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.aw),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
