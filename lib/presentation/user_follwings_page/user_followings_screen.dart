import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_user_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_appbar.dart';
import 'UserFollowersModel.dart';

class UserFollowingsScreen extends StatefulWidget {
  final String userId;
  const UserFollowingsScreen({super.key, required this.userId});

  @override
  State<UserFollowingsScreen> createState() => _UserFollowingsScreenState();
}

class _UserFollowingsScreenState extends State<UserFollowingsScreen> {

  RxBool isLoading = false.obs;
  UserFollowingModel followingsModel = UserFollowingModel();

  Future<void> userfollowings({required String userId}) async {
    isLoading.value =true;
    try{
      followingsModel= await ApiRepository.userFollwings(userId: userId);

    }catch(e){
      print("catch${e.toString()}");

    }
    isLoading.value =false;
  }


  @override
  void initState() {
    super.initState();
    userfollowings(userId: widget.userId);
    
  }

  Future<void> _refresh() async {
    userfollowings(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary(title: "Followings".tr,),
      body: Obx(
        () => isLoading.value
            ? const Center(
                child: CircularProgressIndicator(strokeWidth: 1,),
              )
            : followingsModel.followings?.length == 0
                ? Center(
                    child: Text("No followings Found"),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView(
                        children: [
                          SizedBox(height: 10.ah),
                          gridView(),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget gridView() {
    return Obx(
      () => isLoading.value
          ? const Center(
              child: CircularProgressIndicator(strokeWidth: 1,),
            )
          : RefreshIndicator(
              onRefresh: () async {
                userfollowings(userId: widget.userId);
              },
              child: GridView.builder(
                  itemCount: followingsModel.followings?.length ?? 0,
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
                        Get.to(()=>UserProfileScreen(userId:
                        '${followingsModel.followings?[index].id}',));
                      },
                      child: CustomUserCard(users: followingsModel.followings![index],),
                    );
                  }),
            ),
    );
  }
}
