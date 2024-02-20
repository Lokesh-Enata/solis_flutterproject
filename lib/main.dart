import 'package:flutter/material.dart';
import 'package:solis_flutterproject/Views/pages/Account/otppage.dart';
import 'package:solis_flutterproject/Views/pages/Account/registerpage.dart';
import 'package:solis_flutterproject/Views/pages/dashboardpage.dart';
import 'package:solis_flutterproject/Views/pages/Account/loginpage.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const OTPPage();
  }
}