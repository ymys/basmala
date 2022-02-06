import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lokasi_controller.dart';

class LokasiView extends GetView<LokasiController> {
  CardSettingsDouble _textFileld(int index) {
    return CardSettingsDouble(
      label: controller.getLabel(index),
      unitLabel: 'derajat',
      maxLength: 10,
      decimalDigits: 7,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: 0,
      controller: controller.getTextControler(index),
      validator: (value) {
        if (value == null) return 'Tidak boleh kosong';
        return null;
      },
      onSaved: (value) {},
      onChanged: (value) {},
    );
  }

  CardSettingsListPicker _buildZona(int index) {
    return CardSettingsListPicker<PickerModel>(
      label: 'Pilih Zona Waktu',
      initialItem: controller.data_zona[0],
      hintText: 'Select One',
      items: controller.data_zona,
      onChanged: (value) {
        controller.setZona(value.code.toString());
      },
    );
  }

  CardSettingsParagraph _alamat(int index) {
    return CardSettingsParagraph(
      controller: controller.getTextControler(index),
      label: 'Alamat',
      contentAlign: TextAlign.justify,
      initialValue: '',
      numberOfLines: 5,
      maxLength: 500,
    );
  }

  CardSettingsButton _buildCardSettingsButton_Save() {
    return CardSettingsButton(
      label: 'Load GPS',
      backgroundColor: Colors.amber[800],
      textColor: Colors.white,
      bottomSpacing: 20,
      onPressed: () async {
        // CardSettings.of(context).divider(/)
        Get.defaultDialog(
          title: 'Loading',
          titleStyle: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
          middleTextStyle: TextStyle(color: Colors.black),
          radius: 3,
          contentPadding: EdgeInsets.all(15),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircularProgressIndicator(
                color: Colors.amber,
              ),
              SizedBox(
                width: 20,
              ),
              Text('Mencari Lokasi...'),
            ],
          ),
          barrierDismissible: false,
        );
        await controller.loadGPS();
        Get.back(canPop: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Lokasi',
        ),
      ),
      resizeToAvoidBottomInset: false,
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
                    label: 'Setting Lokasi',
                  ),
                  children: <CardSettingsWidget>[
                    _textFileld(0),
                    _textFileld(1),
                    _buildZona(3),
                    _alamat(2),
                    _buildCardSettingsButton_Save()
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
