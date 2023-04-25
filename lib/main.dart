import 'package:cinema/pages/home_page.dart';
import 'package:cinema/pages/login_page.dart';
import 'package:cinema/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    ),
  );
}

