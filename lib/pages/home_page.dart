import 'package:cinema/data/api/get/films.dart';
import 'package:cinema/data/shared_preferences/booking_shared_preferences.dart';
import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/film.dart';
import 'package:cinema/widget/reservs.dart';
import 'package:cinema/pages/login_page.dart';
import 'package:cinema/widget/booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CinemaHomePage extends StatefulWidget {

  const CinemaHomePage({Key? key,}) : super(key:key);
  @override
  _CinemaHomePage createState() => _CinemaHomePage();
}

class _CinemaHomePage extends State<CinemaHomePage>{

  Future<List<Film>> filmsList = FilmsAvailable().getFilmsAvailable();

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: const Color(0xFF4C6793),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00092C),
        centerTitle: true,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Icon(
                  Icons.sticky_note_2_sharp,
                  size: 32,
                  color: const Color(0xFF16FF00),
                ),
                onTap: onTapBookings,
              ),
              buildText(text: "Films Available", size: 24, color: const Color(0xFFEEEEEE)),
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
        child: FutureBuilder<List<Film>>(
          future: filmsList,
          builder: (context, snapshot){
            if (snapshot.hasData) {
              List films = snapshot.data ?? [];
              return GridView.builder(
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
                              buildText(text: films[index].name, size: 24, color:  const Color(0xFFFCFFE7)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: films.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  onTapBookings() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context){
              return Bookings();
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
        color: color,
      ),
    );
  }

  onTapLogOff() async {

    await CostumerSharedPreferencesHelper().storeLoginState(logged: false);
    //deu certo!
    bool state = await CostumerSharedPreferencesHelper().getLoginState();
    print(state);

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
