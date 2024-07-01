import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_vlog_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Post_ALL/post_view_all/post_full_view.dart';
import 'package:frenly_app/presentation/auth/my_profile_view/my_profile_controller.dart';
import 'package:frenly_app/presentation/search/search_controller.dart';
import 'package:get/get.dart';
import '../../Widgets/custom_image_view.dart';
import '../Blog/blog_full_view_screen/blogs_full_view_screen.dart';
import '../Vlog/vlog_like_commnet_share_common_view.dart';
import '../user_profile_screen/user_profile_screen.dart';
import '../vlog_full_view/vlog_full_view.dart';

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> with SingleTickerProviderStateMixin {
  SearchVlogController searchController = Get.put(SearchVlogController());
  List<bool> active = [
    false,
    false,
  ];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (tabController.indexIsChanging) {
      print("Tab index changed to: ${tabController.index}");
      searchController.searchController.clear();
      if (tabController.index == 1) {
        searchController.searchController.clear();
        searchController.searchBlog("", true);
      }
      if (tabController.index == 2) {
        searchController.searchController.clear();
        searchController.searchPhotos("", true);
      }
      if (tabController.index == 3) {
        searchController.searchController.clear();
        searchController.searchUsers("", true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  surfaceTintColor: Colors.black,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFe9eaec),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextFormField(
                      controller: searchController.searchController,
                      onChanged: (value) {
                        print("tabController${tabController.index}");
                        if (tabController.index == 0) {
                          searchController.searchVlogg(
                              searchController.searchController.text, false);
                        }
                        if (tabController.index == 1) {
                          searchController.searchBlog(
                              searchController.searchController.text, false);
                        }
                        if (tabController.index == 2) {
                          searchController.searchPhotos(
                              searchController.searchController.text, false);
                        }
                        if (tabController.index == 3) {
                          searchController.searchUsers(
                              searchController.searchController.text, false);
                        }
                      },
                      cursorColor: const Color(0xFF000000),
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Search".tr,
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 19.fSize,
                              fontWeight: FontWeight.w500),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Container(
                height: 62.ah,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  automaticIndicatorColorAdjustment: false,
                  indicatorColor: Colors.black,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  unselectedLabelColor: Colors.grey,
                  padding: const EdgeInsets.all(10),
                  onTap: (value) {
                    print("fdsfjkhffjsfjhkfsfs");
                  },
                  isScrollable: false,
                  tabs: [
                    Tab(
                      //icon: Icon(Icons.chat_bubble),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          //color: HexColor('#001649')
                        ),
                        child: Center(
                          child: Text(
                            'Vlogs'.tr,
                            //style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize:18.fSize),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 40.ah,
                        width: 112.aw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // color: HexColor('#001649')
                        ),
                        child: Center(
                          child: Text(
                            'Blogs'.tr,
                            // style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize:18.fSize),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 40.ah,
                        width: 112.aw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // color: HexColor('#001649')
                        ),
                        child: Center(
                          child: Text(
                            'Photos'.tr,
                            //style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize:18.fSize),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      //icon: Icon(Icons.chat_bubble),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // color: HexColor('#001649')
                        ),
                        child: Center(
                          child: Text(
                            'Profiles'.tr,
                            //style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize:18.fSize),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    Obx(() => searchController.isLoadingVlog.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : vloglist()),
                    Obx(() => searchController.isLoadingBlog.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _blogs()),
                    Obx(() => searchController.isLoadingBlog.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : photos()),
                    Obx(() => searchController.isLoadingBlog.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : users()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget photos() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
            // primary: false,
            // shrinkWrap: true,
            itemCount:
                (searchController.searchPhotosModel.posts?.length ?? 0) + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 173,
              mainAxisSpacing: 7,
              crossAxisSpacing: 7,
            ),
            itemBuilder: (context, index) {
              try {
                return InkWell(
                  onTap: () {
                    Get.to(() => PostFullViewScreen(
                        post:
                            searchController.searchPhotosModel.posts?[index]));
                  },
                  child: CustomImageView(
                    imagePath: searchController
                        .searchPhotosModel.posts?[index].imageUrl,
                    radius: BorderRadius.circular(20),
                    fit: BoxFit.cover,
                    // height: 158.ah,width: 173.aw,
                  ),
                );
              } catch (e) {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }

  Widget _blogs() {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: searchController.searchBlogModel.blogs!.length,
          padding: const EdgeInsets.only(bottom: 10),
          itemBuilder: (context, index) {
            String jsonString =
                "${searchController.searchBlogModel.blogs![index].tags}";
            List<String> tagsList = json.decode(jsonString).cast<String>();
            return Container(
              margin: EdgeInsets.only(
                  bottom: searchController.searchBlogModel.blogs!.length ==
                          (index + 1)
                      ? 100
                      : 0),
              child: InkWell(
                onTap: () {
                  Get.to(() => BlogsFullViewScreen(
                        id: searchController.searchBlogModel.blogs![index].id
                            .toString(),
                      ));
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
                          const SizedBox(
                            width: 10,
                          ),
                          CustomImageView(
                            height: 144.ah,
                            width: 144.ah,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(10),
                            imagePath: searchController
                                .searchBlogModel.blogs![index].imageUrl,
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
                                    for (int i = 0;
                                        i <
                                            (tagsList.length < 2
                                                ? tagsList.length
                                                : 2);
                                        i++)
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0.aw),
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
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(left: 7.0.aw),
                                  child: SizedBox(
                                    width: 220.aw,
                                    child: Text(
                                      '${searchController.searchBlogModel.blogs?[index].title}'
                                          .tr,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 5.aw),
                                    CustomImageView(
                                      height: 35.ah,
                                      width: 35.ah,
                                      fit: BoxFit.cover,
                                      imagePath: searchController
                                          .searchBlogModel
                                          .blogs?[index]
                                          .imageUrl,
                                      radius: BorderRadius.circular(32),
                                    ),
                                    SizedBox(width: 10.aw),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${searchController.searchBlogModel.blogs?[index].user?.fullName}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.fSize,
                                          ),
                                        ),
                                        Text(
                                          '${searchController.searchBlogModel.blogs?[index].user?.fullName}',
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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget vloglist() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15,),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: searchController.searchModel.vlogs?.length,
          padding: const EdgeInsets.only(bottom: 10),
          itemBuilder: (context, index) {
            return CustomVlogCard(vlog: searchController.searchModel.vlogs![index],);
          },
        ),
      ),
    );
  }

  Widget vlogInLocationRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
      child: SizedBox(
        height: 40.ah,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                'assets/image/location-outline.png',
                width: 21.ah,
                height: 21.ah,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                '${searchController.searchModel.vlogs![index].user?.city}, ',
                style: TextStyle(
                  color: const Color(0xffFFFFFF),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.fSize,
                ),
              ),
            ),
            Text(
              '${searchController.searchModel.vlogs![index].user?.country}',
              style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w600,
                fontSize: 11.fSize,
              ),
            ),
            const Spacer(),
            Builder(builder: (context) {
              try {
                MyProfileController controller = Get.find();
                if (controller.getUserByIdModel.user?.id ==
                    searchController.searchModel.vlogs![index].userId) {
                  return Image.asset(
                    'assets/image/more op.png',
                    width: 22.aw,
                  );
                }
              } catch (e) {}
              return const SizedBox.shrink();
            }),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget userLikeViewShare({
    required int index,
    required BuildContext contextttt,
  }) {
    DateTime currentDate = DateTime.now();
    DateTime createdAtDate = DateTime.parse(
        "${searchController.searchModel.vlogs?[index].createdAt}");
    int differenceInDays = currentDate.difference(createdAtDate).inDays;
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 15, top: 116.ah),
      child: SizedBox(
        height: 160.ah,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                '${searchController.searchModel.vlogs![index].title}'
                    .capitalizeFirst!,
                style: TextStyle(
                    color: const Color(0xffFFFFFF),
                    fontWeight: FontWeight.w700,
                    fontSize: 16.fSize,
                    height: 1.5),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10.ah),
                    CustomImageView(
                      height: 30.ah,
                      width: 30.ah,
                      imagePath: searchController
                          .searchModel.vlogs![index].user?.avatarUrl,
                      radius: BorderRadius.circular(30.ah),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 90,
                      child: Text(
                        "  ${'${searchController.searchModel.vlogs![index].user?.fullName}  '.capitalizeFirst!}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xffFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 11.fSize,
                        ),
                      ),
                    ),
                    Text(
                      '${searchController.searchModel.vlogs![index].numberOfViews} views ',
                      style: TextStyle(
                        color: const Color(0xffFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 11.fSize,
                      ),
                    ),
                    Text(
                      '${differenceInDays} days ago',
                      style: TextStyle(
                        color: const Color(0xffFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 11.fSize,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                VlogLikeCommentsShareView(
                  vlog: searchController.searchModel.vlogs![index],
                ),
                SizedBox(width: 15.0.aw)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget users() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: searchController.searchUserModel.users?.length,
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
                bottom: searchController.searchUserModel.users?.length ==
                        (index + 1)
                    ? 100
                    : 0),
            child: InkWell(
              onTap: () {
                Get.to(() => UserProfileScreen(
                      userId:
                          '${searchController.searchUserModel.users?[index].id}',
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImageView(
                      height: 62.adaptSize,
                      width: 62.adaptSize,
                      imagePath: searchController
                          .searchUserModel.users?[index].avatarUrl,
                      radius: BorderRadius.circular(62.adaptSize),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10.aw),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${searchController.searchUserModel.users?[index].fullName}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17.fSize,
                          ),
                        ),
                        Text(
                          '${searchController.searchUserModel.users?[index].handle}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.fSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
