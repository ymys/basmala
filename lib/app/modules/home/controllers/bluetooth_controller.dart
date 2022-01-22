import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// 1234 %Y 12
// Serial1.print("SetBuzer\n");

class BluetoothController extends GetxController {
  final _connect = false.obs;
  final _enable = false.obs;
  String name = "";
  String cmd = "";
  String data = "";
  String terimaData = "";
  final command = [
    "OKJ\n", //jam
    "OKI\n", //Iqomah
    "OKT\n", //tarhim
    "OKB\n", //brightness
    "OKF\n", //offsite
    "OKX\n", //fix
    "OKK\n", //kota
    "OKA\n", //adzan
    "OKW\n", //mp3
    "OKS\n", //text
    "OKZ\n", //buzer
    "OKY\n", //power
    "OKR\n", //reset pabrik
  ];
  final cmdOK = [
    "SINKRON WAKTU SUKSES",
    "SET IQOMAH SUKSES",
    "SET TARHIM SUKSES",
    "SET BRIGTNES SUKSES",
    "SET OFFSITE SUKSES",
    "SET FIX SUKSES",
    "SET KOTA SUKSES",
    "SET TIMEOUT ADZAN SUKSES",
    "SUKSES",
    "SET TEXT SUKSES",
    "SET BEEP BUZER SUKSES",
    "SET POWER SUKSES",
    "RESET PABRIK SUKSES",
  ];
  final datafinish = [
    "SetTime\n",
    "SetIqom\n",
    "SetTrkm\n",
    "SetBrns\n",
    "SetOffs\n",
    "SetFixx\n", //SetFixx\n"
    "SetKoor\n",
    "SetAlrm\n",
    "SetPlay\n",
    "SetText\n",
    "SetBuzer\n",
    "SetPower\n",
    "Reset\n",
  ];
  BluetoothConnection? connection;

  @override
  void onInit() {
    super.onInit();
    // bluetooth_list = Get.find<BluetoothSettingController>();
    FlutterBluetoothSerial.instance.state.then((state) async {
      _enable.value = state.isEnabled;

      if (_enable.value == false) {
        await FlutterBluetoothSerial.instance.requestEnable();
      }
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      _enable.value = state.isEnabled;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    connection?.dispose();
    disconect();
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
  }

  ///=============================================================================
  Future enableBluetooth() async {
    if (_enable == false) {
      await FlutterBluetoothSerial.instance.requestEnable();
    }
  }

  void disableBluetooth() async {
    if (_enable == true) {
      connection?.dispose();
      FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
      await FlutterBluetoothSerial.instance.requestDisable();
    }
  }

  bool isEnable() {
    return _enable.value;
  }

  bool isConnect() {
    return _connect.value;
  }

  void disconect() {
    connection?.dispose();
    // connection = null;
    _connect.value = false;
  }

//==============================================================================
// API bluetooth ke jws
  //method / Fungsi
  Future sendMessage(String text) async {
    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text)));
        // connection!.output.add(utf8.encode(text));
        // await connection!.output.allSent;
        await connection!.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        // setState(() {});
      }
    }
  }

  Future setting(String cmd, String data) async {
    if (this.isEnable() == false) {
      await this.enableBluetooth();
    }

    if (this.isConnect() == false) {
      var hasil = await Get.toNamed('/bluetooth-setting');
      if (hasil == null) {
        // print('Connect -> no device selected');
        Get.snackbar(
          "Pesan",
          "No Device Selected",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }
    this.cmd = cmd;
    this.data = data;
    await this.sendMessage("1234");
  }

  void request(String data) {
    //start command
    if (data == "OK\n") {
      this.sendMessage(this.cmd);
    }
    // instruction command
    else if (command.contains(data)) {
      command.forEach((element) {
        if (element == data) {
          this.sendMessage(this.data);
        }
      });
    }
    //finish command
    // erer
    else if (datafinish.contains(data)) {
      datafinish.forEach((element) {
        if (element == data) {
          String msg = cmdOK[datafinish.indexOf(element)];
          // showSnackBar(this.context, msg);
          Get.snackbar(
            "Pesan",
            msg,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      });
    } else {
      // showSnackBar(this.context, "COMMAND ERROR");
      Get.snackbar(
        "Pesan",
        "COMMAND ERROR",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    // print("incoming data = " + dataString);
    terimaData += dataString;
    if (terimaData.contains('\n')) {
      request(terimaData);
      terimaData = "";
    }
  }

//==============================================================================
  Future<String> connectTo(BluetoothDevice hasil) async {
    if (_connect.value == true) {
      await connection!.close();
    }
    String result;
    try {
      connection = await BluetoothConnection.toAddress(hasil.address);
      if (connection!.isConnected) {
        _connect.value = true;
        result = "Connected to " + hasil.name.toString();
      } else {
        result = 'Cannot connect, exception occured';
      }
      connection!.input!.listen((_onDataReceived)).onDone(() {
        Get.snackbar("Bluetooth", "Disconnected ",
            snackPosition: SnackPosition.BOTTOM);
        _connect.value = false;
      });
    } catch (exception) {
      result = "Tidak dapat terhubung ke perangkat";
    }

    return result;
  }
}
