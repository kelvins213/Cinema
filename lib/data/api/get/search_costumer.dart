import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Login{

  final String baseURL = "";

  Future<void> searchForAccount() async {

    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();

    Uri url = Uri.http(baseURL, '/searchForAccount/${costumer.email}/${costumer.password}');
    Response response = await http.get(url);

  }


}