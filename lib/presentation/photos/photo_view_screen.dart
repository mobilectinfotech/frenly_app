import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../Widgets/custom_image_view.dart';
import '../../data/models/PostSingleViewModel.dart';
import '../../data/repositories/api_repository.dart';
import '../auth/my_profile_view/my_profile_controller.dart';
import '../user_profile_screen/user_profile_screen.dart';
import 'PostLikeCommentsShareView.dart';

class PostFullViewScreen extends StatefulWidget {
  final bool  ? own ;
  final String ? loadPostByid ;
  const PostFullViewScreen({super.key ,this.own,this.loadPostByid});

  @override
  State<PostFullViewScreen> createState() => _PostFullViewScreenState();
}

class _PostFullViewScreenState extends State<PostFullViewScreen> {


  RxBool isLoading=false.obs ;

  PostSingleViewModel ? postSingleViewModel ;

    getPostByid({required String id}) async {
      isLoading.value=true;
       postSingleViewModel = await   ApiRepository.getPostsByID(id: '$id');
      isLoading.value=false;

  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.loadPostByid !=null) {
      getPostByid(id: widget.loadPostByid!);
    }
  }

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       appBar: AppBar(),
       body:   Obx(
        ()=> isLoading.value ? Center(child: CircularProgressIndicator(strokeWidth: 1,),) : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.all(8.0.adaptSize),
              child: InkWell(
                onTap: () {
                   Get.to(()=> UserProfileScreen(userId: "${postSingleViewModel?.post?.user?.id}"));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImageView(
                      height: 50.ah,
                      width: 50.ah,
                      imagePath: postSingleViewModel?.post?.user?.avatarUrl,
                      radius: BorderRadius.circular(60.ah),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10.aw),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${postSingleViewModel?.post?.user?.fullName}".capitalizeFirst!,
                          style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w700,fontSize:20.fSize,
                          ),),
                        Text("${postSingleViewModel?.post?.user?.handle}",
                          style: TextStyle(
                            color: Colors.grey,fontWeight: FontWeight.w500,fontSize:14.fSize,
                          ),),
                      ],
                    ),
                    Spacer(),
                    widget.own ==true ? InkWell(
                        onTap: () async{
                        await   ApiRepository.deletePost(postId: "${postSingleViewModel?.post?.id}");
                        Get.back();
                        if(Get.isRegistered<MyProfileController>()) {
                          Get.find<MyProfileController>().getProfile(); //asdfg
                        }
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          size: 30,
                        )) : SizedBox(),
                    SizedBox(width: 10.aw),

                  ],
                ),
              ),
            ),
            SizedBox(height: 15.ah),
            Stack(
              children: [
                CustomImageView(
                  width: MediaQuery.of(context).size.width,
                  imagePath:postSingleViewModel?.post?.imageUrl,

                  fit: BoxFit.cover,
                ),
                InkWell(
                  onTap: () {
                 //   Get.to(()=>PostFullViewScreen(post: widget.post!));
                  },
                  child: Container(
                      width: 385.adaptSize,
                      height: 385.adaptSize,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 335.adaptSize,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Text("${postSingleViewModel?.post?.caption}".capitalizeFirst!,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.adaptSize ,fontWeight: FontWeight.w400,color: Colors.white),),
                          ),
                        ],
                      )

                  ),
                ),
              ],
            ),
             SizedBox(height: 40.ah),

            PostLikeCommentsShareView(post: postSingleViewModel?.post,),
          ],
        ),
      )
    );
  }

}
