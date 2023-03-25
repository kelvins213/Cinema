import 'dart:convert';

import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/bookings.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CostumerBookings{

  final String baseURL = "cin.onrender.com";

  Future<List<CostumerReservs>> getReservs() async {

    List<CostumerReservs> reservList = <CostumerReservs>[];

    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();

    Uri url = Uri.http(baseURL, '/getBooking/${costumer.email}');
    Response response = await http.get(url);

    print(response.statusCode);
    print(response.contentLength);
    print(response.reasonPhrase);
    print(response.request);

    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var i in json['costumer_bookings']) {
        CostumerReservs reserv = CostumerReservs.fromJson(i);
        reservList.add(reserv);
      }
    }

    return reservList;
  }
}