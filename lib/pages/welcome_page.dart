import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/pages/home_page.dart';
import 'package:cinema/pages/login_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFFFD700),  Color(0xFFFFFF00), Color(0xFFF0E68C)],
                      ),
                      border: Border.all(
                        width: 1.7,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Image.network("https://img.freepik.com/vetores-gratis/fundo-retro-do-cinema_52683-1701.jpg", height: 172,),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00235B),
                              side: const BorderSide(width: 1.2),
                            ),
                            onPressed: onPressed,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xFFFCFFE7),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onPressed() async {
    bool state = await CostumerSharedPreferencesHelper().getLoginState();

    if (state) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context){return CinemaHomePage();}),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context){return LoginPage();}),
      );
    }
  }
}
