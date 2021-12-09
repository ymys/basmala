import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KoreksiController extends GetxController {
  SharedPreferences? _memory;
  late BluetoothController bluetooth;
  final _koreksi = [0, 0, 0, 0, 0].obs;
  final visble = [false, false, false, false, false].obs;
  final nama_koreksi = [
    'Subuh',
    'Dzuhur',
    'Ashar',
    'Maghrib',
    'Isya',
  ];

  void init() async {
    _memory = await SharedPreferences.getInstance();

    Future.delayed(const Duration(milliseconds: 500), () {
      for (int i = 0; i < nama_koreksi.length; i++) {
        _koreksi[i] = _memory!.getInt("koreksi" + i.toString()) ?? 0;
        visble[i] = true;
      }
    });
  }

  @override
  void onInit() {
    init();
    super.onInit();
    bluetooth = Get.find<BluetoothController>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void kirim() {
    String kirim = '';

    for (int i = 0; i < _koreksi.length; i++) {
      _koreksi[i] <= 0
          ? kirim += _koreksi[i].abs().toString().padLeft(2, '0')
          : kirim += (_koreksi[i] + 10).toString().padLeft(2, '0');
    }
    // 1234 %F 19 02 01 03 05 //1= TAMBAH & 0=KURANG
    bluetooth.setting("%F", kirim);
  }

  void saveKoreksi(int index, int value) async {
    _koreksi[index] = value;
    await _memory!.setInt('koreksi' + index.toString(), value);
    // print(value);
  }

  int getInitKoreksi(int index) {
    return _koreksi[index];
  }
}
