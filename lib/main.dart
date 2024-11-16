import 'package:flutter/material.dart';
import 'package:flutterinventori/views/login.dart';
import 'package:flutterinventori/views/readmaps.dart';
import 'package:get/get.dart';
// import 'package:flutterinventori/views/login_screen.dart';
import 'package:flutterinventori/views/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Inventori',
      initialRoute: '/',
      getPages: [
        // GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/', page: () => GpsReaderPage()),
      ],
    );
  }
}
