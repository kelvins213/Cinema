import 'package:cinema/data/bd/cinema_bd.dart';
import 'package:cinema/domain/cinema.dart';
import 'package:cinema/pages/booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CinemaHomePage extends StatefulWidget {

  const CinemaHomePage({Key? key,}) : super(key:key);
  @override
  _CinemaHomePage createState() => _CinemaHomePage();
}

class _CinemaHomePage extends State<CinemaHomePage>{

  List<Film> films = CinemaContents.films;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF000000),
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Booking Stuff",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFEEEEEE),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: onPressed,
                child: buildText(text: "Bookings", size: 24, color: const Color(0xFFEEEEEE)),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF4C6793),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00092C),
        centerTitle: true,
        title: buildText(text: "Films Available", size: 24, color: const Color(0xFFEEEEEE)),
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridTile(
                child: Card(
                  color: const Color(0xFF00092C),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 200,
                            child: InkWell(
                              child: Image.network(films[index].thumbLink),
                              onTap: () => onTap(film: films[index]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        buildText(text: films[index].film, size: 24, color:  const Color(0xFFFCFFE7)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: films.length,
        ),
      ),
    );
  }

  onPressed(){}

  onTap({required Film film}){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) {
            return BookingFilm(film: film);
          },
      ),
    );
  }

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
