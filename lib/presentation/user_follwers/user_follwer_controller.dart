// import 'package:get/get.dart';
// import '../../../data/repositories/api_repository.dart';
// import 'UserFollowersModel.dart';
//
// class UserFollowersController extends GetxController{
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//   }
//
//   UserFollowersModel followersModel =UserFollowersModel();
//   RxBool isLoading = false.obs;
//
//   Future<void> userFollowers({required String userId}) async {
//     isLoading.value =true;
//     try{
//       followersModel= await ApiRepository.userFollowers(userId: userId);
//
//     }catch(e){
//       print("catch${e.toString()}");
//
//     }
//     isLoading.value =false;
//   }
//
//
//
//
//
//
//
//
// }