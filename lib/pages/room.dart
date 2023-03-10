import 'package:cinema/domain/cinema.dart';
import 'package:cinema/pages/food.dart';
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

  final int chairPrice = 7;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

  generateColorList(){
    for (var i = 0; i < 80; i++) {
      colors.add(const Color(0xFF4C6793));
    }
  }

  Film get film => widget.film;

  Widget build(BuildContext context){
    generateColorList();

    return Scaffold(
      backgroundColor: const Color(0xFF00092C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4C6793),
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
                    height: 600,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 30,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF4C6793),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(360),
                                topRight: Radius.circular(360),
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            child: const Icon(
                              Icons.videocam
                            ),
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                          ),
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: () => onTap(chairIndex: index),
                              child: Card(
                                color: colors[index],
                                child: const Icon(
                                  Icons.event_seat
                                ),
                              ),
                            );
                          },
                          itemCount: numbers.length,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 200,
                              child: Row(
                                children: [
                                  const Card(
                                    color: Color(0xFF4C6793),
                                    child: Icon(
                                        Icons.event_seat
                                    ),
                                  ),
                                  buildText(text: "- Available", size: 18),
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Row(
                                children: [
                                  const Card(
                                    color: Color(0xFFDC0000),
                                    child: Icon(
                                        Icons.event_seat
                                    ),
                                  ),
                                  buildText(text: "- Non available", size: 18),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF03C988),
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
    );
  }

  onTap({required int chairIndex}){
    setState(() {
      if (colors[chairIndex] == const Color(0xFF4C6793)) {
        colors[chairIndex] = const Color(0xFFDC0000);
      } else {
        colors[chairIndex] = const Color(0xFF4C6793);
      }
    });
  }

  onPressed(){
    List<int> chairsIndex = <int>[];

    for (var i = 0; i < colors.length; i++) {
      if (colors[i] == const Color(0xFFDC0000)) {
        chairsIndex.add(i);
      }
    }

    if (chairsIndex.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
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
}
