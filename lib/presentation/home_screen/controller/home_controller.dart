

import 'package:frenly_app/core/utils/pref_utils.dart';
import 'package:frenly_app/data/models/HomePageModel.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/auth/my_profile_view/my_profile_controller.dart';

import 'package:get/get.dart';


class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    get();
    ApiRepository.checkIn();
    homepage();

  }

  RxString city = "Not Found".obs;
  RxString county = "".obs;

  void get() async {
    city.value = PrefUtils().getUserCity();
    county.value = PrefUtils().getUserCountry();
  }


  var homeData = HomeModel().obs;
  HomeModel get homeModel => homeData.value;

   RxBool isLoading = false.obs;

  Future<void> homepage() async {
    isLoading.value =true;
    try{

     final response   = await ApiRepository.homePage();
     homeData(response);
     homeData.refresh();
    }catch(e){
      print("edsffsf${e.toString()}");

    }
    isLoading.value =false;
  }









}
