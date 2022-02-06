import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tilawah_controller.dart';

class TilawahView extends GetView<TilawahController> {
  CardSettingsInt _buildLamaTilawah(int index) {
    return CardSettingsInt(
      label: 'Lama Tilawah',
      unitLabel: '(menit)',
      maxLength: 2,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller.getLamaTilawahControler(index),
      validator: (value) {
        if (value == null) return 'Tidak boleh kosong';
        return null;
      },
      onChanged: (value) {
        if (value != null) {
          controller.setLamaTilawah(value, index);
        }
      },
    );
  }

  CardSettingsRadioPicker _buildListAdzan(int index) {
    return CardSettingsRadioPicker<PickerModel>(
      label: 'Pilih Adzan',
      initialItem: controller.getInitAdzan(index),
      hintText: 'Select One',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: controller.getAdzanList(),
      // validator: (PickerModel value) {
      //   if (value == null || value.toString().isEmpty)
      //     return 'You must pick a gender.';
      //   return null;
      // },
      onChanged: (value) {
        // controller
        controller.setInitAdzan(value, index);
      },
    );
  }

  CardSettingsRadioPicker _buildListSurah(int index) {
    return CardSettingsRadioPicker<PickerModel>(
      label: 'Pilih surah',
      initialItem: controller.getInitSurah(index),
      hintText: 'Select One',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: controller.getQuranList(),
      onChanged: (value) {
        controller.setInitSurah(value, index);
      },
    );
  }

  CardSettingsButton _kirim(int index) {
    return CardSettingsButton(
      textColor: Colors.white,
      backgroundColor: Colors.green,
      bottomSpacing: 12,
      label: 'Kirim',
      onPressed: () {
        controller.kirim(index);
      },
    );
  }

  CardSettings _buildMenu(String tilte, int index) {
    return CardSettings.sectioned(
      labelPadding: 12.0,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Tilawah ' + tilte,
          ),
          children: <CardSettingsWidget>[
            _buildListSurah(index),
            _buildLamaTilawah(index),
            _buildListAdzan(index),
            _kirim(index),
          ],
        ),
      ],
    );
  }

//setting Pengaturan df player
  CardSettingsRadioPicker _buildListEqualizer() {
    return CardSettingsRadioPicker<PickerModel>(
      label: 'Pilih Equalizer',
      initialItem: controller.getInitEqualizer(),
      hintText: 'Select One',
      items: controller.getEqualizerList(),
      onChanged: (value) {
        controller.setInitEqualizer(value);
      },
    );
  }

  CardSettingsSlider _buildVolume() {
    return CardSettingsSlider(
      label: 'Volume',
      initialValue: controller.getVolume(),
      min: 0.0,
      max: 30.0,
      onChanged: (value) {
        controller.setVolume(value);
      },
    );
  }

  CardSettingsButton _play(String name) {
    return CardSettingsButton(
      textColor: Colors.white,
      backgroundColor: Colors.green,
      bottomSpacing: 12,
      label: 'Play ' + name,
      onPressed: () {
        controller.playerPlay(name);
      },
    );
  }

  CardSettingsButton _stop() {
    return CardSettingsButton(
      textColor: Colors.white,
      backgroundColor: Colors.red,
      bottomSpacing: 12,
      label: 'Stop',
      onPressed: () {
        controller.playerStop();
      },
    );
  }

  CardSettingsButton _setting() {
    return CardSettingsButton(
      textColor: Colors.white,
      backgroundColor: Colors.green,
      bottomSpacing: 12,
      label: 'Kirim',
      onPressed: () {
        controller.setting();
      },
    );
  }

  CardSettingsRadioPicker _buildPlayManual(String name) {
    return CardSettingsRadioPicker<PickerModel>(
      label: 'Pilih Surah',
      initialItem: controller.getPlayManualQuranList().first,
      hintText: 'Silahkan pilih surah',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: controller.getPlayManualQuranList(),
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'Harus Pilih Surah';
        }
      },
      onChanged: (value) {
        controller.setPlaySurah(value);
      },
    );
  }

  CardSettingsRadioPicker _buildPlayAdzanManual(String name) {
    return CardSettingsRadioPicker<PickerModel>(
      label: 'Pilih Adzan',
      initialItem: controller.getPlayManualAdzanList().first,
      hintText: 'Silahkan pilih surah adzan',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: controller.getPlayManualAdzanList(),
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'Harus Pilih Adzan';
        }
      },
      onChanged: (value) {
        controller.setPlayAdzan(value);
      },
    );
  }

  CardSettings _buildSetting() {
    return CardSettings.sectioned(
      labelPadding: 12.0,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Setting Tilawah',
          ),
          children: <CardSettingsWidget>[
            _buildVolume(),
            _buildListEqualizer(),
            _setting(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Play Manual',
          ),
          children: <CardSettingsWidget>[
            _buildPlayManual('surah'),
            _buildPlayAdzanManual('adzan'),
            CardFieldLayout(
              <CardSettingsWidget>[
                _play('Surah'),
                _play('Adzan'),
                _stop(),
              ],
            ),
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
              Tab(
                // icon: Icon(Icons.play_arrow),
                text: 'Pilih Tilawah',
              ),
              Tab(
                // icon: Icon(Icons.settings),
                text: 'Pengaturan Player',
              ),
            ],
          ),
        ),
        body: Obx(
          () => controller.enable.value == false
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 4.0, right: 4.0),
                      child: ListView.builder(
                        itemCount: controller.namaTilawah.length,
                        itemBuilder: (context, index) =>
                            _buildMenu(controller.namaTilawah[index], index),
                      ),
                    ),
                    _buildSetting(),
                  ],
                ),
        ),
      ),
    );
  }
}
