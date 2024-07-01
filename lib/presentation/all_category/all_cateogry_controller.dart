import 'package:frenly_app/data/models/cateogry_model.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';

class AllCategoryController extends GetxController {
  Rxn<CategoryModel> categoryModel = Rxn();
  RxList<Category> selectedCategory = RxList<Category>();

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  void getCategory() {
    ApiRepository.getCategories().then((value) {
      categoryModel.value = value;
    });
  }

  void onTapDeleteButton() {
    if (selectedCategory.isNotEmpty) {
      selectedCategory.forEach((element) {
        try {
          ApiRepository.deleteCategory(categoryId: element.id!).then((value) {
            getCategory();
          });
        } catch (e) {}
      });
    }
  }
}
