import 'dart:convert';

import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/bookings.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CostumerBookings{

  final String baseURL = "cin.onrender.com";

  Future<List<CostumerReservs>> getReservs() async {

    List<CostumerReservs> rList = [];

    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();

    Uri url = Uri.http(baseURL, '/getBooking/${costumer.email}');
    Response response = await http.get(url);

    print(response.statusCode);

    var json = jsonDecode(response.body);

    print(json['costumer_bookings'].length);

    if (response.statusCode == 200) {
      for (var i = 0; i < json['costumer_bookings'].length; i++) {
        CostumerReservs r = CostumerReservs.fromJson(json['costumer_bookings'][i]);
        rList.add(r);
      }
    }

    return rList;
  }
}