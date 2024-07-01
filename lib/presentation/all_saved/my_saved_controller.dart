import 'package:frenly_app/data/models/cateogry_model.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';

import 'MySavedBlogs.dart';
import 'MySavedPosts.dart';
import 'MySavedVlogs.dart';

class SavedController extends GetxController {
  Rxn<CategoryModel> categoryModel = Rxn<CategoryModel>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ApiRepository.getCategories().then((value) {
      print("line 18");
      categoryModel.value = value;
    });
  }

  // GetUserByIdModel getUserByIdModel = GetUserByIdModel();

  RxBool isLoading = false.obs;

  RxList<MySavedBlog> filteredSaveBlogModel = RxList();
  Rxn<MySavedBlogs> saveBlogModel = Rxn();
  RxBool isLoadingBlog = false.obs;

  getSavedBlog() async {
    isLoadingBlog.value = true;
    saveBlogModel.value = await ApiRepository.savedBlog();
    filteredSaveBlogModel.clear();
    saveBlogModel.value?.mySavedBlogs?.forEach((element) {
      filteredSaveBlogModel.add(element);
    });
    isLoadingBlog.value = false;
  }

  RxBool isLoadingPosts = false.obs;
  RxList<MySavedPost> filteredMySavedPosts = RxList();
  Rxn<MySavedPosts> mySavedPosts = Rxn();

  getSavedPosts() async {
    isLoadingPosts.value = true;
    mySavedPosts.value = await ApiRepository.savePosts();
    filteredMySavedPosts.clear();
    mySavedPosts.value?.mySavedPosts?.forEach((element) {
      filteredMySavedPosts.add(element);
    });
    isLoadingPosts.value = false;
  }

  RxBool isLoadingVlogs = false.obs;
  Rxn<MySavedVlogs> mySavedVlogs = Rxn();
  RxList<MySavedVlog> filteredMySavedVlogs = RxList();

  getSavedVlogs() async {
    isLoadingVlogs.value = true;
    mySavedVlogs.value = await ApiRepository.saveVlogs();
    filteredMySavedVlogs.clear();
    mySavedVlogs.value?.mySavedVlogs?.forEach((element) {
      filteredMySavedVlogs.add(element);
    });

    isLoadingVlogs.value = false;
  }
}
