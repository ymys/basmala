import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/iqomah_controller.dart';
import 'package:card_settings/card_settings.dart';

class IqomahView extends GetView<IqomahController> {
  final List<String> iqomah = <String>[
    'Subuh',
    'Dzuhur',
    'Ashar',
    'Maghrib',
    'Isya',
    'Jumat'
  ];

  CardSettingsParagraph _Text(int index) {
    return CardSettingsParagraph(
      controller: controller.getTextControler(index),
      label: 'Text saat masuk waktu sholat',
      hintText: "Text yang akan ditampilkan saat waktu sholat",
      initialValue: controller.getText(index),
      numberOfLines: 3,
      maxLength: 100,
      onSaved: (value) {},
      onChanged: (value) {
        controller.setText(index, value);
      },
    );
  }

  CardSettingsInt _Sholat(int index) {
    return CardSettingsInt(
      label: 'Lama Sholat',
      unitLabel: '(Menit)',
      maxLength: 2,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: controller.getSholat(index),
      controller: controller.getSholatControler(index),
      validator: (value) {
        if (value == null) return 'Tidak boleh kosong';
        return null;
      },
      onSaved: (value) {},
      onChanged: (value) {
        if (value != null) {
          controller.setSholat(index, value);
        }
      },
    );
  }

  CardSettingsInt _Iqomah(int index) {
    return CardSettingsInt(
      label: 'Count Down Iqomah',
      unitLabel: '(Menit)',
      maxLength: 2,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: controller.getIqomah(index),
      controller: controller.getIqomahControler(index),
      validator: (value) {
        if (value == null) return 'Tidak boleh kosong';
        return null;
      },
      onSaved: (value) {},
      onChanged: (value) {
        if (value != null) {
          controller.setIqomah(index, value);
        }
      },
    );
  }

  CardSettingsButton _kirim(int index) {
    return CardSettingsButton(
      bottomSpacing: 12,
      label: 'Kirim',
      onPressed: () {
        controller.kirim(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Iqomah Setting',
          // style: kTextStyleBold,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        itemCount: iqomah.length,
        itemBuilder: (BuildContext context, int index) {
          return CardSettings.sectioned(
            showMaterialonIOS: false,
            labelWidth: 150,
            contentAlign: TextAlign.right,
            cardless: false,
            children: <CardSettingsSection>[
              CardSettingsSection(
                header: CardSettingsHeader(
                  label: iqomah[index],
                  color: Colors.blueAccent,
                ),
                children: <CardSettingsWidget>[
                  _Iqomah(index),
                  _Sholat(index),
                  _Text(index),
                  _kirim(index),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
