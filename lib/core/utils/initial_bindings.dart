import 'package:frenly_app/core/utils/pref_utils.dart';
import 'package:get/get.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
   // Get.put(ApiClient());
  }
}
