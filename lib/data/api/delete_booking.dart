import 'dart:math';

import 'package:cinema/data/shared_preferences/shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class DeleteBooking{

  final String baseURL = "";

  Future<void> deleteBooking() async {

    Uri url = Uri.http(baseURL, '/deleteBooking/:chairID/:roomNumber');
    Response response = await http.delete(url);

  }

  Future<void> deleteWatcher() async {

    User costumer = await SharedPreferencesHelper().getCostumerData();

    Uri url = Uri.http(baseURL, '/deleteWatcher/${costumer.email}/:filmName');
    Response response = await http.delete(url);



  }

}