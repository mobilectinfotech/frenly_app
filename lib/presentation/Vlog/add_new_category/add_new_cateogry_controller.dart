import 'package:flutter/cupertino.dart';
import 'package:frenly_app/Widgets/bottom_sheet_widgets.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';

import '../../all_category/all_cateogry_controller.dart';

class AddNewCategoryController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void onTapCategoryBtn() {
    if (textEditingController.text.trim().isEmpty) {
      return;
    }
    ApiRepository.addCategory(categoryName: textEditingController.text.trim()).then((value) {
      try {
        print("alkdfjalkdjf");
        Get.find<SaveController>().getCategory();
      }  catch (e) {
       print(e);
      }
    });
    Get.back();
  }
}
