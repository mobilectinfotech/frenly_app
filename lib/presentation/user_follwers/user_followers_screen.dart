import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../Widgets/custom_user_card.dart';
import 'UserFollowersModel.dart';

class UserFollowersScreen extends StatefulWidget {
  final String userId;
  const UserFollowersScreen({super.key, required this.userId});

  @override
  State<UserFollowersScreen> createState() => _UserFollowersScreenState();
}

class _UserFollowersScreenState extends State<UserFollowersScreen> {

  RxBool isLoading = false.obs;
  UserFollowersModel followersModel =UserFollowersModel();

  Future<void> userFollowers({required String userId}) async {
    isLoading.value =true;
    try{
      followersModel= await ApiRepository.userFollowers(userId: userId);

    }catch(e){
      print("catch${e.toString()}");

    }
    isLoading.value =false;
  }


  @override
  void initState() {
    super.initState();
    userFollowers(userId: widget.userId);
    
  }

  Future<void> _refresh() async {
    userFollowers(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary(
        title: "Followers".tr,
      ),
      body: Obx(
        () => isLoading.value
            ? const Center(
                child: CircularProgressIndicator(strokeWidth: 1,),
              )
            : followersModel.followers?.length == 0
                ? Center(
                    child: Text("You don't have any followers yet".tr),
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
                userFollowers(userId: widget.userId);
              },
              child: GridView.builder(
                  itemCount: followersModel.followers?.length ?? 0,
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
                        Get.to(()=>UserProfileScreen(
                          userId:
                          '${followersModel.followers?[index].id}',
                        ));

                      },
                      child:  CustomUserCard(users: followersModel.followers![index],),
                    );
                  }),
            ),
    );
  }
}
