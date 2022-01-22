import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:dialog/dialog.dart';
import 'package:dialogs/dialogs.dart';
import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  CardSettingsDatePicker _datePicker(String label) {
    return CardSettingsDatePicker(
      firstDate: DateTime(2020),
      lastDate: DateTime(2060),
      visible: true,
      enabled: true,
      label: label,
      icon: Icon(Icons.calendar_today_outlined),
      onChanged: (value) {
        controller.setDateManuaL(value);
      },
    );
  }

  CardSettingsTimePicker TimePickerPower(int index, String label, bool enable) {
    return CardSettingsTimePicker(
      visible: enable,
      initialValue: controller.getInitPower(index),
      enabled: true,
      icon: Icon(Icons.access_time),
      label: label,
      onChanged: (value) {
        controller.setPower(index, value);
      },
    );
  }

  CardSettingsTimePicker _TimePicker(String label) {
    return CardSettingsTimePicker(
      visible: true, // controller.getVisible(),
      enabled: true,
      icon: Icon(Icons.access_time),
      label: label,
      onChanged: (value) {
        controller.setTimeManual(value);
      },
    );
  }

  CardSettingsButton kirimWaktuManual() {
    return CardSettingsButton(
      bottomSpacing: 12,
      label: 'Kirim',
      onPressed: () {
        controller.kirim(0);
      },
    );
  }

  CardSettingsInt Buzer() {
    return CardSettingsInt(
      icon: Icon(Icons.notifications),
      label: 'Buzer ',
      unitLabel: '(Beep)',
      maxLength: 2,
      // labelAlign: TextAlign.left,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: controller.getBuzer(),
      controller: controller.getBuzerControler(),
      validator: (value) {
        if (value == null) return 'Tidak boleh kosong';
        return null;
      },
      onChanged: (value) {
        if (value != null) {
          controller.setBuzer(value);
        }
      },
    );
  }

  CardSettingsButton kirimBeep() {
    return CardSettingsButton(
      bottomSpacing: 12,
      label: 'Kirim',
      onPressed: () {
        controller.kirimBuzer();
      },
    );
  }

  CardSettingsButton kirimPower() {
    return CardSettingsButton(
      bottomSpacing: 12,
      label: 'Kirim',
      onPressed: () {
        controller.kirimPower();
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
          'Pengaturan',
          // style: kTextStyleBold,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                CardSettings.sectioned(
                  showMaterialonIOS: false,
                  labelWidth: 150,
                  contentAlign: TextAlign.right,
                  cardless: false,
                  children: <CardSettingsSection>[
                    CardSettingsSection(
                      header: CardSettingsHeader(
                        label: controller.titleLabel[1],
                        color: Colors.blueAccent,
                      ),
                      children: <CardSettingsWidget>[
                        Buzer(),
                        kirimBeep(),
                      ],
                    ),
                  ],
                ),
                CardSettings.sectioned(
                  showMaterialonIOS: false,
                  labelWidth: 150,
                  contentAlign: TextAlign.right,
                  cardless: false,
                  children: <CardSettingsSection>[
                    CardSettingsSection(
                      header: CardSettingsHeader(
                        label: controller.titleLabel[0],
                        color: Colors.blueAccent,
                      ),
                      children: <CardSettingsWidget>[
                        TimePickerPower(
                            0, 'Waktu ON', controller.getVisible(0)),
                        TimePickerPower(
                            1, 'Waktu OFF', controller.getVisible(0)),
                        kirimPower(),
                      ],
                    ),
                  ],
                ),
                CardSettings.sectioned(
                  showMaterialonIOS: false,
                  labelWidth: 150,
                  contentAlign: TextAlign.right,
                  cardless: false,
                  children: <CardSettingsSection>[
                    CardSettingsSection(
                      header: CardSettingsHeader(
                        label: controller.titleLabel[2],
                        color: Colors.blueAccent,
                      ),
                      children: <CardSettingsWidget>[
                        _TimePicker('Waktu'),
                        _datePicker('Tanggal'),
                        kirimWaktuManual(),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      final choiceDialog = ChoiceDialog(
                        dialogBackgroundColor: Colors.white,
                        // buttonCancelText: ,
                        buttonOkColor: Colors.green,
                        buttonOkOnPressed: () async {
                          await controller.resetPabrik();
                          Get.back();
                        },
                        title: 'Konfirmasi',
                        titleColor: Colors.black,
                        message:
                            'Apakah anda yakin ingin kembali ke pengaturan pabrik?',
                        messageColor: Colors.black,
                        buttonOkText: 'Ok',
                        dialogRadius: 15.0,
                        buttonRadius: 18.0,
                        iconButtonOk: Icon(Icons.one_k),
                      );
                      choiceDialog.show(context);
// choiceDialog.buttonOkOnPressed =
                      // choiceDialog.dismiss();
                      // MessageDialog messageDialog = MessageDialog(
                      //   dialogBackgroundColor: Colors.white,
                      //   buttonOkColor: Colors.green,
                      //   buttonOkOnPressed: () {
                      //     controller.resetPabrik();
                      //   },
                      //   title: 'Konfirmasi',
                      //   titleColor: Colors.black,
                      //   message:
                      //       'Apakah anda yakin ingin kembali ke pengaturan pabrik?',
                      //   messageColor: Colors.black,
                      //   buttonOkText: 'Ok',
                      //   dialogRadius: 15.0,
                      //   buttonRadius: 18.0,
                      //   iconButtonOk: Icon(Icons.one_k),
                      // );

                      // messageDialog.show(context, barrierColor: Colors.white);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber[800],
                      minimumSize: Size.fromHeight(50),
                    ),
                    child: Text(
                      'Reset Pengaturan Pabrik',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
