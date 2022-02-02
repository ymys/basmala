import 'package:get/get.dart';

import 'package:basmalla/app/modules/adzan/bindings/adzan_binding.dart';
import 'package:basmalla/app/modules/adzan/views/adzan_view.dart';
import 'package:basmalla/app/modules/bluetooth_setting/bindings/bluetooth_setting_binding.dart';
import 'package:basmalla/app/modules/bluetooth_setting/views/bluetooth_setting_view.dart';
import 'package:basmalla/app/modules/brightness/bindings/brightness_binding.dart';
import 'package:basmalla/app/modules/brightness/views/brightness_view.dart';
import 'package:basmalla/app/modules/fix_jadwal/bindings/fix_jadwal_binding.dart';
import 'package:basmalla/app/modules/fix_jadwal/views/fix_jadwal_view.dart';
import 'package:basmalla/app/modules/home/bindings/home_binding.dart';
import 'package:basmalla/app/modules/home/views/home_view.dart';
import 'package:basmalla/app/modules/iqomah/bindings/iqomah_binding.dart';
import 'package:basmalla/app/modules/iqomah/views/iqomah_view.dart';
import 'package:basmalla/app/modules/koreksi/bindings/koreksi_binding.dart';
import 'package:basmalla/app/modules/koreksi/views/koreksi_view.dart';
import 'package:basmalla/app/modules/lokasi/bindings/lokasi_binding.dart';
import 'package:basmalla/app/modules/lokasi/views/lokasi_view.dart';
import 'package:basmalla/app/modules/pengaturan/bindings/pengaturan_binding.dart';
import 'package:basmalla/app/modules/pengaturan/views/pengaturan_view.dart';
import 'package:basmalla/app/modules/running_text/bindings/running_text_binding.dart';
import 'package:basmalla/app/modules/running_text/views/running_text_view.dart';
import 'package:basmalla/app/modules/tilawah/bindings/tilawah_binding.dart';
import 'package:basmalla/app/modules/tilawah/views/tilawah_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOKASI,
      page: () => LokasiView(),
      binding: LokasiBinding(),
    ),
    GetPage(
      name: _Paths.BLUETOOTH_SETTING,
      page: () => BluetoothSettingView(),
      binding: BluetoothSettingBinding(),
    ),
    GetPage(
      name: _Paths.IQOMAH,
      page: () => IqomahView(),
      binding: IqomahBinding(),
    ),
    GetPage(
      name: _Paths.BRIGHTNESS,
      page: () => BrightnessView(),
      binding: BrightnessBinding(),
    ),
    GetPage(
      name: _Paths.FIX_JADWAL,
      page: () => FixJadwalView(),
      binding: FixJadwalBinding(),
    ),
    GetPage(
      name: _Paths.RUNNING_TEXT,
      page: () => RunningTextView(),
      binding: RunningTextBinding(),
    ),
    GetPage(
      name: _Paths.ADZAN,
      page: () => AdzanView(),
      binding: AdzanBinding(),
    ),
    GetPage(
      name: _Paths.KOREKSI,
      page: () => KoreksiView(),
      binding: KoreksiBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN,
      page: () => PengaturanView(),
      binding: PengaturanBinding(),
    ),
    GetPage(
      name: _Paths.TILAWAH,
      page: () => TilawahView(),
      binding: TilawahBinding(),
    ),
  ];
}
