

import 'package:frenly_app/core/utils/pref_utils.dart';

import '../../data/data_sources/remote/api_client.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(ApiClient());
   // Connectivity connectivity = Connectivity();
  //  Get.put(NetworkInfo(connectivity));
  }
}
