import 'package:get/get.dart';

import '../controllers/adzan_controller.dart';

class AdzanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdzanController>(
      () => AdzanController(),
    );
  }
}
