import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/Widgets/custom_user_card.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'user_by_city_controller.dart';

class UserByCityScreen extends StatefulWidget {
   final String city ;
  const UserByCityScreen({super.key,required this.city});

  @override
  State<UserByCityScreen> createState() => _UserByCityScreenState();
}

class _UserByCityScreenState extends State<UserByCityScreen> {

  UserByCityController controller = Get.put(UserByCityController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getUserByCity(city: widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary(title: "Discover".tr),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top:10),
        child: ListView(
          children: [
            SizedBox(height: 10.ah),
            Text('Profile'.tr,
              style: const TextStyle(
                  color: Colors.black,fontWeight: FontWeight.w600,fontSize:24
              ),),
            SizedBox(height: 20.ah),
           gridView(),
          ],
        ),
      ),

    );
  }

 Widget gridView(){
    return Obx(
        ()=>controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),): GridView.builder(
          itemCount: controller.getUserByCityModel.users?.length,
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
                 Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(userId: '${controller.getUserByCityModel.users![index].id}',)));
              },
              child: Container(
                height: 220.ah,width: 120.aw,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      //color: HexColor('#FFFFFF'),
                        color: Colors.black12,
                        width:1
                    )
                ),
                child: CustomUserCard(
                  users: controller.getUserByCityModel.users![index],
                ),
              ),
            );
          }),
    );
  }


}


