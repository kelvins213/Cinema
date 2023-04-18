import 'package:cinema/domain/film.dart';
import 'package:cinema/widget/room.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF950101), Color(0xFF000000)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                    height: 532,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFEEEEEE), width: 1.2),
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: NetworkImage(
                            film.thumbLink
                        ),
                        fit: BoxFit.cover,
                      ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Card(
                            color: const Color(0xFF675D50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Icon(Icons.close_outlined, size: 32, color: Color(0xFFEEEEEE),),
                            ),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          color: const Color(0xFF675D50),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.watch_later_outlined, color: Color(0xFFEEEEEE),),
                                const SizedBox(width: 4,),
                                buildText(text: film.duration, size: 24, weight: FontWeight.normal),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 280,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText(text: film.name, size: 24, weight: FontWeight.bold),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            buildCard(text: film.gender, icon: Icons.history_edu_outlined),
                            buildCard(text: film.date, icon: Icons.date_range),
                            buildCard(text: film.time, icon: Icons.hourglass_bottom_outlined),
                            buildCard(text: film.room, icon: Icons.living),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: buildText(text: film.synopsis, size: 18, weight: FontWeight.w300),
                        ),
                      ),
                      Center(
                        child: FloatingActionButton.extended(
                          onPressed: onPressed,
                          label: buildText(text: "Book", size: 24, weight: FontWeight.bold),
                          backgroundColor: const Color(0xFF950101),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12,),
            ],
          ),
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

  buildText({required String text, required double size, required FontWeight weight}){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: const Color(0xFFEEEEEE),
      ),
    );
  }

  buildCard({required dynamic text, required IconData icon}){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: const Color(0xFF675D50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFEEEEEE),),
            const SizedBox(width: 4,),
            buildText(text: '$text', size: 18, weight: FontWeight.w300)
          ],
        ),
      ),
    );
  }

}