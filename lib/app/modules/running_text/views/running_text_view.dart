import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/running_text_controller.dart';

class RunningTextView extends GetView<RunningTextController> {
  CardSettingsParagraph _textEdit(int lines) {
    return CardSettingsParagraph(
      label: 'Text yang akan ditampilkan pada running text',
      maxLength: 499,
      numberOfLines: lines,
      contentAlign: TextAlign.justify,
      controller: controller.textControler,
      onChanged: (value) {
        controller.saveText(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Edit Text'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: CardSettings.sectioned(
                showMaterialonIOS: true,
                labelWidth: 150,
                contentAlign: TextAlign.right,
                cardless: false,
                children: <CardSettingsSection>[
                  CardSettingsSection(
                    header: CardSettingsHeader(
                      label: 'Text',
                      color: Colors.blueAccent,
                    ),
                    children: <CardSettingsWidget>[
                      _textEdit(20),
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
        ));
  }
}
