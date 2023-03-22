import 'package:cinema/domain/film.dart';
import 'package:cinema/domain/food.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingSharedPreferencesHelper{

  Future<void> storeFilmInfos({required String filmName, required int roomNumber})async {
    SharedPreferences prefBooking = await SharedPreferences.getInstance();
    await prefBooking.setString("filmName", filmName);
    await prefBooking.setInt("roomNumber", roomNumber);
  }

  Future<void> storeChairsIDs({required List<int> chairsIDs}) async{
    SharedPreferences prefBooking = await SharedPreferences.getInstance();

    List<String> chairs = [];

    for (var i in chairsIDs) {
      chairs.add(i.toString());
    }

    await prefBooking.setStringList("chairsIDs", chairs);

    List<String> list = prefBooking.getStringList("chairsIDs") ?? [];
  }

  Future<void> storeFood({required int quantPopkorn, required int quantSoda}) async   {
    SharedPreferences prefBooking = await SharedPreferences.getInstance();
    await prefBooking.setInt("quantPopkorn", quantPopkorn);
    await prefBooking.setInt("quantSoda", quantSoda);
  }

  Future<Film> getFilmInfos() async {
    SharedPreferences prefBooking = await SharedPreferences.getInstance();
    String filmName = prefBooking.getString("filmName") ?? "invalid";
    int roomNumber = prefBooking.getInt("roomNumber") ?? 0;

    Film film = Film(thumbLink: "", name: filmName, synopsis: "", date: "", time: "", room: roomNumber);

    return film;
  }

  Future<List<int>> getChairsIDs() async {
    SharedPreferences prefBooking = await SharedPreferences.getInstance();
    List<String> chairsList = prefBooking.getStringList("chairsIDs") ?? [];

    List<int> chairs = [];

    for (var i in chairsList) {
      chairs.add(int.parse(i));
    }

    return chairs;
  }

  Future<Food> getFoodInfos() async {
    SharedPreferences prefBooking = await SharedPreferences.getInstance();

    int quantPopkorn = prefBooking.getInt("quantPopkorn") ?? 0;
    int quantSoda = prefBooking.getInt("quantSoda")  ?? 0;

    Food food = Food(quantPopkorn: quantPopkorn, quantSoda: quantSoda);

    return food;
  }
}