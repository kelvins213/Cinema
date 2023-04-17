import 'dart:convert';
import 'package:cinema/data/shared_preferences/booking_shared_preferences.dart';
import 'package:cinema/domain/film.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ChairsBooked{

  final String baseURL = "cin.onrender.com";

  Future<List<dynamic>> getChairs() async {

    Film film = await BookingSharedPreferencesHelper().getFilmInfos();


    Uri url = Uri.http(baseURL, '/getChairsBooked/${film.room}');
    Response response = await http.get(url);

    var json = jsonDecode(response.body);

    json ??= [];

    return json;
  }
}