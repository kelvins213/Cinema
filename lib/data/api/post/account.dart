import 'dart:convert';

import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Account{

  final String baseURL = "cin.onrender.com";

  Future<bool> createAccount() async {

    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();

    Uri url = Uri.https(baseURL, '/createCostumer/${costumer.name}/${costumer.email}/${costumer.password}');
    Response response = await http.post(url);

    print(response.body);
    print(response.statusCode);

    var json = jsonDecode(response.body);

    return json['condicion'];
  }
}