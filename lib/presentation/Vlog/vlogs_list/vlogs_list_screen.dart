import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_vlog_card.dart';
import 'vlogs_list_controller.dart';

class VlogsListScreen extends StatefulWidget {
  const VlogsListScreen({super.key});

  @override
  State<VlogsListScreen> createState() => _VlogsListScreenState();
}

class _VlogsListScreenState extends State<VlogsListScreen> {
  VlogsListController controller = Get.put(VlogsListController());

  @override
  Widget build(BuildContext contexttt) {
    return Scaffold(
      appBar: appBarPrimary(title: 'Vlogs'.tr),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(strokeWidth: 1,),
            )
          : Padding(
            padding:  EdgeInsets.only(left: 14.0.aw,right: 14.aw,top: 15.ah),
            child: ListView.builder(
              itemCount: controller.vlogListModel.vlogs?.length ?? 0,
              itemBuilder: (context, index) {
                return CustomVlogCard(vlog: controller.vlogListModel.vlogs![index],);
              },
            ),
          )),
    );
  }
}

