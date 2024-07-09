import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_user_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_appbar.dart';
import 'my_follwings_controller.dart';

class MyFollowingScreen extends StatefulWidget {
  const MyFollowingScreen({super.key});

  @override
  State<MyFollowingScreen> createState() => _MyFollowingScreenState();
}

class _MyFollowingScreenState extends State<MyFollowingScreen> {
  MyFollowingsController controller = Get.put(MyFollowingsController());
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
        appBar: appBarPrimary( title: "Followings".tr,),
        body: Obx(
    () => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(strokeWidth: 1,),
          )
        : controller.followingsModel.followings?.length == 0
            ? Center(
                child: Text("No followings Found"),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    children: [SizedBox(height: 10.ah), gridView()],
                  ),
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
              child: GridView.builder(
                  itemCount: controller.followingsModel.followings?.length,
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
                          Get.to(() => UserProfileScreen(
                                userId:
                                    '${controller.followingsModel.followings?[index].id}',
                              ));
                        },
                        child: CustomUserCard(
                          users: controller.followingsModel.followings![index],
                        ));
                  }),
            ),
    );
  }
}
