import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RunningTextController extends GetxController {
  SharedPreferences? _memory;
  late BluetoothController bluetooth;
  TextEditingController textControler = TextEditingController();
  String text = ' ';
  final _default = """ASSALAMUALAIKUM WAROHMATULLAHI WABAROKATUH
AHLAN WA SAHLAN BIKHUDZURIKUM
MOHON MENONAKTIFKAN HP KETIKA DI DALAM MASJID
SELAMAT MENJALANKAN IBADAH SHOLAT
SHOLAT BERJAMAAH LEBIH TINGGI 27 DERAJAT DIBANDING SHOLAT SENDIRI
LURUS DAN RAPATKAN SHOF, SESUNGGUHNYA LURUS DAN RAPATNYA SHOF MERUPAKAN KESEMPURNAAN SHOLAT BERJAMAAH
DILARANG BERBICARA KETIKA KHOTIB SEDANG BERKHOTBAH
WASSALAMUALAIKUM WAROHMATULLAHI WABAROKATUH""";
  @override
  void onInit() async {
    super.onInit();
    _memory = await SharedPreferences.getInstance();
    text = _memory!.getString("text") ?? _default;
    textControler.text = text;
    bluetooth = Get.find<BluetoothController>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void saveText(String t) async {
    await _memory!.setString('text', t);
    text = t;
  }

  void kirim() {
    bluetooth.setting("%S", text + '\n');
  }
}
