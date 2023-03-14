import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class DeleteAccount{

  final String baseURL = "";

  Future<void> deleteAccount() async {
    //remember: eventually, you'll need to change the <void> clause
    //and create the domain files (you will return the objects)

    Uri url = Uri.http(baseURL, '("/deleteCostumer/:email');
    Response response = await http.get(url);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      //return the object
    }

  }
}