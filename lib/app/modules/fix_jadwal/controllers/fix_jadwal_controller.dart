import 'dart:async';

import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FixJadwalController extends GetxController {
  SharedPreferences? _memory;
  late BluetoothController bluetooth;
  final fix = [
    'Subuh',
    'Dzuhur',
    'Ashar',
    'Maghrib',
    'Isya',
  ];

  final jam = ["04:00", "11:30", "15:00", "18:00", "19:00"].obs;
  final enable = [false, false, false, false, false].obs;
  final visble = [false, false, false, false, false].obs;

  @override
  void onInit() async {
    super.onInit();
    bluetooth = Get.find<BluetoothController>();
    Future.delayed(const Duration(milliseconds: 500), () {
      _init();
    });
    // Timer(Duration(seconds: 1), () {
    //   _init();
    //   print("Yeah, this line is printed after 3 seconds");
    // });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void kirim() {
    String kirim = '';
    for (int i = 0; i < enable.length; i++) {
      kirim += enable[i] == true ? 'Y' : 'N';
    }
    for (int i = 0; i < jam.length; i++) {
      kirim += jam[i];
    }
    kirim = kirim.replaceAll(RegExp(r':'), '');
    // YYNYN 2200 0000 0000 0000 0000
    // 5 9 13 17 21
    // print(kirim);
    bluetooth.setting("%X", kirim);
  }

  Future<void> _init() async {
    _memory = await SharedPreferences.getInstance();
    for (var i = 0; i < fix.length; i++) {
      jam[i] = _memory!.getString("fix_jam" + i.toString()) ?? "00:00";
      enable[i] = _memory!.getBool("fix_enable" + i.toString()) ?? false;
      visble[i] = true;
    }
  }

  TimeOfDay getInitTime(int index) {
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

  void saveEnable(bool value, int index) async {
    await _memory!.setBool('fix_enable' + index.toString(), value);
    enable[index] = value;
  }

  Future<void> saveTime(TimeOfDay t, int index) async {
    await _memory!
        .setString('fix_jam' + index.toString(), timeToStr(t))
        .then((value) {
      jam[index] = timeToStr(t);
    });
  }
}
