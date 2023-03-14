import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FilmsAvailable{

  final String baseURL = "";

  Future<void> getFilmsAvailable() async{

    Uri url = Uri.http(baseURL, '/getFilms');
    Response response = await http.get(url);

    print(response.statusCode);
    print(response.body);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      //print(json);
    }
  }
}