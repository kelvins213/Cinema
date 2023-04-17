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
        body: ListView(
          children: [
            FutureBuilder<List<CostumerReservs>>(
              future: reservs,
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  List<CostumerReservs> reservedFilms = snapshot.data ?? [];
                  return ListView.separated(
                    shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), scrollDirection: Axis.vertical,
                      itemBuilder: (context, index){

                      List<dynamic> filmAtributes = <dynamic> [
                        reservedFilms[index].date,
                        reservedFilms[index].time,
                        reservedFilms[index].room,
                      ];

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              width: 1.2,
                            ),
                            color: const Color(0xFFFEFCF3),
                          ),
                          height: 420,
                          width: MediaQuery.of(context).size.width - 16,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () => onTap(thumbLink: reservedFilms[index].thumbLink, synopsis: reservedFilms[index].synopsis),
                                          child: Image.network(reservedFilms[index].thumbLink, width: 200,),
                                        ),
                                        const SizedBox(height: 12,),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: const Color(0xFF000000), width: 1.2),
                                            borderRadius: BorderRadius.circular(6.0),
                                            color: Colors.greenAccent,
                                          ),
                                          width: 200,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(Icons.emergency_recording),
                                              buildText(text: reservedFilms[index].name, size: 24, color: const Color(0xFF000000)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                                      child: SizedBox(
                                        height: 350,
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, indexx){
                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                      color: Color(0xFF000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  color: Colors.greenAccent,
                                                  child: Row(
                                                    children: [
                                                      Icon(icons[indexx]),
                                                      Expanded(
                                                        child: buildText(text: filmAtributes[indexx], size: 24, color: const Color(0xFF000000)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                },
                                              separatorBuilder: (context, index){return const SizedBox(height: 24,);},
                                              itemCount: filmAtributes.length,
                                            ),
                                            const SizedBox(height: 18,),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  color: Color(0xFF000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              color: Colors.greenAccent,
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.event_seat),
                                                  Expanded(
                                                    child: buildChairText(chairs: reservedFilms[index].chairs, size: 24, color: const Color(0xFF000000)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFFFF0303),
                                          side: const BorderSide(width: 1.2),
                                        ),
                                        onPressed: () => onPressed(reserv: reservedFilms[index]),
                                        child: buildText(text: "Delete", size: 24, color: const Color(0xFFFEFCF3)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      },
                      separatorBuilder: (context, index){
                        return const SizedBox(height: 18);
                      },
                      itemCount: reservedFilms.length
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),
            FutureBuilder<Food>(
              future: foodReserved,
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  Food food = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A98B9),
                        border: Border.all(color: const Color(0xFF000000), width: 1.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildFoodCard(icon: Icons.takeout_dining, quant: food.quantPopkorn),
                            buildFoodCard(icon: Icons.local_bar, quant: food.quantSoda),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
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

    CostumerReservs r = CostumerReservs(cod: reserv.cod, name: reserv.name, date: reserv.date, time: reserv.time, thumbLink: reserv.thumbLink, synopsis: reserv.synopsis, room: reserv.room, chairs: reserv.chairs);
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