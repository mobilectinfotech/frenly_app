import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Blog/popular_blog_controller.dart';
import 'package:get/get.dart';
import '../../Widgets/custom_blog_card.dart';


class PopularBlogScreen extends StatefulWidget {
  const PopularBlogScreen({super.key});

  @override
  State<PopularBlogScreen> createState() => _PopularBlogScreenState();
}

class _PopularBlogScreenState extends State<PopularBlogScreen> {

  PopularBlogController controller= Get.put(PopularBlogController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary( title:  'Popublog'.tr),
      body: Padding(
        padding:  EdgeInsets.only(top: 10.0.ah),
        child: Obx(()=>controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),) : _blogs()),
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
          return CustomBlogCard(blog: controller.popularBlogModel.blogs![index], tagsList: tagsList,);
        },
      ),
    );
  }
}
