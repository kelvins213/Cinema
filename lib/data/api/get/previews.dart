import 'dart:convert';

import 'package:cinema/domain/preview.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class GetPreviews{

  String baseURL = "preview-api-ck6i.onrender.com";

  Future<List<CinemaPreview>> getPreviews() async {

    List<CinemaPreview> previews = <CinemaPreview>[];

    Uri url = Uri.http(baseURL, '/getPreviews');
    Response response = await http.get(url);

    print(response.body);
    var json = jsonDecode(response.body);

    for (var prev in json) {
      CinemaPreview preview = CinemaPreview.fromJson(prev);
      previews.add(preview);
    }

    return previews;
  }
}