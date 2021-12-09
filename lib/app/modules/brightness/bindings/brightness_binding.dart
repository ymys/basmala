import 'package:get/get.dart';

import '../controllers/brightness_controller.dart';

class BrightnessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrightnessController>(
      () => BrightnessController(),
    );
  }
}
