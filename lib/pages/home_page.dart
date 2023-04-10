import 'package:cinema/pages/costumer_profile.dart';
import 'package:cinema/pages/fims_avaliable.dart';
import 'package:cinema/pages/preview.dart';
import 'package:cinema/widget/reservs.dart';
import 'package:flutter/material.dart';

class CinemaHomePage extends StatefulWidget {
  const CinemaHomePage({Key? key}) : super(key: key);

  @override
  State<CinemaHomePage> createState() => _CinemaHomePageState();
}

class _CinemaHomePageState extends State<CinemaHomePage> {

  int currentlyPage = 0;
  List <dynamic> pages = [
    const FilmsAvailable(),
    const Previews(),
    const Bookings(),
    const CostumerProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentlyPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentlyPage,
        onTap: (index) {
          setState(() {
            currentlyPage = index;
          });
        },
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.theaters_outlined), label: 'Films'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Previews'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Reservs'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Account'),
        ],
        selectedItemColor: const Color(0xFF16FF00),
        unselectedItemColor: const Color(0xFFFEFCF3),
        backgroundColor: const Color(0xFF00092C),
      ),
    );
  }
}
