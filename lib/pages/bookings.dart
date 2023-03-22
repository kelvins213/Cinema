import 'package:cinema/data/api/get/bookings.dart';
import 'package:cinema/domain/bookings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bookings extends StatefulWidget {

  const Bookings({Key? key,}) : super(key: key);

  @override
  _Bookings createState() => _Bookings();
}

class _Bookings extends State<Bookings>{

  @override

  Future<List<CostumerReservs>> reservs = CostumerBookings().getReservs();

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF4C6793),
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
                      return Container(
                        height: 362,
                        width: MediaQuery.of(context).size.width - 16,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    buildText(text: reservedFilms[index].name, size: 24, color: Colors.white),
                                  ],
                                ),
                                Column(
                                  children: [
                                    buildText(text: reservedFilms[index].date, size: 24, color: Colors.white),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index){
                      return SizedBox(height: 24);
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

  onTap(){}

  buildText({required String text, required double size, required Color color}){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        color: color,
      ),
    );
  }
}