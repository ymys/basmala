import 'package:flutter/src/material/time.dart';
import 'package:get/get.dart';
import 'bluetooth_controller.dart';

class HomeController extends GetxController {
  late BluetoothController bluetooth;

  final indexNavBar = 0.obs;
  late DateTime manualYear;
  late TimeOfDay manualTime;
  @override
  void onInit() {
    super.onInit();
    bluetooth = Get.find<BluetoothController>();
    manualYear = DateTime.now();
    manualTime = TimeOfDay.now();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    bluetooth.dispose();
  }

  void setIndexNavBar(int value) {
    indexNavBar.value = value;
  }

  int getIndexNavBar() {
    return indexNavBar.value;
  }

  void setDateManuaL(DateTime value) {
    manualYear = value;
  }

  void setTimeManual(TimeOfDay value) {
    manualTime = value;
  }

  void kirim(int index) async {
    if (index == 0) {
      //('kkmmssddMMyyyy')
      String kirim = "";
      kirim = '00';
      kirim += manualTime.minute.toString().padLeft(2, '0');
      kirim += manualTime.hour.toString().padLeft(2, '0');
      kirim += manualYear.day.toString().padLeft(2, '0');
      kirim += manualYear.month.toString().padLeft(2, '0');
      kirim += (manualYear.year - 2000).toString();
      await bluetooth.setting("%J", kirim);
    }
  }
}
