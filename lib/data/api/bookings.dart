import 'dart:convert';

import 'package:cinema/data/shared_preferences/shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CostumerBookings{

  final String baseURL = "";

  Future<void> getBookings() async {

    Costumer costumer = await SharedPreferencesHelper().getCostumerData();

    Uri url = Uri.http(baseURL, '/getBooking/${costumer.email}');
    Response response = await http.get(url);

    print(response.statusCode);
    print(response.body);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      //return print(json);
    }
  }
}