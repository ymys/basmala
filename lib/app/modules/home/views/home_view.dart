import 'package:basmalla/app/modules/home/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeView extends GetView<HomeController> {
  BluetoothController get bt_controller =>
      GetInstance().find<BluetoothController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Basmalla',
          style: TextStyle(fontSize: 28, fontStyle: FontStyle.italic),
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: DecoratedIcon(
                FontAwesomeIcons.bluetooth,
                color: bt_controller.isConnect() == true
                    ? Colors.greenAccent
                    : Colors.amber,
                size: 24.sp,
              ),
              tooltip: 'Bluetooth',
              onPressed: () async {
                await Get.toNamed('/bluetooth-setting');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              // color: Colors.yellow,
            ),
            new ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent])
                    // colors: [Colors.black, Colors.pink])
                    .createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: new Image.asset(
                //masjid 4
                "images/Masjid.jpg",
                // "images/Masjid3.jpg",
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            new RotatedBox(
              quarterTurns: 3,
              child: new Text(
                "BASMALLA",
                style: new TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.25),
                    // color: Colors.black,
                    letterSpacing: 10),
              ),
            ),
            // new Positioned(
            //     top: 15,
            //     right: 15,
            //     child: new Container(
            //       height: 40,
            //       width: 40,
            //       decoration: new BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           color: Colors.white),
            //       child: new Center(
            //         child: new Icon(Icons.menu),
            //       ),
            //     )),
            // new Positioned(
            //   top: MediaQuery.of(context).size.height * 0.05,
            //   right: MediaQuery.of(context).size.width * 0.05,
            //   child: new Obx(
            //     () => Container(
            //       height: 12,
            //       width: 12,
            //       decoration: new BoxDecoration(
            //         borderRadius: BorderRadius.circular(8),
            //         color: bt_controller.isConnect() == true
            //             ? Colors.green
            //             : Color(0xFFFD3664),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.40,
              margin: EdgeInsets.only(left: 21),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    'WELCOME TO,',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      color: Colors.grey[600],
                    ),
                  ),
                  // Text(
                  //   'WELCOME TO,',
                  //   style: GoogleFonts.oswald(
                  //     textStyle: TextStyle(
                  //       color: Colors.grey[600],
                  //       fontSize: 24.sp,
                  //     ),
                  //   ),
                  // ),
                  Text(
                    'BASMALLA',
                    style: TextStyle(
                      letterSpacing: 4,
                      fontSize: 31.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFD3664),
                    ),
                  ),
                  Text(
                    "New Smart Jadwal Sholat Digital",
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 19.sp,
                      letterSpacing: 1.4,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            new Positioned(
              top: MediaQuery.of(context).size.height * 0.40,
              left: 0,
              child: Container(
                // color: Colors.yellow,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(11),
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  children: <Widget>[
                    Menu(
                      gambar: FontAwesomeIcons.clock,
                      text: 'Sinkron Waktu',
                      onClick: () async {
                        DateTime waktu = DateTime.now();
                        //('kkmmssddMMyyyy')
                        String kirim = "";

                        kirim = waktu.second.toString().padLeft(2, '0');
                        kirim += waktu.minute.toString().padLeft(2, '0');
                        kirim += waktu.hour.toString().padLeft(2, '0');
                        kirim += waktu.day.toString().padLeft(2, '0');
                        kirim += waktu.month.toString().padLeft(2, '0');
                        kirim += (waktu.year - 2000).toString();

                        await bt_controller.setting("%J", kirim);
                      },
                    ),
                    Menu(
                      gambar: FontAwesomeIcons.cloudSun,
                      text: 'Kecerahan',
                      onClick: () {
                        Get.toNamed('/brightness');
                      },
                    ),
                    Menu(
                      gambar: FontAwesomeIcons.eraser,
                      text: 'Koreksi Jadwal',
                      onClick: () {
                        Get.toNamed('/koreksi');
                      },
                    ),
                    Menu(
                      gambar: FontAwesomeIcons.edit,
                      text: 'Edit Text',
                      onClick: () {
                        Get.toNamed('/running-text');
                      },
                    ),
                    Menu(
                      gambar: FontAwesomeIcons.mosque,
                      text: 'Iqomah',
                      onClick: () {
                        Get.toNamed('/iqomah');
                      },
                    ),
                    Menu(
                      gambar: FontAwesomeIcons.bullhorn,
                      text: 'Lama Adzan',
                      onClick: () {
                        Get.toNamed('/adzan');
                      },
                    ),
                    Menu(
                      gambar: FontAwesomeIcons.globeAmericas,
                      text: 'Seting Kota',
                      onClick: () {
                        Get.toNamed('/lokasi');
                      },
                    ),
                    Menu(
                      gambar: FontAwesomeIcons.calendarCheck,
                      text: 'Fix Jadwal',
                      onClick: () {
                        Get.toNamed('/fix-jadwal');
                      },
                    ),
                    Menu(
                      gambar: FontAwesomeIcons.tools,
                      text: 'Pengaturan',
                      onClick: () {
                        Get.toNamed('/pengaturan');
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class mainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Menu extends StatelessWidget {
  Menu({required this.gambar, required this.text, required this.onClick});
  final IconData gambar;
  final String text;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo,
              spreadRadius: 2,
            ),
          ],
        ),

        child: new InkWell(
          splashColor: Colors.greenAccent,
          onTap: () {
            onClick();
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DecoratedIcon(
                  gambar,
                  color: Colors.green,
                  size: 31.sp,
                  shadows: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(3.0, 3.0),
                    ),
                    // BoxShadow(
                    //   blurRadius: 12.0,
                    //   color: Colors.blue,
                    // ),
                    // BoxShadow(
                    //   blurRadius: 12.0,
                    //   color: Colors.green,
                    //   offset: Offset(0, 6.0),
                    // ),
                  ],
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 15.sp),
                )
              ],
            ),
          ),
        ),
        // color: Colors.transparent,
        // ),
      ),
    );
  }
}
