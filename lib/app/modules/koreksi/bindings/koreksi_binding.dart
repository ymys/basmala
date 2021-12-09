import 'package:get/get.dart';

import '../controllers/koreksi_controller.dart';

class KoreksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KoreksiController>(
      () => KoreksiController(),
    );
  }
}
