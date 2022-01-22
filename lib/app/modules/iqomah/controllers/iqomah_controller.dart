import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IqomahController extends GetxController {
  SharedPreferences? _memory;
  late BluetoothController bluetooth;
  final iqomah = ['Subuh', 'Dzuhur', 'Ashar', "Maghrib", "Isya", "Jumat"];
  final lama_iqomah = ["00", "00", "00", "00", "00", "00"].obs;
  final text_iqomah = [" ", " ", " ", " ", " ", " "].obs;
  final lama_sholat = ["00", "00", "00", "00", "00", "00"].obs;
  List<TextEditingController> _controller_lama_iqomah = [];
  List<TextEditingController> _controller_lama_sholat = [];
  List<TextEditingController> _controller_text_iqomah = [];

  TextEditingController getIqomahControler(int index) {
    return _controller_lama_iqomah[index];
  }

  TextEditingController getSholatControler(int index) {
    return _controller_lama_sholat[index];
  }

  TextEditingController getTextControler(int index) {
    return _controller_text_iqomah[index];
  }

  int getIqomah(int index) {
    return int.parse(lama_iqomah[index]);
  }

  int getSholat(int index) {
    return int.parse(lama_sholat[index]);
  }

  String getText(int index) {
    return text_iqomah[index];
  }

  void setIqomah(int index, int value) async {
    await _memory!
        .setString('lama_iqomah' + index.toString(), value.toString());
    lama_iqomah[index] = value.toString();
  }

  void setSholat(int index, int value) async {
    await _memory!
        .setString('lama_sholat' + index.toString(), value.toString());
    lama_sholat[index] = value.toString();
  }

  void setText(int index, String value) async {
    await _memory!.setString('text_iqomah' + index.toString(), value);
    text_iqomah[index] = value;
  }

  void kirim(int index) {
    // 1234 %I N 0 1010 Iqomah Subuh // n DAN y ADALAH ENABLE IQOMAH
    // 1234 %I N 1 1010 Iqomah Dzuhur... //IQOMAH_SHOLAT
    // 1234 %I N 2 1010 Iqomah Ashar...
    // 1234 %I N 3 1010 Iqomah Maghrib...

    String kirim = 'N';
    kirim += index.toString();
    kirim += lama_iqomah[index].padLeft(2, '0');
    kirim += lama_sholat[index].padLeft(2, '0');
    kirim += text_iqomah[index];
    bluetooth.setting("%I", kirim + "\n");
  }

  init() async {
    _memory = await SharedPreferences.getInstance();
    for (var i = 0; i < 6; i++) {
      lama_iqomah[i] = _memory!.getString("lama_iqomah" + i.toString()) ?? "12";
      lama_sholat[i] = _memory!.getString("lama_sholat" + i.toString()) ?? "05";
      text_iqomah[i] = _memory!.getString("text_iqomah" + i.toString()) ??
          "Waktu Sholat " + iqomah[i];

      if (lama_iqomah[i] == '') {
        lama_iqomah[i] = '00';
      }
      if (lama_sholat[i] == '') {
        lama_sholat[i] = '00';
      }
      _controller_lama_iqomah[i].text = lama_iqomah[i];
      _controller_lama_sholat[i].text = lama_sholat[i];
      _controller_text_iqomah[i].text = text_iqomah[i];
    }
  }

  @override
  void onInit() {
    super.onInit();
    bluetooth = Get.find<BluetoothController>();
    for (int i = 0; i < 6; i++) {
      _controller_lama_iqomah.add(TextEditingController());
      _controller_text_iqomah.add(TextEditingController());
      _controller_lama_sholat.add(TextEditingController());
    }
    init();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
