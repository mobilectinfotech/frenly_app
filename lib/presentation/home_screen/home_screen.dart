import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frenly_app/Widgets/custom_user_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/discover_screen/discover_all_user.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../Widgets/bottom_sheet_widgets.dart';
import '../Blog/blog_view/blog_view_screen.dart';
import '../Blog/blogs_list/blogs_list_screen.dart';
import '../Vlog/vlog_full_view/vlog_view_screen.dart';
import '../Vlog/vlogs_list/vlogs_list_screen.dart';
import '../notification_screen/Notification_Screen.dart';
import '../popular_city/popular_city_screen.dart';
import '../popular_city/user_by_city_screen.dart';
import '../post/post_list/post_list_screen.dart';
import '../post/post_view/post_view_screen.dart';
import '../user_profile_screen/user_profile_screen.dart';
import 'controller/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  ShareController notUse = Get.put(ShareController(),permanent: true);
  SaveController notuse1 = Get.put(SaveController(),permanent: true);

  Future<void> _refresh() async {
    final response =  await ApiRepository.homePage();
    controller.homeData(response);
    controller.refresh();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(2000.ah), // preferred height for the app bar
          child: Container(
            color:const Color(0xFF001649),
            child: SafeArea(
              child: Container(
                color : Color(0xFF001649),
                child: Padding(
                  padding:  EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(width: 10.aw),
                      CustomImageView(imagePath: "assets/icons/transparent_bakgrund.svg",
                        height: 45.aw,width: 35.aw,fit: BoxFit.cover),

                      SizedBox(width: 15.aw),
                      SvgPicture.asset('assets/icons/fren.svg', height:25.aw,width: 30.aw,fit: BoxFit.cover),

                      // Text("Fren".tr,
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: const Color(0xFFFBFBD7),
                      //     fontSize: 28.adaptSize,
                      //     fontFamily: 'Roboto',
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      // ),

                       Spacer(),
                      CustomImageView(
                        onTap: () {
                          Get.to(()=> const NotificationScreen());
                        },
                        width: 30.adaptSize, height: 30.adaptSize,
                        radius: BorderRadius.circular(36.adaptSize),
                        fit: BoxFit.cover,
                        imagePath: "assets/icons/bell-ringing-04.svg",
                      ),
                      SizedBox(width: 16.aw),
                    ],
                  ),
                ),
              ),
            ),
          )),

      // appBar:customAppbarHomepage(context: context,title: "Foru".tr ,
      //   onTap: () {
      //   Get.to(()=>NotificationScreen());
      // },),

      body: Padding(
        padding: EdgeInsets.only(
          left: 10.h,
          right: 10.h,
        ),
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 1,),
                )
              : RefreshIndicator(
                 onRefresh: _refresh,
                child: ListView(
                    children: [
                      SizedBox(height: 20.ah),
                      checkIn(),


                      SizedBox(height: 20.ah),
                      titleViewAll(title: 'Live'.tr, onTap: () {Get.to(()=> const PopularsCityScreen());}),
                     SizedBox(height: 10.ah),
                      liveUserByCountry(),
                      SizedBox(height: 20.ah),
                      titleViewAll(title: 'Posts'.tr, onTap: () {Get.to(()=>const PostListScreen());}),
                      SizedBox(height: 20.ah),
                      posts(),
                      SizedBox(height: 25.ah),
                      titleViewAll(title: 'Vlogs'.tr, onTap: () {Get.to(()=>  const VlogsListScreen());}),
                      SizedBox(height: 16.ah,),
                      trending(),
                      SizedBox(height: 20.ah),
                      titleViewAll(title: 'Blogs'.tr, onTap: () {Get.to(()=> const BlogsListScreen());}),
                      SizedBox(height: 16.ah,),
                      popularBlog(),
                      SizedBox(height: 16.ah,),
                      titleViewAll(title: 'Discover'.tr, onTap: () {Get.to(()=> const DiscoverUsersScreen());}),
                      SizedBox(height: 16.ah,),
                      discoverUsers(),
                      SizedBox(height: 25.ah),

                    //  SizedBox(height: 100.ah),

                    ],
                  ),
              ),
        ),
      ),
    );
  }

  Widget checkIn() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/image/location.png',
              height: 24.ah, width: 24.aw, fit: BoxFit.fill),

            SizedBox(width: 10.aw),
            Text(
              'Check'.tr,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 21.fSize),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('${controller.city}',
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.black,
                  fontWeight: FontWeight.w600,fontSize: 15.fSize),
            ),

            SizedBox(width: 10.aw),
            Text('${controller.county}',
              style: TextStyle(fontFamily: 'Roboto', color: Colors.grey,
                  fontWeight: FontWeight.w500,fontSize: 15.fSize),
            ),
          ],
        ),
      ],
    );
  }

  Widget trending() {
    return SizedBox(
      height: 100.ah,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.homeModel.vlogs?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {Get.to(()=>VlogViewScreen(videoUrl: '${controller.homeModel.vlogs?[index].videoUrl}',
              vlogId:controller.homeModel.vlogs![index].id.toString(),));},
            child: Padding(
              padding:  EdgeInsets.only(right: 10.0.aw),
              child: SizedBox(
                width: 180.adaptSize,
                height: 90.adaptSize,
                child: Stack(
                    children: [
                  ThumailGenrate(videoUrl: controller.homeModel.vlogs?[index].videoUrl),
                  CustomImageView(
                    width: 180.adaptSize,
                    height: 90.adaptSize,
                    imagePath: "assets/image/gradient.svg",
                    radius: BorderRadius.circular(10.adaptSize),
                    fit: BoxFit.cover,
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget liveUserByCountry() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 176.ah,
      child:   (controller.homeModel.usersInCities?.length == null || controller.homeModel.usersInCities!.isEmpty ) ?  Center(child:Text("no_active_user_found".tr),): ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.homeModel.usersInCities?.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Get.to(()=> UserByCityScreen(city: '${controller.homeModel.usersInCities![index].city}',));
                },
                child: Card(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    shadowColor: Colors.black,
                    elevation: 8,
                    child: Padding(
                      padding:  EdgeInsets.all(15.0.adaptSize),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                for (int i = 0; i < (controller.homeModel.usersInCities?[index].users?.length ?? 0); i++)
                                  Align(
                                    widthFactor: 0.7,
                                    child: CustomImageView(
                                       height: 36.adaptSize,
                                       width: 36.adaptSize,
                                       radius: BorderRadius.circular(70.adaptSize),
                                       fit: BoxFit.cover,
                                       imagePath: controller.homeModel.usersInCities![index].users![i].avatarUrl,
                                    ),
                                  )
                              ],
                            ),
                          ),
                           SizedBox(height: 5.adaptSize),
                          Text(
                            '${controller.homeModel.usersInCities?[index].userCount}'.tr,
                            style: TextStyle(
                              color: const Color(0xff000000),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.fSize,
                            ),
                          ),
                          Text('Activee'.tr,
                            style: TextStyle(
                              color: const Color(0xff000000),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.fSize,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),

              // Text('${homeController.homeModel!.usersInCities![index].city.toString()}',
              Padding(
                padding:  EdgeInsets.only(left: 10.0.aw,top: 10.ah),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.homeModel.usersInCities?[index].city ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.fSize,
                      ),
                    ),
                    Text(
                      controller.homeModel.usersInCities?[index].country ?? "",
                      style: TextStyle(
                        color: const Color(0xffAAAAAA),
                        fontWeight: FontWeight.w600,
                        fontSize: 9.fSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      //),
    );
  }
  Widget popularBlog() {
    return SizedBox(
      height: 128.ah,
      width: 150.adaptSize,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.homeModel.blogs?.length ?? 0,
        itemBuilder: (context, index) {
          // String jsonString = "${controller.homeModel.blogs![index].tags}";
          // List<String> tagsList = json.decode(jsonString).cast<String>();
          String ? jsonString = controller.homeModel.blogs?[index].tags ;
          List<String> tagsList =jsonString==null ? [] : json.decode(jsonString).cast<String>();
          return InkWell(
            onTap: () {
              Get.to(()=>BlogViewScreen(id: "${controller.homeModel.blogs![index].id}",));
            },

            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 180.adaptSize,
                    height: 90.adaptSize,
                    child: Stack(
                      children: [
                        CustomImageView(
                          width: 180.adaptSize,
                          height: 90.adaptSize,
                          imagePath: controller.homeModel.blogs?[index].imageUrl ?? "assets/image/image_not_found.webp",
                          radius: BorderRadius.circular(10.adaptSize),
                          fit: BoxFit.cover,
                        ),
                        CustomImageView(
                          width: 180.adaptSize,
                          height: 90.adaptSize,
                          imagePath: "assets/image/gradient.svg",
                          radius: BorderRadius.circular(10.adaptSize),
                          fit: BoxFit.cover,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (int i = 0; i < (tagsList.length < 2 ? tagsList.length : 2); i++)
                              Padding(
                                padding: EdgeInsets.only(left: 5.0.aw),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white70),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 7,top: 2,bottom: 2),
                                          child: Text(
                                            tagsList[i],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10.adaptSize,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.adaptSize,)
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "${controller.homeModel.blogs?[index].title}".capitalizeFirst!,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w500,
                        fontSize: 10.fSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget discoverUsers() {
    return SizedBox(
      height: 223.ah,
      child: Obx(
        ()=> ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.homeModel.discoverUsers?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding:  const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: (){
                  Get.to(()=>UserProfileScreen(userId: '${controller.homeModel.discoverUsers?[index].id}',));
                },
                child: CustomUserCard(users: controller.homeModel.discoverUsers![index]),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget posts() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 135.ah,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.homeModel.posts?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Get.to(()=>PostViewScreen(id: "${controller.homeModel.posts?[index].id}",));

                // Get.to(()=>UserProfileScreen(userId: "${controller.homeModel.posts?[index].user?.id}"));
              },

            child: Padding(
              padding:  const EdgeInsets.only(right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomImageView(
                      width: 157.aw,
                      height: 82.ah,
                      fit: BoxFit.cover,
                      imagePath: controller.homeModel.posts?[index].imageUrl,
                      radius:  BorderRadius.all(Radius.circular(10.adaptSize),
                      )),
                  SizedBox(height: 15.ah),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImageView(
                          height: 30.ah,
                          width: 30.ah,
                          fit: BoxFit.fill,
                          imagePath: controller.homeModel.posts?[index].user?.avatarUrl,
                          // imagePath: "assets/image/Frame 427320834.png",
                          radius: const BorderRadius.all(
                            Radius.circular(50),
                          )),
                      SizedBox(width: 10.aw),
                      Text(
                        '${controller.homeModel.posts?[index].user?.handle}'.capitalizeFirst!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.fSize,
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
  Widget titleViewAll({required String title,required Function() onTap }){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr,
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 24.fSize),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            'veiww'.tr,
            style: TextStyle(
                fontFamily: 'Roboto',
                color: const Color(0xffAAAAAA),
                fontWeight: FontWeight.w600,
                fontSize: 16.fSize),
          ),
        ),
      ],
    );
  }

}

class ThumailGenrate extends StatefulWidget {
  String ? videoUrl ;
   ThumailGenrate({super.key, required this.videoUrl});

  @override
  State<ThumailGenrate> createState() => _ThumailGenrateState();
}

class _ThumailGenrateState extends State<ThumailGenrate> {



  Rxn<Uint8List> thumbnail = Rxn<Uint8List>();

  // Function to generate thumbnail
  Future<void> generateThumbnail(String videoUrl) async {
    try {
      // Generate the thumbnail asynchronously
      Uint8List? data = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 1280, // Set the max width for the thumbnail
        quality: 75,    // Set quality (0-100)
      );

      if (data != null) {
        // Update the thumbnail Rx with the generated thumbnail data
        thumbnail.value = data;
      } else {
      }
    } catch (e) {
    }
  }
  @override
  void initState() {
    super.initState();
    // Make sure videoUrl is valid
    if (widget.videoUrl != null) {
      generateThumbnail(widget.videoUrl ?? "");
    } else {
    }
  }


  @override
  Widget build(BuildContext context) {
    return   ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 180.adaptSize,
        height: 90.adaptSize,
        child: Obx(() {
          if(thumbnail.value==null){
            return const Center(child: CircularProgressIndicator());
          }
          return Image.memory(thumbnail.value!,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,);
        }),
      ),
    );
  }
}

