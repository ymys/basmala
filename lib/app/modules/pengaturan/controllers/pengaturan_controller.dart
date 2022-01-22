import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/time.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaturanController extends GetxController {
  final List<String> titleLabel = <String>[
    'Power Management',
    'Buzer Alarm',
    'Set Waktu Manual ',
  ];

  final jam = ["03:00", "22:00"].obs;
  final visble = [false, false].obs;

  SharedPreferences? _memory;
  late BluetoothController bluetooth;
  TextEditingController buzer_controller = TextEditingController();
  late DateTime manualYear;
  late TimeOfDay manualTime;
  int buzer = 10;
  @override
  void onInit() async {
    super.onInit();
    bluetooth = Get.find<BluetoothController>();
    manualYear = DateTime.now();
    manualTime = TimeOfDay.now();
    _memory = await SharedPreferences.getInstance();
    buzer = _memory!.getInt("buzer") ?? 10;
    buzer_controller.text = buzer.toString();

    Future.delayed(const Duration(milliseconds: 100), () {
      jam[0] = _memory!.getString("powerOn") ?? "03:00";
      jam[1] = _memory!.getString("powerOff") ?? "22:00";
      visble[0] = true;
      visble[1] = true;
    });
  }

  TimeOfDay getInitPower(int index) {
    return strToTime(jam[index]);
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

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

  void setDateManuaL(DateTime value) {
    manualYear = value;
  }

  void setTimeManual(TimeOfDay value) {
    manualTime = value;
  }

  setBuzer(int value) async {
    await _memory!.setInt("buzer", value);
    buzer = value;
  }

  int getBuzer() {
    return buzer;
  }

  TextEditingController getBuzerControler() {
    return buzer_controller;
  }

  void kirimBuzer() async {
    String send = buzer.toString().padLeft(2, '0');
    await bluetooth.setting("%Z", send);
  }

  void kirimPower() async {
    String kirim = '';
    for (int i = 0; i < jam.length; i++) {
      kirim += jam[i];
    }
    kirim = kirim.replaceAll(RegExp(r':'), '');
    await bluetooth.setting("%Y", kirim);
  }

  bool getVisible(int index) {
    return visble[index];
  }

  void setPower(int index, TimeOfDay value) async {
    jam[index] = timeToStr(value);
    if (index == 0) {
      await _memory!.setString("powerOn", timeToStr(value));
    }
    if (index == 1) {
      await _memory!.setString("powerOff", timeToStr(value));
    }
  }

  resetPabrik() async {
    await bluetooth.setting("%R", '000');
  }
}
