import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CostumerBookings{

  final String baseURL = "";

  Future<void> getBookings() async {
    Uri url = Uri.http(baseURL, '/getBooking/:email');
    Response response = await http.get(url);

    print(response.statusCode);
    print(response.body);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      //return print(json);
    }
  }
}