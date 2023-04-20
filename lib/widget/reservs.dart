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

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder<List<CostumerReservs>>(
            future: reservs,
            builder: (context, snapshot){
              if (snapshot.hasData) {
                List<CostumerReservs> reservedFilms = snapshot.data ?? [];
                return ListView.separated(
                  separatorBuilder: (context, index){
                    return const SizedBox(height: 32,);
                  },
                  itemBuilder: (context, index){
                    return Column(
                      children: [

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                              bottomLeft: Radius.circular(52),
                            ),
                            color: Colors.black.withOpacity(0.7),
                          ),
                          width: width * 0.85,
                          height: height * 0.4,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(18, 18, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                topLeft: Radius.circular(18),
                              ),
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        height: height * 0.4 - 18,
                                        width: 154,
                                        reservedFilms[index].thumbLink,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.85 - 154 - 18,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildText(text: reservedFilms[index].date, size: 18, color: const Color(0xFF000000)),
                                      buildText(text: reservedFilms[index].time, size: 18, color: const Color(0xFF000000)),
                                      buildChairText(chairs: reservedFilms[index].chairs, size: 18, color: const Color(0xFF000000)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: reservedFilms.length,
                );
              } else {
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          ),
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

/*
ListWheelScrollView(
                itemExtent: 300,
                physics: const FixedExtentScrollPhysics(),
                children: [
                  Image.network(reservedFilms[0].thumbLink, width: 400,),
                  Image.network(reservedFilms[1].thumbLink, width: 400,),
                  Image.network(reservedFilms[2].thumbLink, width: 400,),
                ],
              );
*/