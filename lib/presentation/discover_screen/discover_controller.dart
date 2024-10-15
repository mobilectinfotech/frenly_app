import 'package:frenly_app/data/models/DiscoverUsersModel.dart';
import 'package:get/get.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';


class DiscoverController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    discoveryUsers();
  }

  var discoverUsersModelData =DiscoverUsersModel().obs;
  DiscoverUsersModel get  discoverUsersModel => discoverUsersModelData.value;
  RxBool isLoading = false.obs;

  Future<void> discoveryUsers() async {
    isLoading.value =true;
    try{
      final response = await ApiRepository.discoverUser();
      discoverUsersModelData(response);
      discoverUsersModelData.refresh();
    // ignore: empty_catches
    }catch(e){

    }
    isLoading.value =false;
  }








}