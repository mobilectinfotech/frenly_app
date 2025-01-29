import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/Widgets/custom_user_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:get/get.dart';
import '../../Widgets/custom_appbar.dart';
import 'discover_controller.dart';

class DiscoverUsersScreen extends StatefulWidget {
  const DiscoverUsersScreen({super.key});

  @override
  State<DiscoverUsersScreen> createState() => _DiscoverUsersScreenState();
}

class _DiscoverUsersScreenState extends State<DiscoverUsersScreen> {


  DiscoverController controller = Get.put(DiscoverController());
  Future<void> _refresh() async {

   controller.discoveryUsers();


  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.discoveryUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary(title: "Discover".tr ,),
      body: Padding(
        padding:  EdgeInsets.only(left: 15.aw,right: 15.aw),
        child: ListView(
          children: [
           SizedBox(height: 10.ah),
            Text('Profile'.tr,
              style: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.w600,fontSize:24
              ),),
            SizedBox(height: 20.ah),
            RefreshIndicator(
                onRefresh: _refresh,
                child: gridView()),
          ],
        ),
      ),

    );
  }

 Widget gridView(){
    return Obx(
        ()=>controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),): RefreshIndicator(

          onRefresh: () async{
            controller.discoveryUsers();
          },
          child: GridView.builder(
            itemCount: controller.discoverUsersModel.discoverUsers?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,mainAxisExtent: 220.ah,
                mainAxisSpacing: 5,crossAxisSpacing: 5
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                   Get.to(() => UserProfileScreen(userId: '${controller.discoverUsersModel.discoverUsers![index].id}',));
                },
                child: CustomUserCard(users: controller.discoverUsersModel.discoverUsers![index],),
              );
            }),
        ),
    );
  }
}
