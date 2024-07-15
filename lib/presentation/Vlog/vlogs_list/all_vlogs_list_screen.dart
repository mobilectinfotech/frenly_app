import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_vlog_card.dart';
import 'all_vlog_controller.dart';

class AllVlogScreen extends StatefulWidget {
  const AllVlogScreen({super.key});

  @override
  State<AllVlogScreen> createState() => _AllVlogScreenState();
}

class _AllVlogScreenState extends State<AllVlogScreen> {
  AllVlogController controller = Get.put(AllVlogController());

  @override
  Widget build(BuildContext contexttt) {
    return Scaffold(
      appBar: appBarPrimary(title: 'Trendingvlog'.tr),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(strokeWidth: 1,),
            )
          : Padding(
            padding:  EdgeInsets.only(left: 14.0.aw,right: 14.aw),
            child: ListView.builder(
              itemCount: controller.trendingVlogModel.vlogs?.length ?? 0,
              itemBuilder: (context, index) {
                return CustomVlogCard(vlog: controller.trendingVlogModel.vlogs![index],);
              },
            ),
          )),
    );
  }
}

