import 'package:cinema/data/shared_preferences/booking_shared_preferences.dart';
import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:cinema/domain/film.dart';
import 'package:cinema/domain/food.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Booking{

  final String baseURL = "";

  Future<bool> createBooking() async {
    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();
    Film film = await BookingSharedPreferencesHelper().getFilmInfos();
    List<int> chairsIDs = await BookingSharedPreferencesHelper().getChairsIDs();
    int responseCount = 0;

    for (var chairID in chairsIDs) {
      Uri url = Uri.http(baseURL, '/createBooking/${costumer.email}/$chairID/${film.room}');
      Response response = await http.post(url);

      if (response.statusCode == 201) {
        responseCount++;
      }
    }

    if (responseCount == chairsIDs.length) {
      return true;
    } else {
      return false;
    }

  }

  Future<void> setWatch() async {
    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();
    Film film = await BookingSharedPreferencesHelper().getFilmInfos();

    Uri url = Uri.http(baseURL, '/setWatch/${film.film}/${costumer.email}');
    Response response = await http.post(url);

  }

  Future<void> setFood() async {
    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();
    Food food = await BookingSharedPreferencesHelper().getFoodInfos();

    Uri url = Uri.http(baseURL, '/setFood/${costumer.email}/${food.quantPopkorn}/${food.quantSoda}');
    Response response = await http.post(url);

  }
}