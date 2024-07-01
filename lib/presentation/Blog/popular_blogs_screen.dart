import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Blog/popular_blog_controller.dart';
import 'package:get/get.dart';
import '../../Widgets/custom_image_view.dart';
import 'blog_full_view_screen/blogs_full_view_screen.dart';


class PopularBlogScreen extends StatefulWidget {
  const PopularBlogScreen({super.key});

  @override
  State<PopularBlogScreen> createState() => _PopularBlogScreenState();
}

class _PopularBlogScreenState extends State<PopularBlogScreen> {

  PopularBlogController controller= Get.put(PopularBlogController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppbar(context : context , title:  'Popublog'.tr),
        body: Obx(()=>controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) : _blogs()),
      
      ),
    );
  }
  Widget _blogs() {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: controller.popularBlogModel.blogs!.length,
        padding: const EdgeInsets.only(bottom: 10),
        itemBuilder: (context, index) {
          String jsonString = "${controller.popularBlogModel.blogs![index].tags}";
          List<String> tagsList = json.decode(jsonString).cast<String>();
          return InkWell(
            onTap: (){
              Get.to(()=>BlogsFullViewScreen(id: controller.popularBlogModel.blogs![index].id.toString(),));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10,),
                      CustomImageView(
                        height: 144.ah,
                        width: 144.ah,
                        fit: BoxFit.cover,
                        radius: BorderRadius.circular(10),
                        imagePath: controller.popularBlogModel.blogs![index].imageUrl,
                      ),
                      SizedBox(
                        width: 10.aw,
                      ),
                      SizedBox(
                        height: 144.ah,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 10.ah,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for(int i=0 ;i< (tagsList.length < 2 ? tagsList.length :2 ) ; i++)
                                  Padding(
                                    padding:  EdgeInsets.only(left: 5.0.aw),
                                    child:  Container(
                                      height: 20.ah,
                                      width: 60.aw,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 0.3),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.transparent),
                                      child: Center(
                                        child: Text(
                                          tagsList[i].tr,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10.fSize),
                                        ),
                                      ),
                                    ),
                                  ),

                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding:  EdgeInsets.only(left: 7.0.aw),
                              child: SizedBox(
                                width: 220.aw,
                                child: Text(
                                  '${controller.popularBlogModel.blogs?[index].title}'.tr,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.fSize),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.ah),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 5.aw),
                                CustomImageView(
                                  height: 35.ah,
                                  width: 35.ah,
                                  fit: BoxFit.cover,
                                  imagePath: controller.popularBlogModel.blogs?[index].imageUrl,
                                  radius: BorderRadius.circular(32),
                                ),
                                SizedBox(width: 10.aw),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${controller.popularBlogModel.blogs?[index].user?.fullName}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.fSize,
                                      ),
                                    ),
                                    Text(
                                      '${controller.popularBlogModel.blogs?[index].user?.handle}',
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
                      ),
                    ],
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
