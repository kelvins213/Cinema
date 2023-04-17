import 'package:cinema/pages/costumer_profile.dart';
import 'package:cinema/pages/fims_avaliable.dart';
import 'package:cinema/pages/preview.dart';
import 'package:cinema/widget/reservs.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
      bottomNavigationBar: Container(
        color: const Color(0xFF000000),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF000000), width: 1.0),
              borderRadius: BorderRadius.circular(6.0),
              color: const Color(0xFFEEEEEE).withOpacity(0.3),
            ),
            child: GNav(
              backgroundColor: const Color(0xFFEEEEEE).withOpacity(0.2),
              color: const Color(0xFF000000),
              activeColor: const Color(0xFFEEEEEE),
              tabBackgroundColor: Colors.grey.shade800,
              padding: const EdgeInsets.all(12),
              tabMargin: const EdgeInsets.all(12),
              gap: 8,
              tabs: const <GButton>[
                GButton(icon: Icons.theaters_outlined, text: 'Movies'),
                GButton(icon: Icons.schedule, text: 'Previews',),
                GButton(icon: Icons.menu_book, text: 'Bookings',),
                GButton(icon: Icons.settings, text: 'Profile',),
              ],
              onTabChange: (index){
                setState(() {
                  currentlyPage = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}