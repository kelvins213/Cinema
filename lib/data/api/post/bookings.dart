import 'package:cinema/data/shared_preferences/booking_shared_preferences.dart';
import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:cinema/domain/film.dart';
import 'package:cinema/domain/food.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Booking{

  final String baseURL = "cin.onrender.com";

  Future<void> createBooking() async {

    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();

    Film film = await BookingSharedPreferencesHelper().getFilmInfos();

    List<int> chairsIDs = await BookingSharedPreferencesHelper().getChairsIDs();

    print(costumer.email);
    print(film.room);
    print(chairsIDs);

    int responseCount = 0;

    for (var chairID in chairsIDs) {
      Uri url = Uri.https(baseURL, '/createBooking/${costumer.email}/$chairID/${film.room}');
      Response response = await http.post(url);

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 202) {
        print("oi");
        responseCount++;
      }
    }
  }

  Future<void> setWatch() async {
    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();
    Film film = await BookingSharedPreferencesHelper().getFilmInfos();

    Uri url = Uri.https(baseURL, '/setWatch/${film.name}/${costumer.email}');
    Response response = await http.post(url);

  }

  Future<void> setFood() async {
    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();
    Food food = await BookingSharedPreferencesHelper().getFoodInfos();

    Uri url = Uri.https(baseURL, '/setFood/${costumer.email}/${food.quantPopkorn}/${food.quantSoda}');
    Response response = await http.post(url);

  }
}