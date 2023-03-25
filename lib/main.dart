import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:cinema/pages/login_page.dart';
import 'package:cinema/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    const MaterialApp(
      home: WelcomePage(),
    ),
  );
}

