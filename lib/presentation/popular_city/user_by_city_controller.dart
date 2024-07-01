import 'package:frenly_app/data/models/DiscoverUsersModel.dart';
import 'package:get/get.dart';
import '../../../data/repositories/api_repository.dart';
import '../../data/models/UserByCityModel.dart';

class UserByCityController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  GetUserByCityModel getUserByCityModel =GetUserByCityModel() ;
  RxBool isLoading = false.obs;

  Future<void> getUserByCity({required String city}) async {
    isLoading.value =true;
    try{
      getUserByCityModel = await ApiRepository.getUserByCity(city: city);
    }catch(e){
      print("catch${e.toString()}");

    }
    isLoading.value =false;
  }




}