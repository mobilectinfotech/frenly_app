import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_user_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/discover_screen/discover_all_user.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Widgets/custom_appbar.dart';
import '../Blog/blog_full_view_screen/blogs_full_view_screen.dart';
import '../Blog/popular_blogs_screen.dart';
import '../Post_ALL/post_view_all/post_view_all.dart';
import '../Vlog/vlogs_list/all_vlogs_list_screen.dart';
import '../notification_screen/Notification_Screen.dart';
import '../popular_city/popular_city_screen.dart';
import '../popular_city/user_by_city_screen.dart';
import '../user_profile_screen/user_profile_screen.dart';
import '../vlog_full_view/vlog_full_view.dart';
import 'controller/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());


  Future<void> _refresh() async {

    final response =  await ApiRepository.homePage();
    controller.homeData(response);
    controller.refresh();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:customAppbarHomepage(context: context,title: "Foru".tr ,onTap: () {
          Get.to(()=>NotificationScreen());
        },),
        body: Padding(
          padding: EdgeInsets.only(
            left: 10.h,
            right: 10.h,
          ),
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                   onRefresh: _refresh,
                  child: ListView(
                      children: [
                        SizedBox(height: 10.ah),
                        checkIn(),
                        SizedBox(height: 20.ah),
                        titleViewAll(title: 'Live'.tr, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const PopularsCityScreen()));}),
                        SizedBox(height: 10.ah),
                        liveUserByCountry(),
                        SizedBox(height: 20.ah),
                        titleViewAll(title: 'Trending', onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>  AllVlogScreen()));}),
                        SizedBox(height: 16.ah,),
                        trending(),
                        SizedBox(height: 20.ah),
                        titleViewAll(title: 'Popublog', onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const PopularBlogScreen()));}),
                        SizedBox(height: 16.ah,),
                        popularBlog(),
                        SizedBox(height: 16.ah,),
                        titleViewAll(title: 'Discover', onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscoverUsersScreen()));}),
                        SizedBox(height: 16.ah,),
                        discoverUsers(),
                        SizedBox(height: 25.ah),
                        titleViewAll(title: 'Posts', onTap: () {Get.to(()=>const PhotoViewAllNewScreen());}),
                        SizedBox(height: 25.ah),
                        posts(),
                        SizedBox(height: 100.ah),
                  
                      ],
                    ),
                ),
          ),
        ),
      ),
    );
  }

  Widget checkIn() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/location.png',
              height: 24.ah,
              width: 24.aw,
              fit: BoxFit.fill,
            ),
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
          children: [
            Text(
              '${controller.city}',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.fSize),
            ),
            SizedBox(width: 10.aw),
            Text(
              '${controller.county}',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.fSize),
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
        itemCount: controller.homeModel.vlogs?.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {Get.to(()=>VlogFullViewNewScreen(videoUrl: '${controller.homeModel.vlogs?[index].videoUrl}', vlogId:controller.homeModel.vlogs![index].id.toString(),));},
            child: Padding(
              padding:  EdgeInsets.only(right: 10.0.aw),
              child: SizedBox(
                width: 180.adaptSize,
                height: 90.adaptSize,
                child: Stack(children: [
                  CustomImageView(
                    width: 180.adaptSize,
                    height: 90.adaptSize,
                    imagePath: controller.homeModel.vlogs?[index].thumbnailUrl,
                    radius: BorderRadius.circular(10),
                    fit: BoxFit.cover,
                  ),
                  CustomImageView(
                    width: 180.adaptSize,
                    height: 90.adaptSize,
                    imagePath: "assets/image/gradient.svg",
                    radius: BorderRadius.circular(10),
                    fit: BoxFit.cover,
                  )
                ]),
              ),
            ),
          );
          return CustomImageView(
            width: 150.aw,
            height: 100.ah,
            imagePath: controller.homeModel.vlogs![index].thumbnailUrl,
            radius: BorderRadius.circular(10),
          );
        },
      ),
    );
  }
  Widget liveUserByCountry() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 176.ah,
      child:   controller.homeModel.usersInCities?.length == 0 ? const Center(child:Text("No active user found"),): ListView.builder(
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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                for (int i = 0; i < controller.homeModel.usersInCities![index].users!.length; i++)
                                  Align(
                                    widthFactor: 0.7,
                                    child: CustomImageView(
                                       height: 36,
                                       width: 36,
                                       radius: BorderRadius.circular(70),
                                       fit: BoxFit.cover,
                                       imagePath: controller.homeModel.usersInCities![index].users![i].avatarUrl,
                                    ),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${controller.homeModel.usersInCities?[index].userCount}'.tr,
                            style: TextStyle(
                              color: const Color(0xff000000),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.fSize,
                            ),
                          ),
                          Text(
                            'Activee'.tr,
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
                      '${controller.homeModel.usersInCities![index].city}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.fSize,
                      ),
                    ),
                    Text(
                      '${controller.homeModel.usersInCities![index].country}',
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
        itemCount: controller.homeModel.blogs?.length,
        itemBuilder: (context, index) {
          String jsonString = "${controller.homeModel.blogs![index].tags}";
          List<String> tagsList = json.decode(jsonString).cast<String>();
          return InkWell(
            onTap: () {
              Get.to(()=>BlogsFullViewScreen(id: "${controller.homeModel.blogs![index].id}",));
            },

            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 180.adaptSize,
                    height: 90.adaptSize,
                    child: Stack(
                      children: [
                        CustomImageView(
                          width: 180.adaptSize,
                          height: 90.adaptSize,
                          imagePath: controller.homeModel.blogs![index].imageUrl,
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
          itemCount: controller.homeModel.discoverUsers?.length,
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
      height: 125.ah,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.homeModel.posts?.length,
        itemBuilder: (context, index) {
          return Padding(
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
                SizedBox(height: 10.ah),
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
