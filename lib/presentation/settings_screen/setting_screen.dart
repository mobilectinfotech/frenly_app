import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import 'package:frenly_app/presentation/all_category/all_category_screen.dart';
import 'package:frenly_app/presentation/all_saved/my_saved_screen.dart';
import 'package:frenly_app/presentation/settings_screen/setting_controller.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/my_textfield.dart';
import '../../Widgets/bottom_sheet_widgets.dart';
import '../../core/utils/pref_utils.dart';
import '../../localservice/local_service.dart';
import '../auth/login_screen/login_screen.dart';
import '../my_block_list/my_blocklist_screen.dart';

class SettingScreen extends StatefulWidget {
  bool isAccountPrivate;

  SettingScreen({super.key, required this.isAccountPrivate});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingsController controller = Get.put(SettingsController());
  final LocaleService localeService = LocaleService();

  String crrentLagnauge = "English";

  Locale ? locale ;
  getLocale() async {
     locale = await localeService.getLocale();
  }

  // Future<Locale?> getLocale() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final languageCode = prefs.getString("locale");
  //   if (languageCode != null) {
  //     return Locale(languageCode);
  //   }
  //   return null;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocale();
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('choose_language'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('english'.tr),
                onTap: () async{
                  final newLocale = Locale('en', 'US');
                  await localeService.saveLocale(newLocale);
                  Get.updateLocale(newLocale);
                  locale =newLocale;
                  setState(() {});

                  Get.back();
                },
              ),
              ListTile(
                title: Text('swedish'.tr),
                onTap: () async{
                  final newLocale = Locale('swe', 'SE');
                  await localeService.saveLocale(newLocale);
                  Get.updateLocale(newLocale);
                  locale =newLocale;
                  setState(() {});
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPrimary(title: "Settings".tr),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: HexColor('#E8E8E8'), borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                             SizedBox(height: 10.ah),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Last'.tr,
                                    style:
                                        TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                  ),
                                  Transform.scale(
                                    scale: 0.4,
                                    child: CupertinoSwitch(
                                      activeColor: Colors.blueGrey,
                                      trackColor: Colors.grey,
                                      onLabelColor: Colors.brown,
                                      offLabelColor: Colors.red,
                                      thumbColor: const Color(0xff001649),
                                      value: controller.mySettingModel!.userSetting.lastSeen,
                                      onChanged: (bool value) {
                                        setState(() {
                                          controller.mySettingModel!.userSetting.lastSeen =
                                              !controller.mySettingModel!.userSetting.lastSeen;
                                          controller.mySettingsUpdate();
                                        });
                                      },
                                    ),
                                  ),
                                  //Image.asset('assets/image/Toggle switch.png',width: 28.aw,height: 17.ah,),
                                ],
                              ),
                             SizedBox(height: 10.ah),

                              //profile private public

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'private_account'.tr,
                                    style:
                                        TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                  ),
                                  Transform.scale(
                                    scale: 0.4,
                                    child: CupertinoSwitch(
                                      activeColor: Colors.blueGrey,
                                      trackColor: Colors.grey,
                                      onLabelColor: Colors.brown,
                                      offLabelColor: Colors.red,
                                      thumbColor: const Color(0xff001649),
                                      value: widget.isAccountPrivate,
                                      onChanged: (bool value) {
                                        setState(() {
                                          widget.isAccountPrivate = !widget.isAccountPrivate;
                                          ApiRepository.updateAccountPrivate(isPrivate: widget.isAccountPrivate);
                                        });
                                      },
                                    ),
                                  ),
                                  //Image.asset('assets/image/Toggle switch.png',width: 28.aw,height: 17.ah,),
                                ],
                              ),
                             SizedBox(height: 10.ah),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'CommentsonP'.tr,
                                    style:
                                        TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                  ),
                                  // Image.asset('assets/image/Toggle switch (1).png',width: 28.aw,height: 17.ah,),
                                  Transform.scale(
                                    scale: 0.4,
                                    child: CupertinoSwitch(
                                      activeColor: Colors.blueGrey,
                                      trackColor: Colors.grey,
                                      onLabelColor: Colors.brown,
                                      offLabelColor: Colors.red,
                                      thumbColor: const Color(0xff001649),
                                      value: controller.mySettingModel!.userSetting.commentsAllowed,
                                      onChanged: (bool value) {
                                        setState(() {
                                          controller.mySettingModel!.userSetting.commentsAllowed = value;
                                          controller.mySettingsUpdate();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                             SizedBox(height: 10.ah),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.ah),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: HexColor('#E8E8E8'), borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'ACCOUNT'.tr,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.fSize),
                              ),
                              SizedBox(height: 20.ah),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => const AllSavedScreen()));
                                },
                                child: Text(
                                  'Saved Items'.tr,
                                  style:
                                      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                ),
                              ),
                              SizedBox(height: 20.ah),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const MyBlockedUserListScreen());
                                    },
                                    child: Text(
                                      'Blocked List'.tr,
                                      style: TextStyle(
                                          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ''.tr,
                                        style: TextStyle(
                                            color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                      ),
                                      SizedBox(width: 10.aw),
                                      Text(
                                        'Contacts'.tr,
                                        style: TextStyle(
                                            color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.ah),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Languagegg'.tr,
                                    style:
                                        TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      _showLanguageDialog(context);

                                      // isenglish =await   PrefUtils().getUserLanguage();
                                    },
                                    child: Text(
                                       "${locale?.languageCode}" == "en" ? 'Eng'.tr :  "swedish".tr,
                                      style: TextStyle(
                                          color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.ah),
                              InkWell(
                                onTap: () {
                                  _showDeleteConfirmationDialog(context);
                                },
                                child: Text(
                                  'Delete Account'.tr,
                                  style:
                                      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                ),
                              ),
                              SizedBox(height: 20.ah),
                              InkWell(
                                onTap: () {
                                  Get.to(All_Categories());
                                },
                                child: Text(
                                  'AllCategory'.tr,
                                  style:
                                      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                ),
                              ),
                              SizedBox(height: 20.ah),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.ah),
                      Container(
                        height: 142.ah,
                        width: MediaQuery.of(context).size.width,
                        //width:351.aw ,
                        decoration: BoxDecoration(color: HexColor('#E8E8E8'), borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'NOTIFICATIONS'.tr,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.fSize),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Chat notification'.tr,
                                    style:
                                        TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                  ),
                                  //Image.asset('assets/image/Toggle switch.png',width: 28.aw,height: 17.ah,),
                                  Transform.scale(
                                    scale: 0.4,
                                    child: CupertinoSwitch(
                                      activeColor: Colors.blueGrey,
                                      trackColor: Colors.grey,
                                      onLabelColor: Colors.brown,
                                      offLabelColor: Colors.red,
                                      thumbColor: const Color(0xff001649),
                                      value: controller.mySettingModel!.userSetting.chatNotification,
                                      onChanged: (bool value) {
                                        setState(() {
                                          controller.mySettingModel!.userSetting.chatNotification = value;
                                          controller.mySettingsUpdate();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Feedd'.tr,
                                    style:
                                        TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.fSize),
                                  ),
                                  //Image.asset('assets/image/Toggle switch (1).png',width: 28.aw,height: 17.ah,),
                                  // SizedBox(width: 50.aw),
                                  Transform.scale(
                                    scale: 0.4,
                                    child: CupertinoSwitch(
                                      activeColor: Colors.blueGrey,
                                      trackColor: Colors.grey,
                                      onLabelColor: Colors.brown,
                                      offLabelColor: Colors.red,
                                      thumbColor: const Color(0xff001649),
                                      value: controller.mySettingModel!.userSetting.feedNotification,
                                      onChanged: (bool value) {
                                        setState(() {
                                          controller.mySettingModel!.userSetting.feedNotification = value;
                                          controller.mySettingsUpdate();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60.ah,
                      ),
                      Center(
                        child: CustomPrimaryBtn1(
                          title: 'Logout'.tr,
                          isLoading: false,
                          onTap: () {
                            PrefUtils().logout();
                            Get.delete<ShareController>(force: true);
                            Get.delete<SaveController>(force: true);
                            Get.offAll(() => const LoginScreen());
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Video_Post_Screen()));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // Function to show delete confirmation dialog
  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Dialog is dismissible by tapping on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('confirm_deletion'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are_you_delete_account'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('cancel'.tr),
              onPressed: () {
                // Close the dialog and do nothing
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'.tr),
              onPressed: () async {
                Navigator.of(context).pop();
                bool isDeleted = await ApiRepository.deleteAccount();
                if (true) {
                  Get.offAll(() => const LoginScreen());
                }
              },
            ),
          ],
        );
      },
    );
  }
}
