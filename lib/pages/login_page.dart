import 'package:cinema/data/bd/cinema_bd.dart';
import 'package:cinema/domain/user.dart';
import 'package:cinema/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{

  const LoginPage({Key? key,}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
  
  User user = CinemaContents.user;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF4C6793),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    AspectRatio(
                      aspectRatio: 4/3,
                      child: Image.network("https://img.freepik.com/vetores-gratis/fundo-retro-do-cinema_52683-1701.jpg", height: 172,),
                    ),
                    SizedBox(
                      height: 200,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Input without fulfillment";
                                }
                              },
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Input without fulfillment";
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00092C),
                            ),
                            onPressed: onPressed,
                            child: buildText(text: "Login", size: 18, color: const Color(0xFFEEEEEE))
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildText({required String text, required double size, required Color color}){
      return Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: size,
        ),
      );
  }

  onPressed(){
    final bool firstState = emailController.text == user.email;
    final bool secondState = passwordController.text == user.password;

    if (_formKey.currentState!.validate()) {
      if (firstState && secondState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context){return const CinemaHomePage();}
          ),
        );
      }
    }
  }
}

//747610JF