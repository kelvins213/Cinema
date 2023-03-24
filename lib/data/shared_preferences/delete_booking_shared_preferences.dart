import 'package:cinema/domain/bookings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteBookingSharedPreferencesHelper{
  
  Future<void> storeBookInfos({required CostumerReservs reserv}) async {

    List<String> chairs = <String>[];
    for (var chair in reserv.chairs) {
      chairs.add(chair.toString());
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("cod", reserv.cod);
    prefs.setString("film", reserv.name);
    prefs.setString("date", reserv.date);
    prefs.setString("time", reserv.time);
    prefs.setString("thumbLink", reserv.thumbLink);
    prefs.setString("synopsis", reserv.synopsis);
    prefs.setInt("room", reserv.room);
    prefs.setStringList("chairs", chairs);
  }

  Future<CostumerReservs> getBookInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int cod = prefs.getInt("cod") ?? 0;
    String film = prefs.getString("film") ?? "invalid";
    String date = prefs.getString("date") ?? "invalid";
    String time = prefs.getString("time") ?? "invalid";
    String thumbLink = prefs.getString("thumbLink") ?? "invalid";
    String synopsis = prefs.getString("synopsis") ?? "invalid";
    int room = prefs.getInt("room") ?? 0;
    List<dynamic> chairs = prefs.getStringList("chairs") ?? [];

    CostumerReservs reserv = CostumerReservs(cod: cod, name: film, date: date, time: time, thumbLink: thumbLink, synopsis: synopsis, room: room, chairs: chairs);

    return reserv;
  }
}