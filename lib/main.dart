import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'app/routes/app_pages.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        theme: _buildTheme(),
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    }));
  });
}

ThemeData _buildTheme() {
  return ThemeData(
    primaryColor: Colors.teal, // app header background
    secondaryHeaderColor: Colors.indigo[400], // card header background
    cardColor: Colors.white, // card field background
    backgroundColor: Colors.indigo[100], // app background color
    textTheme: TextTheme(
      button: TextStyle(color: Colors.deepPurple[900]), // button text
      subtitle1: TextStyle(color: Colors.grey[800]), // input text
      headline6: TextStyle(color: Colors.white), // card header text
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, //.circular(10.0),
            // side: BorderSide(color: Colors.red),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(50, 40),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.all(10),
        ),

        backgroundColor: MaterialStateProperty.all<Color>(
            // Colors.indigo), // button background color
            Colors.transparent), // button background color
        foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white), // button text color
      ),
    ),
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.lightBlue[50]), // app header text
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.indigo[400]), // style for labels
    ),
    // fontFamily: GoogleFonts.getFont('Paprika').fontFamily,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
