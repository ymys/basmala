import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/brightness_controller.dart';

class BrightnessView extends GetView<BrightnessController> {
  CardSettingsNumberPicker _kecerahan(int index) {
    return CardSettingsNumberPicker(
      visible: controller.getVisible(),
      label: 'Level',
      initialValue: controller.getBrightnes(index),
      min: 0,
      max: 7,
      icon: Icon(Icons.wb_sunny_outlined),
      stepInterval: 1,
      validator: (value) {},
      onChanged: (value) {
        controller.setBrightnes(index, value!);
      },
    );
  }

  CardSettingsTimePicker _TimePicker(int index) {
    return CardSettingsTimePicker(
      visible: controller.getVisible(),
      enabled: true,
      icon: Icon(Icons.access_time),
      label: 'Waktu ',
      initialValue: controller.getBrightnesTime(index),
      onChanged: (value) {
        controller.setBrightnesTime(index, value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Keecerahan '),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => CardSettings.sectioned(
                    showMaterialonIOS: false,
                    labelWidth: 150,
                    contentAlign: TextAlign.right,
                    cardless: false,
                    children: <CardSettingsSection>[
                      CardSettingsSection(
                        header: CardSettingsHeader(
                          label: 'Kecerahan  ' + (index + 1).toString(),
                          color: Colors.blueAccent,
                        ),
                        children: <CardSettingsWidget>[
                          _TimePicker(index),
                          _kecerahan(index),
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
