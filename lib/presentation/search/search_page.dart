import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frenly_app/Widgets/custom_blog_card.dart';
import 'package:frenly_app/Widgets/custom_vlog_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/search/search_controller.dart';
import 'package:get/get.dart';
import '../../Widgets/bottom_sheet_widgets.dart';
import '../../Widgets/custom_image_view.dart';
import '../post/post_view/post_view_screen.dart';
import '../user_profile_screen/user_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  String? hastag;
  PostType? postType;
  SearchScreen({super.key, this.hastag, this.postType});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {



  int  _currentIndex = 0 ;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  SearchVlogController searchController = Get.put(SearchVlogController());
  PageController _pageController =PageController();





  @override
  void initState() {
    super.initState();

    if(widget.postType?.name == PostType.blog.name){
      print("object" );
      searchController.searchBlog("${widget.hastag}", true).then((value) {
        _onItemTapped(1);
      });
      Future.delayed(Duration(seconds: 1)).then((value) {
        searchController.searchController.text = "${widget.hastag}";
      });
    }

    if(widget.postType?.name == PostType.post.name){
      print("object" );
      searchController.searchPhotos("${widget.hastag}", true).then((value) {
        _onItemTapped(2);
      });
      Future.delayed(Duration(seconds: 1)).then((value) {
        searchController.searchController.text = "${widget.hastag}";
      });

    }

  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        //appBar: appBarPrimary(title: 'Search'.tr),
        body: SafeArea(
          child: Column(
            children: [
             SizedBox(height: 10.ah),
              Padding(
                padding:  EdgeInsets.only(left: 10.aw, right: 10.aw),
                child: serchTextField(context: context,  controller: searchController.searchController,),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  serchText('Vlogs'.tr,0),
                  serchText('Blogs'.tr,1),
                  serchText('Photos'.tr,2),
                  serchText('Profiles'.tr,3),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    vloglist(),
                    _currentIndex == 1 ? _blogs() : Container(),
                    _currentIndex == 2 ? photos() : Container(),
                    _currentIndex == 3 ? users() : Container(),
                  ],
                ),
              )
          
            ],
          ),
        ));
  }
  Widget serchText(String name,int indexxx) {
    return  InkWell(
      onTap: () {
        _onItemTapped(indexxx);

        if (indexxx == 0) {
          searchController.searchController.clear();
          searchController.searchVlogg(searchController.searchController.text, true);
        }
        if (indexxx== 1) {
          searchController.searchController.clear();
          searchController.searchBlog(searchController.searchController.text, true);
        }
        if (indexxx == 2) {
          searchController.searchController.clear();
          searchController.searchPhotos(
              searchController.searchController.text, true);
        }
        if (indexxx == 3) {
          searchController.searchController.clear();
          searchController.searchUsers(searchController.searchController.text, true);
        }
        setState(() {});
      },
      child: Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
              border: _currentIndex == indexxx ? Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  )
              ) : null,
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(name.tr, style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize:18.fSize),),
          ))),
    );
  }

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
      child:Obx(
        ()=> searchController.isLoadingPosts.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),) : searchController.searchPhotosModel.posts!.length == 0
            ? Center(
                child: Text("No Matches found"),
              )
            : ListView(
                padding: EdgeInsets.only(bottom: 100),
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
                            Get.to(() => PostViewScreen(
                                  id: "${searchController.searchPhotosModel.posts![index].id}",
                                ));
                          },
                          child: CustomImageView(
                            imagePath: searchController
                                .searchPhotosModel.posts![index].imageUrl,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(10),
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _blogs() {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => searchController.isLoadingBlog.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),) :  searchController.searchBlogModel.blogs?.length == 0
            ? Center(
                child: Text("No results match your search criteria.".tr),
              )
            : ListView.builder(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: searchController.searchBlogModel.blogs?.length,
                padding: const EdgeInsets.only(bottom: 10),
                itemBuilder: (context, index) {
                  // String jsonString = "${searchController.searchBlogModel.blogs![index].tags}";
                  // List<String> tagsList = json.decode(jsonString).cast<String>();
                  String ? jsonString =searchController.searchBlogModel.blogs?[index].tags ;
                  List<String> tagsList =jsonString==null ? [] : json.decode(jsonString).cast<String>();
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
      () =>  searchController.isLoadingVlog.value ? Center(child: CircularProgressIndicator(strokeWidth: 1,),) : Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15,
        ),
        child: searchController.searchModel.vlogs!.isEmpty
            ? Center(
                child: Text("No results match your search criteria.".tr),
              )
            : ListView.builder(
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
      () => searchController.isLoadingUsers.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),) : searchController.searchUserModel.users!.length == 0
          ? Center(
              child: Text(
                  textAlign: TextAlign.center,
                  "No users found for your search."),
            )
          : ListView.builder(
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
  Widget serchTextField({required BuildContext  context, TextEditingController? controller,Function(String)? onChange,String ? hintText}){
    return  Padding(
      padding: EdgeInsets.only(left: 4.aw, right: 4.aw),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 52.ah,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(8.adaptSize),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withOpacity(0.25),
                spreadRadius: -1,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            cursorColor: const Color(0xFF000000),
            style:  TextStyle(
                color: Color(0xff000000),
                fontSize: 20.fSize,
                fontWeight: FontWeight.w500),
            controller: controller,
            onChanged: (value) {
              if (_currentIndex == 0) {
                searchController.searchVlogg(searchController.searchController.text, false);
              }
              if (_currentIndex == 1) {
                searchController.searchBlog(searchController.searchController.text, false);
              }
              if (_currentIndex == 2) {
                searchController.searchPhotos(
                    searchController.searchController.text, false);
              }
              if (_currentIndex == 3) {
                searchController.searchUsers(
                    searchController.searchController.text, false);
              }
            },
            decoration: InputDecoration(
              //contentPadding: EdgeInsets.all(0.adaptSize),
                prefixIcon: Padding(padding: const EdgeInsets.all(13.0),
                  child: SvgPicture.asset(
                    'assets/icons/serch_icon.svg',
                    height: 6.ah,

                  ),
                ),
                hintText:"Search".tr,
                hintStyle: TextStyle(
                    color: Color(0xff000000).withOpacity(0.30),
                    fontSize: 19.fSize,
                    fontWeight: FontWeight.w500),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }


}
