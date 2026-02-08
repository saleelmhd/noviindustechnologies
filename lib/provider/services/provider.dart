import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noviindustechnologies/loginpage.dart';

class SplashProvider extends ChangeNotifier {

  void startSplash(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  LoginPage()),
    );    });
  }
}
