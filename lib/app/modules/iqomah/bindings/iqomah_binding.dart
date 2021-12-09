import 'package:get/get.dart';

import '../controllers/iqomah_controller.dart';

class IqomahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IqomahController>(
      () => IqomahController(),
    );
  }
}
