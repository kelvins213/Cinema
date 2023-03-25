import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/pages/home_page.dart';
import 'package:cinema/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4C6793),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCFFE7),
                      border: Border.all(
                        width: 1.2,
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
                              backgroundColor: const Color(0xFF03C988),
                            ),
                            onPressed: onPressed,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: const Color(0xFFFCFFE7),
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
        ],
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
