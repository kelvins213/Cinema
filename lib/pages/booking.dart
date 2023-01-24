import 'package:cinema/domain/cinema.dart';
import 'package:cinema/pages/room.dart';
import 'package:flutter/material.dart';

class BookingFilm extends StatefulWidget {

  final Film film;
  
  const BookingFilm({
    Key? key,
    required this.film,
  }) : super(key: key);
  
  @override
  _BookingFilm createState() => _BookingFilm();
}

class _BookingFilm extends State<BookingFilm> {

  Film get film => widget.film;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00092C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        centerTitle: true,
        title: buildText(text: film.film, size: 24),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    //color: Colors.green,
                    height: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          //color: Colors.yellow,
                          height: 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(film.thumbLink, width: 200,),
                              buildCard(text: film.date, size: 24, icon: Icons.date_range),
                              buildCard(text: film.time, size: 24, icon: Icons.hourglass_bottom),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.00),
                              child: buildText(text: film.synopsis, size: 18),
                            ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 42),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF4C6793),
                    ),
                      onPressed: onPressed,
                      child: buildText(text: "Book", size: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPressed(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context){
          return CinemaRoom(film: film);
        },
      ),
    );
  }

  buildText({required String text, required double size}){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        color: const Color(0xFFEEEEEE),
      ),
    );
  }

  buildCard({required String text, required double size, required IconData icon}){
    return Card(
      color: const Color(0xFF4C6793),
      child: Row(
        children: [
          buildText(text: text, size: size),
          SizedBox(width: 12),
          Icon(icon, size: size),
        ],
      ),
    );
  }
}