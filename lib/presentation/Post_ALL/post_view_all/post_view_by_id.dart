import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Post_ALL/post_view_all/post_view_all_contorller.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_image_view.dart';

class PostSingleViewScreen extends StatefulWidget {
  final String  ? id ;
  const PostSingleViewScreen({super.key,required this.id});

  @override
  State<PostSingleViewScreen> createState() => _PostSingleViewScreenState();
}

class _PostSingleViewScreenState extends State<PostSingleViewScreen> {


  PostAllViewController controller = Get.put(PostAllViewController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getPostByid(id: '${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: SafeArea(
        child: Obx(
            ()=>  controller.isLoadingGetPostByid.value ? Center(child: CircularProgressIndicator()) : Scaffold(
            appBar: customAppbarForChat(context: context, imagepath: controller.postSingleViewModel?.post?.user?.avatarUrl,name: "${controller.postSingleViewModel?.post?.user?.fullName}", handle: "${controller.postSingleViewModel?.post?.user?.handle}"),
            body: Obx(
              ()=> controller.isLoadingGetPostByid.value ? Center(child: CircularProgressIndicator(),) : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Center(
                    child: CustomImageView(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      imagePath:  controller.postSingleViewModel?.post?.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "${controller.postSingleViewModel?.post?.caption}".capitalizeFirst!,
                      style:  TextStyle(
                          color: const Color(0xFF000000),
                          fontSize: 18.adaptSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 1.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
