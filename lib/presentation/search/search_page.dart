import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frenly_app/Widgets/custom_blog_card.dart';
import 'package:frenly_app/Widgets/custom_vlog_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/search/search_controller.dart';
import 'package:get/get.dart';
import '../../Widgets/custom_image_view.dart';
import '../photos/photo_view_screen.dart';
import '../user_profile_screen/user_profile_screen.dart';

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
                      onTap: () {},
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
                            child: CircularProgressIndicator(strokeWidth: 1,),
                          )
                        : vloglist()),
                    Obx(() => searchController.isLoadingBlog.value
                        ? const Center(
                            child: CircularProgressIndicator(strokeWidth: 1,),
                          )
                        : _blogs()),
                    Obx(() => searchController.isLoadingBlog.value
                        ? const Center(
                            child: CircularProgressIndicator(strokeWidth: 1,),
                          )
                        : photos()),
                    Obx(() =>  searchController.isLoadingBlog.value
                        ? const Center(
                            child: CircularProgressIndicator(strokeWidth: 1,),
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

  // Widget photos() {
  //   return Container(
  //     child: Obx(
  //       () => GridView.builder(
  //           padding: EdgeInsets.zero,
  //           // primary: false,
  //           // shrinkWrap: true,
  //           itemCount:
  //               (searchController.searchPhotosModel.posts?.length ?? 0) + 1,
  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             mainAxisSpacing: 7,
  //             crossAxisSpacing: 7,
  //           ),
  //           itemBuilder: (context, index) {
  //             try {
  //               return InkWell(
  //                 onTap: () {
  //                   Get.to(() => PostFullViewScreen(
  //                       loadPostByid:
  //                           "${searchController.searchPhotosModel.posts?[index].id}"));
  //                 },
  //                 child: CustomImageView(
  //                   imagePath: searchController
  //                       .searchPhotosModel.posts?[index].imageUrl,
  //                   radius: BorderRadius.circular(20),
  //                   fit: BoxFit.cover,
  //                   // height: 158.ah,width: 173.aw,
  //                 ),
  //               );
  //             } catch (e) {
  //               return const SizedBox.shrink();
  //             }
  //           }),
  //     ),
  //   );
  // }
  Widget photos() {
    List<int> cont = [
      1,
      1,
      1,
      1,
      2,
      1,
      2,
      1,
      1,
    ];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        padding: EdgeInsets.only(bottom : 100),
        children: [
          StaggeredGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: List.generate(
              searchController.searchPhotosModel.posts!.length,
                  (index) => StaggeredGridTile.count(
                crossAxisCellCount: cont[index % 9],
                mainAxisCellCount: cont[index % 9],
                child: Center(
                    child: InkWell(
                      onTap: () {
                        Get.to(()=>PostFullViewScreen( loadPostByid: "${searchController.searchPhotosModel.posts![index]}", ));
                      },
                      child: CustomImageView(
                        imagePath:
                        searchController.searchPhotosModel.posts![index].imageUrl,
                        fit: BoxFit.cover,
                        radius: BorderRadius.circular(10),
                      ),
                    )),
              ),
            ),
          ),
        ],
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
            String jsonString = "${searchController.searchBlogModel.blogs![index].tags}";
            List<String> tagsList = json.decode(jsonString).cast<String>();
            return CustomBlogCard(
              tagsList: tagsList,
              blog: searchController.searchBlogModel.blogs![index],
            );
          },
        ),
      ),
    );
  }

  Widget vloglist() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: searchController.searchModel.vlogs?.length,
          padding: const EdgeInsets.only(bottom: 10),
          itemBuilder: (context, index) {
            return CustomVlogCard(
              vlog: searchController.searchModel.vlogs![index],
            );
          },
        ),
      ),
    );
  }

  Widget users() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: searchController.searchUserModel.users?.length ?? 0,
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
