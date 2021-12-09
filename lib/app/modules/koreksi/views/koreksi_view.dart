import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/koreksi_controller.dart';

class KoreksiView extends GetView<KoreksiController> {
  CardSettingsNumberPicker _koreksi(int index) {
    return CardSettingsNumberPicker(
      visible: controller.visble[index],
      label: 'Koreksi ' + controller.nama_koreksi[index],
      initialValue: controller.getInitKoreksi(index),
      min: -9,
      max: 9,
      stepInterval: 1,
      validator: (value) {},
      onChanged: (value) {
        controller.saveKoreksi(index, value!);
      },
    );
  }

  // CardSettingsButton _kirim() {
  //   return CardSettingsButton(
  //     bottomSpacing: 12,
  //     label: 'Kirim',
  //     onPressed: () {
  //       controller.kirim();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Koreksi '),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => CardSettings.sectioned(
                showMaterialonIOS: false,
                labelWidth: 150,
                contentAlign: TextAlign.right,
                cardless: false,
                children: <CardSettingsSection>[
                  CardSettingsSection(
                    header: CardSettingsHeader(
                      label: 'Koreksi Jadwal Sholat',
                      color: Colors.blueAccent,
                    ),
                    children: <CardSettingsWidget>[
                      _koreksi(0),
                      _koreksi(1),
                      _koreksi(2),
                      _koreksi(3),
                      _koreksi(4),
                      // _kirim()
                    ],
                  ),
                ],
              ),
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
