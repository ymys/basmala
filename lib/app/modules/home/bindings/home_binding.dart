import 'package:get/get.dart';

import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BluetoothController>(
      () => BluetoothController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
