import 'package:cinema/data/api/get/films.dart';
import 'package:cinema/data/shared_preferences/booking_shared_preferences.dart';
import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/film.dart';
import 'package:cinema/pages/reservs.dart';
import 'package:cinema/pages/login_page.dart';
import 'package:cinema/widget/booking.dart';
import 'package:flutter/material.dart';

class FilmsAvailable extends StatefulWidget {

  const FilmsAvailable({Key? key,}) : super(key:key);
  @override
  _FilmsAvailable createState() => _FilmsAvailable();
}

class _FilmsAvailable extends State<FilmsAvailable>{

  Future<List<Film>> filmsList = FilmsInContext().getFilmsAvailable();

  @override
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
          centerTitle: true,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildText(text: "Films Available", size: 24, color: const Color(0xFFEEEEEE)),
                //move the inkwell to Account Page later
                InkWell(
                  child: const Icon(
                    Icons.exit_to_app,
                    size: 32,
                    color: Color(0xFFFF1E1E),
                  ),
                  onTap: onTapLogOff,
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 800,
                  width: 500,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                      Container(
                        height: 800,
                        child: FutureBuilder <List<Film>>(
                          future: filmsList,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Film> films = snapshot.data ?? [];
                              return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: films.length,
                                  separatorBuilder: (context, index) {return const SizedBox(width: 18,);},
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: 400,
                                      width: 300,
                                      child: Column(
                                        children: [
                                          InkWell(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  color: Color(0xFFEEEEEE),
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.network(
                                                  height: 400,
                                                  width: 300,
                                                  films[index].thumbLink,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            onTap: () => onTap(film: films[index]),
                                          ),
                                          SizedBox(
                                            height: 200,
                                            width: 300,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 children: [
                                                   const Icon(Icons.watch_later_outlined, color: Color(0xFFEEEEEE),),
                                                   const SizedBox(width: 4,),
                                                   buildText(text: films[index].duration, size: 24, color: const Color(0xFFEEEEEE)),
                                                 ],
                                               ),
                                                const SizedBox(height: 12,),
                                                buildText(text: films[index].name, size: 32, color: const Color(0xFFEEEEEE)),
                                                const SizedBox(height: 12,),
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                      color: Color(0xFF000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  color: Colors.grey.shade800,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(9.2),
                                                    child: buildText(text: films[index].gender, size: 18, color: const Color(0xFFEEEEEE)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              );
                            } else {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Center(child: CircularProgressIndicator()),
                              );
                            }
                          },
                        ),
                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapBookings() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context){
              return const Bookings();
            }),
    );
  }

  onTap({required Film film}) async {

    await BookingSharedPreferencesHelper().storeFilmInfos(filmName: film.name, roomNumber: film.room);

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
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  onTapLogOff() async {
    await CostumerSharedPreferencesHelper().storeLoginState(logged: false);
    bool state = await CostumerSharedPreferencesHelper().getLoginState();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context){
              CostumerSharedPreferencesHelper().cleanCostumerData();
              return const LoginPage();
            },
        ),
    );
  }
}
