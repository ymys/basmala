import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/adzan_controller.dart';

class AdzanView extends GetView<AdzanController> {
  CardSettingsInt _Adzan(int index) {
    return CardSettingsInt(
      label: 'Adzan ' + controller.nama_adzan[index],
      unitLabel: '(Menit)',
      maxLength: 2,
      // labelAlign: TextAlign.left,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: controller.adzan[index],
      controller: controller.getTextControler(index),
      validator: (value) {
        if (value == null) return 'Tidak boleh kosong';
        return null;
      },
      onSaved: (value) {},
      onChanged: (value) {
        if (value != null) {
          controller.saveAdzan(index, value);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Time Out Adzan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: CardSettings.sectioned(
              showMaterialonIOS: false,
              labelWidth: 150,
              contentAlign: TextAlign.right,
              cardless: false,
              children: <CardSettingsSection>[
                CardSettingsSection(
                  header: CardSettingsHeader(
                    label: 'Setting Lama Adzan',
                    color: Colors.blueAccent,
                  ),
                  children: <CardSettingsWidget>[
                    _Adzan(0),
                    _Adzan(1),
                    _Adzan(2),
                    _Adzan(3),
                    _Adzan(4),
                  ],
                ),
              ],
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
