import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class DeleteAccount{

  final String baseURL = "";

  Future<void> deleteAccount() async {
    //remember: eventually, you'll need to change the <void> clause
    //and create the domain files (you will return the objects)

    Costumer costumer = await CostumerSharedPreferencesHelper().getCostumerData();

    Uri url = Uri.http(baseURL, '/deleteCostumer/${costumer.email}');
    Response response = await http.delete(url);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      //return the object
    }

  }
}