import 'package:flutter/material.dart';
import 'package:flutterinventori/views/homepage.dart';
import 'package:flutterinventori/views/login.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Inventory',
      initialRoute: '/', // Atur route awal jika perlu
      routes: {
        '/': (context) => LoginScreen(), // Route untuk halaman login
        '/Homepage': (context) => Homepage(), // Route untuk halaman beranda
      },
      home: LoginScreen(),
    );
  }
}