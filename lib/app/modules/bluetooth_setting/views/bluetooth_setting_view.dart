import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bluetooth_setting_controller.dart';

class BluetoothSettingView extends GetView<BluetoothSettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Perangkat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Obx(() => ListView(children: controller.getList())),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 30),
            child: ElevatedButton(
              onPressed: () async {
                controller.openBluetoothSetting();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.amber[800],
                minimumSize: Size.fromHeight(50),
              ),
              child: Text(
                'Buka Pengaturan Bluetooth',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
