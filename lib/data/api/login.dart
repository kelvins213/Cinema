import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Login{

  final String baseURL = "";

  Future<void> searchForAccount() async {
    Uri url = Uri.http(baseURL, '/searchForAccount/:email/:password');
    Response response = await http.get(url);

  }


}