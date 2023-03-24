import 'package:cinema/domain/costumer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CostumerSharedPreferencesHelper{

  static storeCostumerData({required Costumer costumer}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", costumer.name);
    await prefs.setString("email", costumer.email);
    await prefs.setString("password", costumer.password);
    await prefs.setBool("logged", costumer.logged);
  }

  Future<Costumer> getCostumerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String costumerName = prefs.getString("name") ?? "invalid";
    String costumerEmail = prefs.getString("email") ?? "invalid";
    String costumerPassword = prefs.getString("password") ?? "invalid";
    bool costumerLogged = prefs.getBool("logged")  ?? false;

    Costumer costumer = Costumer(name: costumerName, email: costumerEmail, password: costumerPassword, logged: costumerLogged);

    return costumer;
  }

  Future<void> cleanCostumerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("password");
    prefs.setBool("logged", false);
  }

  Future<void> storeLoginState({required bool logged}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("logged", logged);
  }

  Future<bool> getLoginState() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool logged = prefs.getBool("logged") ?? false;

    return logged;
  }

}