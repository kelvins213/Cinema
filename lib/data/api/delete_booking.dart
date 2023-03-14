import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class DeleteBooking{

  final String baseURL = "";

  Future<void> deleteBooking() async {
    Uri url = Uri.http(baseURL, '/deleteBooking/:chairID/:roomNumber');
    Response response = await http.get(url);

  }

}