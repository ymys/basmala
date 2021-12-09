import 'package:get/get.dart';

import '../controllers/fix_jadwal_controller.dart';

class FixJadwalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FixJadwalController>(
      () => FixJadwalController(),
    );
  }
}
