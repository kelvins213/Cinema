import 'dart:convert';

import 'package:cinema/domain/film.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FilmsAvailable{

  final String baseURL = "cin.onrender.com";

  Future<List<Film>> getFilmsAvailable() async{

    List<Film> filmsList = [];
    Film film;

    Uri url = Uri.http(baseURL, '/getFilms');
    Response response = await http.get(url);

    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var film in json) {
        film = Film.fromJson(film);
        filmsList.add(film);
      }
    }

    return filmsList;
  }
}