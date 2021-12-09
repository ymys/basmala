import 'package:get/get.dart';

import '../controllers/running_text_controller.dart';

class RunningTextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RunningTextController>(
      () => RunningTextController(),
    );
  }
}
