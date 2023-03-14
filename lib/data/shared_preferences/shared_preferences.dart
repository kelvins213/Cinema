import 'package:cinema/domain/costumer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{


  static storeCostumerData({required User costumer}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("email", costumer.email);
    await prefs.setString("password", costumer.password);
  }

  Future<User> getCostumerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String costumerEmail = prefs.getString("email") ?? "invalid";
    String costumerPassword = prefs.getString("password") ?? "invalid";

    User costumer = User(email: costumerEmail, password: costumerPassword);

    return costumer;
  }

  Future<void> cleanCostumerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("password");
  }
}