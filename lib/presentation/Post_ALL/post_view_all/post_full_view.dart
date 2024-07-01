import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_image_view.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/api_repository.dart';
import '../../auth/my_profile_view/my_profile_controller.dart';

class PostFullViewScreen extends StatefulWidget {
  final Post ? post ;
  final bool  ? own ;
  const PostFullViewScreen({super.key,required this.post,this.own});

  @override
  State<PostFullViewScreen> createState() => _PostFullViewScreenState();
}

class _PostFullViewScreenState extends State<PostFullViewScreen> {


  MyProfileController controller = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {return
      SafeArea(
        child: Scaffold(
          appBar: customAppbarForChat(context: context,imagepath:widget.own ==true ? controller.getUserByIdModel.user?.avatarUrl : widget.post?.user?.avatarUrl,name: "${widget.own ==true ? controller.getUserByIdModel.user?.fullName : widget.post?.user?.fullName}",handle:"${widget.own ==true ? controller.getUserByIdModel.user?.handle : widget.post?.user?.handle}",editBlogIcon: true ,onTap: () {
            print("sdfgh");
            _bottomSheetWidget2( vlogId: '');
          },),
          body:Builder(builder: (context) {
            controller.context=context;
            return  SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Center(
                    child: CustomImageView(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      imagePath:  widget.post?.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "${ widget.post?.caption}".capitalizeFirst!,
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
            );
          },)
        ),
      );
    },);
  }

  _bottomSheetWidget2(
      { required String vlogId}) {
    MyProfileController myProfileController=Get.find();
    showBottomSheet(
        context: myProfileController.context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .25,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Container(
                    // color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.ah, right: 20.ah),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 40,),
                            InkWell(
                              onTap: () async {

                                  await  ApiRepository.deletePost(postId: "${ widget.post?.id}");
                                  myProfileController.getProfile();
                                  Get.back();
                                  Get.back();
                                  Get.back();

                              },
                              child: Row(
                                children: [
                                  CustomImageView(
                                    height: 38,
                                    width: 38,
                                    imagePath: "assets/image/delete (1).png",
                                  ),
                                  SizedBox(width: 20,),
                                  const SizedBox(
                                    child: Text("Delete this Post"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            InkWell(
                              onTap: () async {
                                await  ApiRepository.deletePost(postId: "${ widget.post?.id}");
                                myProfileController.getProfile();
                                Get.back();
                                Get.back();
                                Get.back();
                              },
                              child: Row(
                                children: [
                                  CustomImageView(
                                    height: 38,
                                    width: 38,
                                    imagePath: "assets/image/edit_with_container.png",
                                  ),
                                  SizedBox(width: 20,),
                                  const SizedBox(
                                    child: Text("Edit this Post"),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ));
        }).closed.then((value) {});
  }
}
