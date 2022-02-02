import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tilawah_controller.dart';

class TilawahView extends GetView<TilawahController> {
  CardSettingsRadioPicker _buildListAdzan(bool enable) {
    return CardSettingsRadioPicker<PickerModel>(
      visible: enable,
      label: 'Pilih Adzan',
      initialItem: controller.getAdzanList().first,
      hintText: 'Select One',
      // autovalidateMode: _autoValidateMode,
      items: controller.getAdzanList(),
      // validator: (PickerModel value) {
      //   if (value == null || value.toString().isEmpty)
      //     return 'You must pick a gender.';
      //   return null;
      // },
      // onSaved: (value) => _ponyModel.gender = value,
      onChanged: (value) {
        print(value.code);
        final hasil = int.parse(value.code.toString());

        print(hasil);
      },
    );
  }

  CardSettingsRadioPicker _buildListRadio(bool enable) {
    return CardSettingsRadioPicker<PickerModel>(
      visible: enable,
      label: 'Pilih surah',
      initialItem: controller
          .getQuranList()
          .first, // PickerModel('Alfatiha', code: '000'),
      hintText: 'Select One',
      // autovalidateMode: _autoValidateMode,
      items: controller.getQuranList(),
      // validator: (PickerModel value) {
      //   if (value == null || value.toString().isEmpty)
      //     return 'You must pick a gender.';
      //   return null;
      // },
      // onSaved: (value) => _ponyModel.gender = value,
      onChanged: (value) {
        print(value.code);
        final hasil = int.parse(value.code.toString());

        print(hasil);
      },
    );
  }

  CardSettings _buildMenu(String tilte, bool enable) {
    return CardSettings.sectioned(
      labelPadding: 12.0,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Tilawah ' + tilte,
          ),
          children: <CardSettingsWidget>[
            _buildListRadio(enable),
            _buildListAdzan(enable),
          ],
        ),
      ],
    );
  }

  CardSettingsRadioPicker _buildListEqualizer(bool enable) {
    return CardSettingsRadioPicker<PickerModel>(
      visible: enable,
      label: 'Pilih Equalizer',
      initialItem: controller
          .getEqualizerList()
          .first, // PickerModel('Alfatiha', code: '000'),
      hintText: 'Select One',
      // autovalidateMode: _autoValidateMode,
      items: controller.getEqualizerList(),
      // validator: (PickerModel value) {
      //   if (value == null || value.toString().isEmpty)
      //     return 'You must pick a gender.';
      //   return null;
      // },
      // onSaved: (value) => _ponyModel.gender = value,
      onChanged: (value) {
        print(value.code);
        final hasil = int.parse(value.code.toString());
        print(hasil);
      },
    );
  }

  CardSettingsSlider _buildVolume(bool enable) {
    return CardSettingsSlider(
      visible: enable,
      label: 'Volume',
      initialValue: controller.getVolume(),
      min: 0.0,
      max: 30.0,
      // autovalidateMode: _autoValidateMode,
      // validator: (double value) {
      //   if (value == null) return 'You must pick a rating.';
      //   return null;
      // },
      // onSaved: (value) => _ponyModel.rating = value,
      onChanged: (value) {
        controller.setVolume(value);
        print(value.toInt());
      },
    );
  }

  CardSettings _buildSetting(String tilte, bool enable) {
    return CardSettings.sectioned(
      labelPadding: 12.0,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: tilte,
          ),
          children: <CardSettingsWidget>[
            _buildVolume(enable),
            _buildListEqualizer(enable),
            _buildListRadio(enable),
            _buildListAdzan(enable),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tilawah'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.play_arrow)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
          backgroundColor: Colors.green,
        ),
        body: TabBarView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: ListView.builder(
                itemCount: controller.namaTilawah.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => _buildMenu(
                        controller.namaTilawah[index], controller.enable.value),
                  );
                  // _buildMenu(
                  //     controller.getNameTilawah(index), controller.getEnable());
                },
              ),
            ),
            _buildSetting('Setting Tilawah', true),
          ],
        ),
      ),
    );
  }
}
