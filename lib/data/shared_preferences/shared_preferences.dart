import 'package:cinema/domain/costumer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{


  static storeCostumerData({required Costumer costumer}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", costumer.name);
    await prefs.setString("email", costumer.email);
    await prefs.setString("password", costumer.password);
  }

  Future<Costumer> getCostumerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String costumerName = prefs.getString("name") ?? "invalid";
    String costumerEmail = prefs.getString("email") ?? "invalid";
    String costumerPassword = prefs.getString("password") ?? "invalid";

    Costumer costumer = Costumer(name:  costumerName, email: costumerEmail, password: costumerPassword);

    return costumer;
  }

  Future<void> cleanCostumerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("password");
  }
}