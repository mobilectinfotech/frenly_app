import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../Widgets/custom_image_view.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../../data/repositories/api_repository.dart';
import '../chat_room/chat_room_page.dart';
import 'CreateChatModel.dart';
import 'all_friend_controller.dart';

class AllFriendsScreen extends StatefulWidget {
  const AllFriendsScreen({super.key});

  @override
  State<AllFriendsScreen> createState() => _AllFriendsScreenState();
}

class _AllFriendsScreenState extends State<AllFriendsScreen> {
  AllFriendController controller= Get.put(AllFriendController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllFriends();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBarPrimary(title:"selectfriend".tr) ,
      body: Obx(
        ()=>controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 1,)) :
        controller.allFriendsModel.friends?.length==0?Center(child:Text("no_friends_found".tr)):ListView.builder(
          itemCount: controller.allFriendsModel.friends!.length,
          itemBuilder: (context, index) => customCard(index),
        ),
      ),
    );
  }



  Widget customCard(int  index){

  //  int indexxx =  "${controller.chatsModel.chats![index].participants![0].id}" == userID ? 1 : 0 ;

    return InkWell(
      onTap: () async {
        CreateChatModel createChatModel = CreateChatModel();
        createChatModel = await ApiRepository.createChat(userId: "${controller.allFriendsModel.friends?[index].id}");
        int indexxx =  "${createChatModel.payload?.participants?[0].id}" == PrefUtils().getUserId() ? 1 : 0 ;

        Get.off( ()=> ChatRoomPage(participant:createChatModel.payload!.participants![indexxx], chatId: createChatModel.payload!.id.toString(),));

        //  Get.to( ()=>ChatRoomPage(participant:controller.chatsModel.chats![index].participants![indexxx], chatId: controller.chatsModel.chats![index].id.toString(),));

      },
      child:  Column(
        children: [
          ListTile(
            leading: CustomImageView(
              radius: BorderRadius.circular(30),
              height: 55,
              width: 55,
              imagePath: controller.allFriendsModel.friends?[index].avatarUrl,
              fit: BoxFit.cover,
            ),
            title: Text(
              "${controller.allFriendsModel.friends?[index].fullName}".capitalizeFirst!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  "${controller.allFriendsModel.friends?[index].handle?.capitalizeFirst!}",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

}
