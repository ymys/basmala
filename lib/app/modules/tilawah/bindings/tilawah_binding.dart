import 'package:get/get.dart';

import '../controllers/tilawah_controller.dart';

class TilawahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TilawahController>(
      () => TilawahController(),
    );
  }
}
