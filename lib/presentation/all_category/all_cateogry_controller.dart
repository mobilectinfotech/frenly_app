import 'package:frenly_app/data/models/cateogry_model.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';

import '../../Widgets/bottom_sheet_widgets.dart';

class AllCategoryController extends GetxController {
   Rxn<CategoryModel> categoryModel = Rxn();
   RxList<Category> selectedCategory = RxList<Category>();

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }
  //
  void getCategory() {
      categoryModel = Get.find<SaveController>().cateogoryModel;
  }

  void onTapDeleteButton() {
    if (selectedCategory.isNotEmpty) {
      selectedCategory.forEach((element) {
        try {
          ApiRepository.deleteCategory(categoryId: element.id!).then((value) async {
            Get.find<SaveController>().getCategory();
            categoryModel = Get.find<SaveController>().cateogoryModel;
            // getCategory();
          });
        } catch (e) {}
      });
    }
  }
}
