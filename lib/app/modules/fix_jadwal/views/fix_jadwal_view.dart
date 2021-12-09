import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/fix_jadwal_controller.dart';

class FixJadwalView extends GetView<FixJadwalController> {
  CardSettingsSwitch _switchTile(int index, bool enable) {
    return CardSettingsSwitch(
      visible: controller.visble[index],
      initialValue: enable,
      trueLabel: 'Ya',
      falseLabel: 'Tidak',
      label: 'Fix ' + controller.fix[index],
      onChanged: (value) {
        controller.saveEnable(value, index);
      },
    );
  }

  CardSettingsTimePicker _TimePicker(int index, bool enable) {
    return CardSettingsTimePicker(
      visible: enable,
      enabled: true,
      icon: Icon(Icons.access_time),
      label: 'Waktu ' + controller.fix[index],
      initialValue: controller.getInitTime(index),
      onChanged: (value) async {
        await controller.saveTime(value, index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Fix Jadwal'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              itemCount: controller.fix.length,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => CardSettings.sectioned(
                    showMaterialonIOS: true,
                    labelWidth: 150,
                    contentAlign: TextAlign.right,
                    cardless: false,
                    children: <CardSettingsSection>[
                      CardSettingsSection(
                        header: CardSettingsHeader(
                          label: controller.fix[index],
                          color: Colors.blueAccent,
                        ),
                        children: <CardSettingsWidget>[
                          _switchTile(index, controller.enable[index]),
                          _TimePicker(index, controller.enable[index])
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 30),
            child: ElevatedButton(
              onPressed: () {
                controller.kirim();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size.fromHeight(50),
              ),
              child: Text(
                'Kirim',
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
