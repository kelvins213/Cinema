import 'package:cinema/data/shared_preferences/booking_shared_preferences.dart';
import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class DeleteBooking{

  final String baseURL = "cin.onrender.com";

  Future<void> deleteBooking({required List<dynamic> chairs, required int roomNumber}) async {

    for (var chair in chairs) {
      Uri url = Uri.https(baseURL, '/deleteBooking/$chair/$roomNumber');
      Response response = await http.delete(url);
      print(response.statusCode);
    }

  }

  Future<void> deleteWatcher({required String filmName}) async {

    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();

    Uri url = Uri.https(baseURL, '/deleteWatcher/${costumer.email}/$filmName');
    Response response = await http.delete(url);

    print(response.statusCode);
    print(response.body);
  }

}