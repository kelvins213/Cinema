import 'package:cinema/data/api/delete/booking.dart';
import 'package:cinema/data/api/get/bookings.dart';
import 'package:cinema/data/shared_preferences/delete_booking_shared_preferences.dart';
import 'package:cinema/domain/bookings.dart';
import 'package:cinema/domain/food.dart';
import 'package:flutter/material.dart';

class Bookings extends StatefulWidget {

  const Bookings({Key? key,}) : super(key: key);

  @override
  _Bookings createState() => _Bookings();
}

class _Bookings extends State<Bookings>{

  @override
  Future<List<CostumerReservs>> reservs = CostumerBookings().getReservs();
  Future<Food> foodReserved = CostumerBookings().getFood();
  List<IconData> icons = [Icons.date_range, Icons.hourglass_bottom, Icons.living];

  /*
  *
                      List<dynamic> filmAtributes = <dynamic> [
                        reservedFilms[index].date,
                        reservedFilms[index].time,
                        reservedFilms[index].room,
                      ];*/

  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF950101),  Color(0xFF3D0000), Color(0xFF000000)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFF950101),
          title: buildText(text: "Bookings", size: 24, color: const Color(0xFFFEFCF3)),
        ),
        body: FutureBuilder<List<CostumerReservs>>(
          future: reservs,
          builder: (context, snapshot){
            if (snapshot.hasData) {
              List<CostumerReservs> reservedFilms = snapshot.data ?? [];
              return ListWheelScrollView(
                itemExtent: 300,
                physics: const FixedExtentScrollPhysics(),
                children: [
                  Image.network(reservedFilms[0].thumbLink, width: 400,),
                  Image.network(reservedFilms[1].thumbLink, width: 400,),
                  Image.network(reservedFilms[2].thumbLink, width: 400,),
                  Image.network(reservedFilms[3].thumbLink, width: 400,),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  onTap({required String thumbLink, required String synopsis}){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: const Color(0xFF000000),
              height: 750,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(thumbLink, width: 200,),
                    buildText(text: synopsis, size: 18, color: const Color(0xFFEEEEEE)),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  onPressed({required CostumerReservs reserv}) async {
    //once its onPressed, you have to disable all buttons and show a CircularProgressIndicator
    //to do it, you can easyly use the FutureBuilder widget
    //remember, you must do it on food page too

    CostumerReservs r = CostumerReservs(duration: reserv.duration, gender: reserv.gender, cod: reserv.cod, name: reserv.name, date: reserv.date, time: reserv.time, thumbLink: reserv.thumbLink, synopsis: reserv.synopsis, room: reserv.room, chairs: reserv.chairs);
    await DeleteBookingSharedPreferencesHelper().storeBookInfos(reserv: r);
    await DeleteBookingSharedPreferencesHelper().getBookInfo();

    await DeleteBooking().deleteBooking();
    await DeleteBooking().deleteWatcher();
    await DeleteBooking().deleteFood();

    setState(() {
      reservs = CostumerBookings().getReservs();
      foodReserved = CostumerBookings().getFood();
    });
  }

  buildText({required dynamic text, required double size, required Color color}){
    text = text.toString();
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: size,
        color: color,
      ),
    );
  }

  buildChairText({required List<dynamic> chairs, required double size, required Color color}){

    String text = "|";

    for (var chair in chairs) {
      text = text + " ${chair.toString()} |";
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: size,
        color: color,
      ),
    );
  }

  buildFoodCard({required IconData icon, required int quant}){
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xFF000000),
          width: 1.7,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, size: 32,),
            buildText(text: ' - ${quant}', size: 32, color: const Color(0xFF000000))
          ],
        ),
      ),
    );
  }
}