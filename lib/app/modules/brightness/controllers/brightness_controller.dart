import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrightnessController extends GetxController {
  late BluetoothController bluetooth;
  SharedPreferences? _memory;
  List<String> _jam = ["03:00", "09:00", "17:00", "21:00"];
  List<int> _bright = [5, 5, 5, 5];
  final visble = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _memory = await SharedPreferences.getInstance();
    bluetooth = Get.find<BluetoothController>();
  }

  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(milliseconds: 500), () {
      for (int i = 0; i < _bright.length; i++) {
        _bright[i] = _memory!.getInt("brightnes" + i.toString()) ?? 6;
        _jam[i] = _memory!.getString("jam_brightnes" + i.toString()) ?? _jam[i];
      }
      visble.value = true;
    });
  }

  @override
  void onClose() {}
  bool getVisible() {
    return visble.value;
  }

  TimeOfDay strToTime(String s) {
    TimeOfDay _startTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
    return _startTime;
  }

  String timeToStr(TimeOfDay t) {
    String _sTime = t.toString();
    return _sTime.substring(10, 15);
  }

  int getBrightnes(int index) {
    return _bright[index];
  }

  TimeOfDay getBrightnesTime(int index) {
    return strToTime(_jam[index]);
  }

  void setBrightnes(int index, int value) async {
    _bright[index] = value;
    await _memory!.setInt('brightnes' + index.toString(), value);
  }

  void setBrightnesTime(int index, TimeOfDay time) async {
    String hasil = timeToStr(time);
    await _memory!.setString('jam_brightnes' + index.toString(), hasil);
    _jam[index] = hasil;
  }

  void kirim() async {
    String kirim = '';

    for (var i = 0; i < _jam.length; i++) {
      kirim += '0' + _jam[i];
      kirim += _bright[i].toString();
    }
    kirim = kirim.replaceAll(new RegExp(r':'), '');
    // print(kirim);
    //  1234 %B 0300 01 0600 03 1730 01 2100 00
    bluetooth.setting("%B", kirim);
  }
}
