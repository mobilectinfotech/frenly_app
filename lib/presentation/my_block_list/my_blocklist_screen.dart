import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_appbar.dart';
import 'my_blocklist_controller.dart';

class MyBlockedUserListScreen extends StatefulWidget {
  const MyBlockedUserListScreen({super.key});

  @override
  State<MyBlockedUserListScreen> createState() =>
      _MyBlockedUserListScreenState();
}

class _MyBlockedUserListScreenState extends State<MyBlockedUserListScreen> {
  MyBlockListController controller = Get.put(MyBlockListController());
  Future<void> _refresh() async {
    controller.myFollowers();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.myFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: savePageAppbar(
        context: context,
        title: "BList".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            children: [SizedBox(height: 10.ah), gridView()],
          ),
        ),
      ),
    );
  }

  Widget gridView() {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(strokeWidth: 1,),
            )
          : RefreshIndicator(
              onRefresh: () async {
                controller.myFollowers();
              },
              child:  controller.blockUserList.myBlockedUserList?.length == 0 ? Center(child: SizedBox(height: MediaQuery.of(context).size.height*0.7,child: Center(child: Text("You don't have any blocked users".tr)))) : GridView.builder(
                  itemCount: controller.blockUserList.myBlockedUserList?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 220.ah,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => UserProfileScreen(
                        //               userId: '${controller.blockUserList.myBlockedUserList?[index].id}',
                        //             )));
                      },
                      child: Container(
                        height: 220.ah,
                        width: 120.aw,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                //color: HexColor('#FFFFFF'),
                                color: Colors.black12,
                                width: 1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              height: 104.adaptSize,
                              width: 104.adaptSize,
                              imagePath: controller.blockUserList
                                  .myBlockedUserList?[index].avatarUrl,
                              radius: BorderRadius.circular(109.ah),
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${controller.blockUserList.myBlockedUserList?[index].fullName}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.fSize),
                              ),
                            ),
                            Text(
                              controller.blockUserList.myBlockedUserList?[index]
                                      .handle ??
                                  '',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.fSize),
                            ),
                            SizedBox(height: 4.ah),
                            Text(
                              '${controller.blockUserList.myBlockedUserList?[index].numberOfFollower ?? ''}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.fSize),
                            ),
                            SizedBox(height: 10.ah),
                            InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    controller
                                            .blockUserList
                                            .myBlockedUserList?[index]
                                            .isFollowed =
                                        !controller
                                            .blockUserList
                                            .myBlockedUserList![index]
                                            .isFollowed!;
                                    if (controller
                                        .blockUserList
                                        .myBlockedUserList![index]
                                        .isFollowed!) {
                                      print("is_pr_user_block_hoga");
                                      ApiRepository.blockUser(
                                          userId:
                                              "${controller.blockUserList.myBlockedUserList?[index].id!}");
                                    } else {
                                      ApiRepository.unblockUser(
                                          userId:
                                              "${controller.blockUserList.myBlockedUserList?[index].id!}");
                                    }
                                  },
                                );
                              },
                              child: Container(
                                height: 24.ah,
                                width: 98.aw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: controller.blockUserList
                                          .myBlockedUserList![index].isFollowed!
                                      ? Colors.red
                                      : HexColor('#001649'),
                                ),
                                child: Center(
                                  child: Text(
                                    controller
                                            .blockUserList
                                            .myBlockedUserList![index]
                                            .isFollowed!
                                        ? "unblock".tr
                                        : "block".tr,
                                    style: TextStyle(
                                        color: controller
                                                .blockUserList
                                                .myBlockedUserList![index]
                                                .isFollowed!
                                            ? Colors.white
                                            : Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.fSize),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
