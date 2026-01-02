import 'dart:convert';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_blog_card.dart';
import 'blogs_list_controller.dart';


class BlogsListScreen extends StatefulWidget {
  const BlogsListScreen({super.key});

  @override
  State<BlogsListScreen> createState() => _BlogsListScreenState();
}

class _BlogsListScreenState extends State<BlogsListScreen> {

  BlogListController controller= Get.put(BlogListController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary( title: 'Blogs'.tr),
      body: Padding(
        padding:  EdgeInsets.only(top: 15.0.ah),
        child: Obx(()=>controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),) :
        RefreshIndicator(
            onRefresh: () {
              return controller.refreshBlogList();
            },
            child: _blogs())),
      ),
    );
  }
  Widget _blogs() {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: controller.blogListModel.blogs!.length,
        padding: const EdgeInsets.only(bottom: 10),
        itemBuilder: (context, index) {
          // String jsonString = "${controller.blogListModel.blogs![index].tags}";
          // List<String> tagsList = json.decode(jsonString).cast<String>();
          String ? jsonString =controller.blogListModel.blogs![index].tags ;
          List<String> tagsList =jsonString==null ? [] : json.decode(jsonString).cast<String>();
          return CustomBlogCard(blog: controller.blogListModel.blogs![index], tagsList: tagsList,);
        },
      ),
    );
  }
}
