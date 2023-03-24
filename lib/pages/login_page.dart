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

  Future<bool> stateLogin = CostumerSharedPreferencesHelper().getLoginState();

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {

    FutureBuilder(
      builder: ,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF4C6793),
      body: ListView(
        children: [
          FutureBuilder<bool>(
            future: stateLogin,
            builder: (context, snapshot){
              if (snapshot.hasData) {
                bool logged = snapshot.data ?? false;
                if (logged) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context){return const CinemaHomePage();}
                    ),
                  );
                  return Text('');
                  //need to return something to get ride of the error
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Card(
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
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Name",
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return "Input without fulfillment";
                                              }
                                            },
                                          ),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //do it here
                                      MouseRegion(
                                        onEnter: (event){
                                          setState(() {
                                            hover = false;
                                          });
                                        },
                                        onExit: (event){
                                          setState(() {
                                            hover = true;
                                          });
                                        },
                                        child: InkWell(
                                          child:hover==true? buildTextUnderlined(text: "create account", size: 18, color: colorExit) : buildTextUnderlined(text: "create account", size: 18, color: colorEnter),
                                          onTap: onTap,
                                        ),
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
                  );
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
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
      final costumer = Costumer(name: nameController.text, email: emailController.text, password: passwordController.text, logged: true);
      await CostumerSharedPreferencesHelper.storeCostumerData(costumer: costumer);

      bool logged = await Login().searchForAccount();
      await CostumerSharedPreferencesHelper().storeLoginState(logged: logged);
      //deu certo...
      bool state = await CostumerSharedPreferencesHelper().getLoginState();
      print(state);

      if (logged) {
        movePage();
      } else {
        //and return error message
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



  movePage(){
    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context){return const CinemaHomePage();}
        ),
      );
    });
  }

}
