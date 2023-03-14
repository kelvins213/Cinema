import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Account{

  final String baseURL = "";

  Future<void> createAccount() async {
    Uri url = Uri.http(baseURL, '/searchForAccount/:email/:password');
    Response response = await http.get(url);

  }
}