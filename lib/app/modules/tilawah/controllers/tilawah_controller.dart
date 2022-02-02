import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:card_settings/card_settings.dart';

class TilawahController extends GetxController {
  List<PickerModel> listQuran = <PickerModel>[
    PickerModel('001 Surah Al-Fatihah', code: '000'),
  ];
  List<PickerModel> listAdzan = <PickerModel>[
    PickerModel('Adzan 1', code: '200'),
  ];
  List<PickerModel> listEqualizer = <PickerModel>[
    PickerModel('Equalizer NORMAL', code: '00'),
    PickerModel('Equalizer POP', code: '01'),
    PickerModel('Equalizer ROCK', code: '02'),
    PickerModel('Equalizer JAZZ', code: '03'),
    PickerModel('Equalizer CLASSIC', code: '04'),
    PickerModel('Equalizer BASS', code: '05'),
  ];

  final namaTilawah = ['subuh', 'Dzuhur', 'Ashar', 'Maghrib', 'Isya', 'jumat'];
  final enable = false.obs;
  final adzan = ['Adzan 1', 'Adzan 2', 'Adzan 3', 'Adzan 4', 'Adzan 5'];
  final volume = 0.0.obs;
  String getNameTilawah(int index) {
    return namaTilawah[index];
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/al_quran.json');
    final data = await json.decode(response)['alquran'];
    for (int i = 1; i < data.length; i++) {
      PickerModel addlist = PickerModel(
        (i + 1).toString().padLeft(3, '0') + ' ' + data[i]['surah'],
        code: data[i]['id'],
      );
      listQuran.add(addlist);
    }
  }

  @override
  void onInit() {
    super.onInit();
    readJson();
    for (var i = 1; i < 10; i++) {
      PickerModel addlist = PickerModel('Adzan' + ' ' + (i + 1).toString(),
          code: (i + 200).toString());
      listAdzan.add(addlist);
    }
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(milliseconds: 500), () {
      enable.value = true;
    });
  }

  @override
  void onClose() {}

  void setIndex(int index) {}

  List<PickerModel> getQuranList() {
    return listQuran;
  }

  List<PickerModel> getAdzanList() {
    return listAdzan;
  }

  bool getEnable() {
    return enable.value;
  }

  double getVolume() {
    return volume.value;
  }

  void setVolume(double value) {
    volume.value = value;
  }

  List<PickerModel> getEqualizerList() {
    return listEqualizer;
  }
}
