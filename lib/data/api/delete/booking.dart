import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/data/shared_preferences/delete_booking_shared_preferences.dart';
import 'package:cinema/domain/bookings.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class DeleteBooking{

  final String baseURL = "cin.onrender.com";

  Future<void> deleteBooking() async {

    CostumerReservs reservToDelete = await DeleteBookingSharedPreferencesHelper().getBookInfo();

    for (var chair in reservToDelete.chairs) {
      Uri url = Uri.https(baseURL, '/deleteBooking/$chair/${reservToDelete.room}');
      Response response = await http.delete(url);
      print(response.statusCode);
    }

  }

  Future<void> deleteWatcher() async {

    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();
    CostumerReservs filmToDelete = await DeleteBookingSharedPreferencesHelper().getBookInfo();

    Uri url = Uri.https(baseURL, '/deleteWatcher/${costumer.email}/${filmToDelete.name}');
    Response response = await http.delete(url);

    print(response.statusCode);
    print(response.body);
  }

  Future<void> deleteFood() async {

    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();
    CostumerReservs filmToDelete = await DeleteBookingSharedPreferencesHelper().getBookInfo();

    Uri url = Uri.https(baseURL, '/deleteFood/${costumer.email}/${filmToDelete.room}');
    Response response = await http.delete(url);

    print(response.statusCode);
  }
}