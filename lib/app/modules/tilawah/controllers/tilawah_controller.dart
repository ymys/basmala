import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:card_settings/card_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TilawahController extends GetxController {
  //Model
  List<PickerModel> listQuran = <PickerModel>[
    PickerModel('000 Tanpa Tilawah', code: '000'),
  ];
  List<PickerModel> listAdzan = <PickerModel>[
    PickerModel('Tanpa Adzan', code: '0'),
  ];
  List<PickerModel> listEqualizer = <PickerModel>[
    PickerModel('Equalizer NORMAL', code: '0'),
    PickerModel('Equalizer POP', code: '1'),
    PickerModel('Equalizer ROCK', code: '2'),
    PickerModel('Equalizer JAZZ', code: '3'),
    PickerModel('Equalizer CLASSIC', code: '4'),
    PickerModel('Equalizer BASS', code: '5')
  ];
  String _playSurahManual = '001';
  String _playAdzanManual = '1';
  SharedPreferences? _memory;
  late BluetoothController bluetooth;
  final namaTilawah = ['subuh', 'Dzuhur', 'Ashar', 'Maghrib', 'Isya', 'Jumat'];
  final List<TextEditingController> _textEditingControllers = [];
  final enable = false.obs;
  double _volume = 0.0;
  int _equalizer = 0;
  List<int> _initSurah = [1, 1, 1, 1, 1, 1];
  List<int> _initAdzan = [1, 1, 3, 3, 3, 3];
  //
  @override
  void onInit() async {
    super.onInit();
    readJson();
    _memory = await SharedPreferences.getInstance();
    bluetooth = Get.find<BluetoothController>();
    for (int i = 1; i < 10; i++) {
      PickerModel addlist =
          PickerModel('Adzan ' + (i).toString(), code: (i).toString());
      listAdzan.add(addlist);
    }
    for (int i = 0; i < namaTilawah.length; i++) {
      _textEditingControllers.add(TextEditingController());
      _textEditingControllers[i].text =
          await _memory!.getString('namaTilawah' + i.toString()) ?? '10';
    }
    _volume = await _memory!.getDouble('volume') ?? 25.0;
    _equalizer = await _memory!.getInt('equalizer') ?? 0;
    for (int i = 0; i < _initSurah.length; i++) {
      _initSurah[i] = await _memory!.getInt('initsurah' + i.toString()) ?? 0;
    }
    for (int i = 0; i < _initAdzan.length; i++) {
      _initAdzan[i] =
          await _memory!.getInt('initadzan' + i.toString()) ?? (1 + i);
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
  void onClose() {
    _textEditingControllers.forEach((element) {
      element.dispose();
    });
  }

  //Method

  String getNameTilawah(int index) {
    return namaTilawah[index];
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/al_quran.json');
    final data = await json.decode(response)['alquran'];
    for (int i = 0; i < data.length; i++) {
      PickerModel addlist = PickerModel(
        (i + 1).toString().padLeft(3, '0') + ' ' + data[i]['surah'],
        code: data[i]['id'],
      );
      listQuran.add(addlist);
    }
  }

  List<PickerModel> getQuranList() {
    return listQuran;
  }

  List<PickerModel> getAdzanList() {
    return listAdzan;
  }

  List<PickerModel> getPlayManualQuranList() {
    late List<PickerModel> result;
    result = List.from(listQuran);
    result.removeAt(0);
    return result;
  }

  List<PickerModel> getPlayManualAdzanList() {
    late List<PickerModel> result;
    result = List.from(listAdzan);
    result.removeAt(0);
    return result;
  }

  double getVolume() {
    return _volume;
  }

  void setVolume(double value) async {
    if (value.toInt() != _volume.toInt()) {
      await _memory!.setDouble('volume', value);
    }
    _volume = value;
  }

  List<PickerModel> getEqualizerList() {
    return listEqualizer;
  }

//controler for lama tilawah
  TextEditingController getLamaTilawahControler(int index) {
    return _textEditingControllers[index];
  }

  void setLamaTilawah(int value, int index) async {
    await _memory!
        .setString('namaTilawah' + index.toString(), value.toString());
  }

  PickerModel getInitAdzan(int index) {
    late PickerModel result;
    listAdzan.forEach((element) {
      if (element.code == _initAdzan[index].toString()) {
        result = element;
      }
    });
    return result;
  }

  PickerModel getInitSurah(int index) {
    late PickerModel result;
    listQuran.forEach(
      (element) {
        if (element.code == _initSurah[index].toString().padLeft(3, '0')) {
          result = element;
        }
      },
    );
    return result;
  }

  void setInitSurah(PickerModel value, int index) async {
    _initSurah[index] = int.parse(value.code.toString());
    await _memory!.setInt('initsurah' + index.toString(), _initSurah[index]);
  }

  void setInitAdzan(PickerModel value, int index) async {
    _initAdzan[index] = int.parse(value.code.toString());
    await _memory!.setInt('initadzan' + index.toString(), _initAdzan[index]);
  }

  PickerModel getInitEqualizer() {
    late PickerModel result;
    listEqualizer.forEach((element) {
      if (element.code == _equalizer.toString()) {
        result = element;
      }
    });
    return result;
  }

  void setInitEqualizer(PickerModel value) async {
    _equalizer = int.parse(value.code.toString());
    await _memory!.setInt('equalizer', _equalizer);
  }

  void setPlaySurah(PickerModel value) {
    _playSurahManual = value.code.toString().padLeft(3, '0');
    // print('play = ' + _playSurahManual);
  }

  void setPlayAdzan(PickerModel value) {
    _playAdzanManual = value.code.toString();
    // print('play = ' + _playAdzanManual);
  }

  // Method to bluetooth interface

  void playerStop() {
    bluetooth.setting("%W", 'STOP');
  }

  void playerPlay(String name) {
    if (name == 'Surah') {
      bluetooth.setting("%W", 'Q' + _playSurahManual);
    }
    if (name == 'Adzan') {
      bluetooth.setting("%W", 'W' + _playAdzanManual);
    }
  }

  void setting() {
    String vol = _volume.toInt().toString().padLeft(2, '0');
    String equ = _equalizer.toString();
    bluetooth.setting("%W", 'T' + vol + equ);
  }

  void kirim(int index) {
    String surah = _initSurah[index].toString().padLeft(3, '0');
    String lamaTilawah = _textEditingControllers[index].text.padLeft(2, '0');
    String adzan = (_initAdzan[index]).toString();
    String kirim = index.toString() + surah + lamaTilawah + adzan;
    bluetooth.setting("%T", kirim);
    // print('surah = ' + surah);
    // print('lamaTilawah = ' + lamaTilawah);
    // print('adzan = ' + adzan);
    // print(kirim);
  }
}
