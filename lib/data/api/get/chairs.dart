import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ChairsBooked{

  final String baseURL = "";

  Future<void> getChairs() async {
    Uri url = Uri.http(baseURL, '/getChairsBooked/:roomNumber');
    Response response = await http.get(url);



  }

}