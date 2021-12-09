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

      // _buildPortraitLayout(),

      // Container(
      //   child: _buildPortraitLayout(),
      // color: controller.warnaBackground,
      // padding: EdgeInsets.all(10),
      // child: Card(
      //   child: Container(
      //     margin: EdgeInsets.only(
      //       bottom: 20,
      //       left: 3,
      //       right: 3,
      //     ),
      //     child: Column(
      //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       // crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: <Widget>[
      //         Container(
      //           padding: EdgeInsets.only(top: 15, bottom: 10),
      //           child: Center(
      //             child: Text(
      //               "Pengaturan Tartil",
      //               style: TextStyle(
      //                   color: controller.warnaJudul,
      //                   fontSize: 22,
      //                   fontWeight: FontWeight.w700,
      //                   fontStyle: FontStyle.italic),
      //             ),
      //           ),
      //         ),
      //         Container(
      //           margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
      //           child: Divider(
      //             color: Colors.redAccent[400],
      //             thickness: 3,
      //           ),
      //         ),
      //         Expanded(
      //           child: ListView.separated(
      //             itemCount: 5, //_treatments.length,
      //             itemBuilder: (context, index) {
      //               return Container(
      //                 padding: EdgeInsets.only(right: 10),
      //                 height: 60,
      //                 color: index.isOdd
      //                     ? controller.warnaOdd
      //                     : controller.warnaEvent,
      //                 // height: 55,
      //                 child: Row(
      //                   // mainAxisSize: MainAxisAlignment.spaceAround,
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: <Widget>[
      //                     Row(
      //                       mainAxisSize: MainAxisSize.max,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: <Widget>[
      //                         Checkbox(
      //                           value: controller.flag[index],
      //                           onChanged: (bool? value) async {
      //                             await controller.enable(index, value!);
      //                             // print(value);
      //                           },
      //                         ),
      //                         // value: rememberMe,
      //                         // onChanged: _onRememberMeChanged
      //                         // );
      //                         Text(
      //                           controller.sholat[index],
      //                           style: TextStyle(
      //                               color: Colors.grey[700],

      //                               // fontStyle: FontStyle.italic,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 20),
      //                           textAlign: TextAlign.left,
      //                         ),
      //                         Container(
      //                           width: 20,
      //                         )
      //                       ],
      //                     ),
      //                     Row(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: <Widget>[
      //                         // Switch(
      //                         //     value: controller.flag[index],
      //                         //     onChanged: (bool value) async {
      //                         //       await controller.enable(index, value);
      //                         //       // print(value);
      //                         //     }),
      //                         VerticalDivider(
      //                           thickness: 3,
      //                           color: Colors.grey,
      //                           indent: 7,
      //                           endIndent: 7,
      //                         ),
      //                         GestureDetector(
      //                           onTap: () async {
      //                             // controller.save(index);
      //                           },
      //                           child: Text(
      //                             controller.tartil[index] + " menit",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 20,
      //                                 color: Colors.grey[700]),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //                 // ),
      //               );
      //             },
      //             separatorBuilder: (context, index) => Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 0.5),
      //               // child: Divider(
      //               //   height: 1.0,
      //               //   thickness: 1.0,
      //               //   indent: 15.0,
      //               //   endIndent: 15.0,
      //               //   // color: kDividerColor,
      //               // ),
      //             ),
      //           ),
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             Container(
      //               margin: EdgeInsets.all(10),
      //               height: 50.0,
      //               width: 140,
      //               child: RaisedButton(
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(0.0),
      //                     side: BorderSide(
      //                         color: Color.fromRGBO(0, 160, 227, 1))),
      //                 onPressed: () {},
      //                 padding: EdgeInsets.all(10.0),
      //                 color: Color.fromRGBO(0, 160, 227, 1),
      //                 textColor: Colors.white,
      //                 child: Text("Play", style: TextStyle(fontSize: 20)),
      //               ),
      //             ),
      //             Container(
      //               margin: EdgeInsets.all(10),
      //               height: 50.0,
      //               width: 140,
      //               child: RaisedButton(
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(0.0),
      //                     side: BorderSide(color: Colors.pink)),
      //                 // color: Color.fromRGBO(0, 160, 227, 1))),
      //                 onPressed: () {
      //                   controller.kirim();
      //                 },
      //                 padding: EdgeInsets.all(10.0),
      //                 color: Colors.pink //Color.fromRGBO(0, 160, 227, 1),
      //                 ,
      //                 textColor: Colors.white,
      //                 child: Text("Kirim", style: TextStyle(fontSize: 20)),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // ),
    );
  }
}
