import 'package:get/get.dart';
import 'bluetooth_controller.dart';

class HomeController extends GetxController {
  late BluetoothController bluetooth;
  @override
  void onInit() {
    super.onInit();
    bluetooth = Get.find<BluetoothController>();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    bluetooth.dispose();
  }
}
