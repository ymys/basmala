import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as peta;
import 'package:location/location.dart';

class LokasiController extends GetxController {
  double _latitude = 0;
  double _longitude = 0;
  String _alamat = "";
  String _zona = '7';
  late BluetoothController bluetooth;
  // Memori _eprom = new Memori();
  List<TextEditingController> _textEditingController = [];

  Future<void> init() async {
    for (int i = 0; i < 3; i++) {
      _textEditingController.add(TextEditingController());
    }
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
        // setBusy(false);
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // setBusy(false);
        return;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    bluetooth = Get.find<BluetoothController>();
    init();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  Future<void> loadGPS() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    _latitude = _locationData.latitude!;
    _longitude = _locationData.longitude!;

    List<peta.Placemark> placemarks =
        await peta.placemarkFromCoordinates(_latitude, _longitude);
    _alamat = placemarks[0].name!;
    _alamat += ', ';
    _alamat += placemarks[0].subLocality!;
    _alamat += ', ';
    _alamat += placemarks[0].locality!;
    _alamat += ', ';
    _alamat += placemarks[0].subAdministrativeArea!;
    _alamat += ', ';
    _alamat += placemarks[0].administrativeArea!;
    _alamat += ', ';
    _alamat += placemarks[0].country!;
    _alamat += '\nPos:';
    _alamat += placemarks[0].postalCode!;

    _textEditingController[0].text = _latitude.toString();
    _textEditingController[1].text = _longitude.toString();
    _textEditingController[2].text = _alamat;
  }

  void kirim() {
    // EN 110 39 007 82 01187+00 //LU
    // ES 110 39 007 82 01187+00 //ls
    // parameter.set_kota_bjr=((input_serial[2]-'0')*100)+((input_serial[3]-'0')*10)+(input_serial[4]-'0')+((input_serial[5]-'0')*0.1)+((input_serial[6]-'0')*0.01)  ;
    // if(input_serial[1] == 'N') parameter.set_kota_lnt =((input_serial[7]-'0')*100)+((input_serial[8]-'0')*10)+(input_serial[9]-'0')+((input_serial[10]-'0')*0.1)+((input_serial[11]-'0')*0.01)  ;
    // if(input_serial[1] == 'S')parameter.set_kota_lnt =0-(((input_serial[7]-'0')*100)+((input_serial[8]-'0')*10)+(input_serial[9]-'0')+((input_serial[10]-'0')*0.1)+((input_serial[11]-'0')*0.01))  ;
    // parameter.set_kota_gmt=input_serial[16]-'0' ;
    //sample
    //ES112750072600017+00
    //ES11021 00779 0000 7+00
    //bujur 112,75
    //lintang 7,26
    //ketinggian 0
    //gmt+00
    String kirim = '';
    // if (_latitude > 0) {
    //   kirim = 'EN'; //positif
    // } else {
    //   kirim = 'ES'; //negative
    // }
    if (_textEditingController[1].text.isEmpty &&
        _textEditingController[2].text.isEmpty) {
      Get.defaultDialog(
        title: 'Error',
        titleStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        middleTextStyle: TextStyle(color: Colors.black),
        radius: 3,
        contentPadding: EdgeInsets.all(15),
        content: Text('Lintng Bujur tidak boleh kosong!'),
      );
    } else {
      double? lat = double.tryParse(_textEditingController[0].text);
      if (lat!.isNegative) {
        kirim = 'ES'; //negative
      } else {
        kirim = 'EN'; //positif
      }
      double? long = double.tryParse(_textEditingController[1].text);
      kirim += long!.toStringAsFixed(2);
      lat = lat.abs();
      kirim += lat.toStringAsFixed(2).padLeft(6, '0');
      kirim += '0000';
      kirim += _zona + '+00';
      kirim = kirim.replaceAll(".", "");
      // print(kirim);
      bluetooth.setting("%K", kirim);
    }
  }

  bool visble() {
    return true;
  }

  void saveZona(int i) {}

  List<PickerModel> data_zona = <PickerModel>[
    PickerModel('GMT+7', code: '7'),
    PickerModel('GMT+8', code: '8'),
    PickerModel('GMT+9', code: '9'),
  ];

  final _label = [
    'Lintang',
    'Bujur',
  ];
  String getLabel(int index) {
    return _label[index];
  }

  getTextControler(index) {
    return _textEditingController[index];
  }

  void setZona(String value) {
    _zona = value;
    // print(value);
  }
}
