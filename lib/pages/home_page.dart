import 'package:cinema/pages/costumer_profile.dart';
import 'package:cinema/pages/fims_avaliable.dart';
import 'package:cinema/pages/preview.dart';
import 'package:cinema/widget/reservs.dart';
import 'package:flutter/gestures.dart';
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
  ];

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: pages[currentlyPage],
      bottomNavigationBar: Container(
        color: const Color(0xFF000000),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF000000), width: 1.0),
              borderRadius: BorderRadius.circular(12.0),
              color: const Color(0xFFEEEEEE).withOpacity(0.6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GNav(
                    activeColor: const Color(0xFFEEEEEE),
                    tabBackgroundColor: Colors.grey.shade800,
                    padding: const EdgeInsets.all(12),
                    tabMargin: const EdgeInsets.all(12),
                    gap: 8,
                    tabs: const <GButton>[
                      GButton(icon: Icons.theaters_outlined, text: 'Movies'),
                      GButton(icon: Icons.schedule, text: 'Previews',),
                      GButton(icon: Icons.menu_book, text: 'Bookings',),
                    ],
                    onTabChange: (index){
                      setState(() {
                        currentlyPage = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}