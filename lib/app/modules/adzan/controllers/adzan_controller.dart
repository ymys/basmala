import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdzanController extends GetxController {
  SharedPreferences? _memory;
  late BluetoothController bluetooth;

  final nama_adzan = ['Subuh', 'Dzuhur', 'Ashar', "Maghrib", "Isya"];
  final adzan = [4, 4, 4, 4, 4];

  List<TextEditingController> _controller_lama_adzan = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  TextEditingController getTextControler(int index) {
    return _controller_lama_adzan[index];
  }

  @override
  void onInit() async {
    bluetooth = Get.find<BluetoothController>();
    _memory = await SharedPreferences.getInstance();

    for (int i = 0; i < nama_adzan.length; i++) {
      adzan[i] = _memory!.getInt("lama_adzan" + i.toString()) ?? 4;
      _controller_lama_adzan[i].text = adzan[i].toString();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void saveAdzan(int index, int value) async {
    await _memory!.setInt("lama_adzan" + index.toString(), value);
    adzan[index] = value;
  }

  void kirim() {
    // bluetooth.s
    String kirim = '';
    for (int i = 0; i < adzan.length; i++) {
      kirim += adzan[i].toString().padLeft(2, '0');
    }
    bluetooth.setting("%A", kirim);
  }
}
