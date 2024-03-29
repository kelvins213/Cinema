import 'package:cinema/data/api/get/chairs.dart';
import 'package:cinema/data/shared_preferences/booking_shared_preferences.dart';
import 'package:cinema/domain/film.dart';
import 'package:cinema/widget/food.dart';
import 'package:flutter/material.dart';

class CinemaRoom extends StatefulWidget {

  final Film film;

  const CinemaRoom({
    Key? key,
    required this.film,
  }) : super(key: key);

  @override
  _CinemaRoom createState() => _CinemaRoom();
}

class _CinemaRoom extends State<CinemaRoom>{

  @override

  Future<List<dynamic>> chairsBooked = ChairsBooked().getChairs();

  final int chairPrice = 7;
  dynamic snackBar = SnackBar(
    backgroundColor: const Color(0xFFDC0000),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("You did not choose any seat", style: TextStyle(fontSize: 18),)
      ],
    ),
  );

  List numbers = new List<int>.generate(80, (i) => i + 1);
  late List <Color> colors = <Color>[];

  Film get film => widget.film;

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
          centerTitle: true,
          title: buildText(text: "Cinema Room", size: 24),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 620,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: width,
                            height: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF4C6793),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      film.thumbLink
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(70),
                                  topRight: Radius.circular(70),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder <List<dynamic>>(
                            future: chairsBooked,
                            builder: (context, snapshot){
                              if (snapshot.hasData) {
                                List<dynamic> chairs = snapshot.data ?? [];
                                generateColorList(chairsBooked: chairs);
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 8,
                                  ),
                                  itemBuilder: (context, index){
                                    return InkWell(
                                      onTap: () => onTap(chairIndex: index),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: Color(0xFF000000),
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                        color: colors[index],
                                        child: const Icon(
                                            Icons.event_seat
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: numbers.length,
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24,),
                    Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              buildContainerRoom(text: "- Available", color: const Color(0xFFEEEEEE)),
                              buildContainerRoom(text: "- Non avaliable", color: const Color(0xFFDC0000)),
                              buildContainerRoom(text: "- Selected", color: const Color(0xFFFFFF00)),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFFF00).withOpacity(0.9),
                            ),
                            onPressed: onPressed,
                            child: const Icon(Icons.navigate_next, size: 50,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  generateColorList({required List<dynamic> chairsBooked}) {

    for (var i = 0; i < 80; i++) {
      colors.add(const Color(0xFFEDE9D5)); //0xFFEDE9D5
    }

    for (var id in chairsBooked) {
      id = id - 1;
      for (var i = 0; i < 80; i++) {
        if (id == i) {
          colors[i] = const Color(0xFFDC0000);
        }
      }
    }
  }

  onTap({required int chairIndex}){
    setState(() {
      if (colors[chairIndex] == const Color(0xFFEDE9D5)) {
        colors[chairIndex] = const Color(0xFFFFFF00);
      } else {
        if (colors[chairIndex] == const Color(0xFFFFFF00)) {
          colors[chairIndex] = const Color(0xFFEDE9D5);
        }
      }
    });
  }

  onPressed() async {
    List<int> chairsIndex = <int>[];

    for (var i = 0; i < colors.length; i++) {
      if (colors[i] == const Color(0xFFFFFF00)) {
        chairsIndex.add(i + 1);
      }
    }

    if (chairsIndex.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await BookingSharedPreferencesHelper().storeChairsIDs(chairsIDs: chairsIndex);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context){return CinemaFood(chairsBooked: chairsIndex, totalPrice: chairsIndex.length * chairPrice,);}),
      );
    }
  }

  buildText({required String text, required double size}){
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: size,
        color: const Color(0xFFEEEEEE),
      ),
    );
  }

  buildContainerRoom({required String text, required Color color}){
    return Container(
      width: 200,
      child: Row(
        children: [
          Card(
            color: color,
            child: const Icon(
                Icons.event_seat
            ),
          ),
          buildText(text: '$text', size: 18),
        ],
      ),
    );
  }

}
