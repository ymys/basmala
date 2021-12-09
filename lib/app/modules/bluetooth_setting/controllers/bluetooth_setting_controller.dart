import 'dart:async';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'BluetoothDeviceListEntry.dart';

enum _DeviceAvailability {
  // no,
  maybe,
  yes,
}

class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class BluetoothSettingController extends GetxController {
  final checkAvailability = false.obs;
  final devices = List<_DeviceWithAvailability>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      reload();
    });
  }

  @override
  void onReady() {
    super.onReady();
    reload();
    // FlutterBluetoothSerial.instance.
  }

  @override
  void onClose() {}

  void reload() {
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      devices.value = bondedDevices
          .map(
            (device) => _DeviceWithAvailability(
              device,
              checkAvailability.value
                  ? _DeviceAvailability.maybe
                  : _DeviceAvailability.yes,
            ),
          )
          .toList();
    });
  }

  List<BluetoothDeviceListEntry> getList() {
    return devices
        .map((_device) => BluetoothDeviceListEntry(
              device: _device.device,
              rssi: _device.rssi,
              enabled: _device.availability == _DeviceAvailability.yes,
              onTap: () async {
                if (_device.device.isConnected) {
                  await this.startDisConnect(_device.device.address);
                }
                // bool _result = await this.findConnection();
                // if (_result == true) {
                //   this.disConnect();
                // }
                Get.back(result: _device.device);
              },
            ))
        .toList();
  }

  void openBluetoothSetting() {
    FlutterBluetoothSerial.instance.openSettings();
  }

  Future startDisConnect(String address) async {
    try {
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(address);
      // print('Connected to the device');
      connection.dispose();
    } catch (exception) {
      // print('Cannot connect, exception occured');
      this.reload();
    }
  }

  Future<bool> findConnection() async {
    bool result = false;
    List<BluetoothDevice> _conn =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    _conn.forEach((element) {
      if (element.isConnected == true) {
        result = true;
      }
    });
    return result;
  }

  void disConnect() async {
    List<BluetoothDevice> _conn =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    _conn.forEach((element) {
      if (element.isConnected == true) {
        startDisConnect(element.address);
      }
    });
  }
}
