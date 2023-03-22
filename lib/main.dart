import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:cinema/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    const MaterialApp(
      home: LoginPage(),
    ),
  );
}

Future<bool> checkPreviuesLogin() async {
  Costumer costumerLogin = await CostumerSharedPreferencesHelper().getCostumerData();
  return costumerLogin.logged;
}
