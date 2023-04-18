import 'package:cinema/data/api/get/search_costumer.dart';
import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:cinema/pages/create_account.dart';
import 'package:cinema/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key,}) : super(key: key);
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{

  @override

  bool hover = true;
  Color colorEnter = const Color(0xFFE6B325);
  Color colorExit = const Color(0xFF4C6793);

  dynamic snackBar = SnackBar(
    backgroundColor: const Color(0xFFDC0000),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Email or password are incorrect", style: TextStyle(fontSize: 18),)
      ],
    ),
  );

  Future<bool> stateLogin = CostumerSharedPreferencesHelper().getLoginState();

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      color: const Color(0xFFFFFF00).withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: const BorderSide(
                          color: Color(0xFF000000),
                          width: 1.7,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            AspectRatio(
                              aspectRatio: 4/3,
                              child: Image.network("https://img.freepik.com/vetores-gratis/fundo-retro-do-cinema_52683-1701.jpg", height: 172,),
                            ),
                            SizedBox(
                              height: 292,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      keyboardType: TextInputType.emailAddress,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: buildTextUnderlined(text: "create account", size: 18, color: colorExit),
                                  onTap: onTap,
                                ),
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
            ),
          ],
        ),
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

  buildTextUnderlined({required String text, required double size, required Color color}){
    return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.underline,
        color: color,
        fontSize: size,
      ),
    );
  }

  onPressed() async {
    if (_formKey.currentState!.validate()) {
      final costumer = Costumer(name: '', email: emailController.text, password: passwordController.text, logged: true);
      await CostumerSharedPreferencesHelper.storeCostumerData(costumer: costumer);
      bool logged = await Login().searchForAccount();
      await CostumerSharedPreferencesHelper().storeLoginState(logged: logged);
      bool state = await CostumerSharedPreferencesHelper().getLoginState();

      if (state) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context){return const CinemaHomePage();}
            ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  onTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return const CreateAccount();
            },
        ),
    );
  }
}
