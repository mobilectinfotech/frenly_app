import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/Widgets/custom_user_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_appbar.dart';
import 'my_follwer_controller.dart';

class MyFollowersScreen extends StatefulWidget {
  const MyFollowersScreen({super.key});

  @override
  State<MyFollowersScreen> createState() => _MyFollowersScreenState();
}

class _MyFollowersScreenState extends State<MyFollowersScreen> {
  MyFollowersController controller = Get.put(MyFollowersController());


  @override
  void initState() {
    super.initState();
    controller.myFollowers();
  }

  Future<void> _refresh() async {
    controller.myFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppbar(
          context: context,
          title: "Followers".tr,
        ),
        body: Obx(
              ()=> controller.isLoading.value ? const Center(child: CircularProgressIndicator(),)
              : controller.followingsModel.followers?.length == 0 ? Center(child: Text("No Followers Found"),) : Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: RefreshIndicator(
              onRefresh:_refresh ,
              child: ListView(
                children: [
                  SizedBox(height: 10.ah),
                  gridView(),
                ],
              ),
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
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: () async {
          controller.myFollowers();
        },
        child: GridView.builder(
            itemCount: controller.followingsModel.followers?.length,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(userId: '${controller.followingsModel.followers?[index].id}',)));
                },
                child: CustomUserCard(users: controller.followingsModel.followers![index],),
              );
            }),
      ),
    );
  }

}