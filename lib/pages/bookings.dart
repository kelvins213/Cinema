import 'package:cinema/data/api/delete/booking.dart';
import 'package:cinema/data/api/get/bookings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bookings extends StatefulWidget {

  const Bookings({Key? key,}) : super(key: key);

  @override
  _Bookings createState() => _Bookings();
}

class _Bookings extends State<Bookings>{

  @override

  Future<List<dynamic>> reservs = CostumerBookings().getReservs();
  List<IconData> icons = [Icons.date_range, Icons.hourglass_bottom, Icons.living];
  List<String> jsonCamps = ['date', 'time', 'room'];

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF00092C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A98B9),
        centerTitle: true,
        title: buildText(text: "Bookings", size: 24, color: const Color(0xFFFEFCF3)),
      ),
      body: ListView(
        children: [
          FutureBuilder<List<dynamic>>(
            future: reservs,
            builder: (context, snapshot){
              if (snapshot.hasData) {
                List<dynamic> reservedFilms = snapshot.data ?? [];
                return ListView.separated(
                  shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
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
                                          onTap: () => onTap(thumblink: reservedFilms[index]['thumblink'], synopsis: reservedFilms[index]['synopsis']),
                                          child: Image.network(reservedFilms[index]['thumblink'], width: 200,),
                                        ),
                                        const SizedBox(height: 12,),
                                        Container(
                                          width: 200,
                                            color: Colors.greenAccent,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.emergency_recording),
                                                buildText(text: reservedFilms[index]['name'], size: 24, color: const Color(0xFF000000)),
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
                                                    color: Colors.greenAccent,
                                                    child: Row(
                                                      children: [
                                                        Icon(icons[indexx]),
                                                        Expanded(
                                                          child: buildText(text: reservedFilms[index][jsonCamps[indexx]], size: 24, color: const Color(0xFF000000)),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                separatorBuilder: (context, index){return const SizedBox(height: 24,);},
                                                itemCount: jsonCamps.length,
                                            ),
                                            //Icons.event_seat
                                            const SizedBox(height: 18,),
                                            Card(
                                              color: Colors.greenAccent,
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.event_seat),
                                                  Expanded(
                                                    child: buildChairText(chairs: reservedFilms[index]['chairs'], size: 24, color: const Color(0xFF000000)),
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
                                        ),
                                          onPressed: () => onPressed(chairs: reservedFilms[index]['chairs'], roomNumber: reservedFilms[index]['room'], filmName: reservedFilms[index]['name']),
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
                      return SizedBox(height: 18);
                    },
                    itemCount: reservedFilms.length
                );
              } else {
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ],
      ),
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  onTap({required String thumblink, required String synopsis}){
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
                    Image.network(thumblink, width: 200,),
                    buildText(text: synopsis, size: 18, color: const Color(0xFFEEEEEE)),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }


  onPressed({required List<dynamic> chairs, required int roomNumber, required String filmName}) async {
    //once its onPressed, you have to disable all buttons and show a CircularProgressIndicator
    //to do it, you can easyly use the FutureBuilder widget
    //remember, you must do it on food page too

    await DeleteBooking().deleteBooking(chairs: chairs, roomNumber: roomNumber);
    await DeleteBooking().deleteWatcher(filmName: filmName);

    setState(() {
      reservs = CostumerBookings().getReservs();
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
      text = text + "${chair.toString()} |";
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

}