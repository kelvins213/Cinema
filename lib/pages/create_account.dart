import 'package:cinema/data/api/post/account.dart';
import 'package:cinema/data/shared_preferences/booking_shared_preferences.dart';
import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:cinema/pages/login_page.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F8A70),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(32),
            child: Card(
              child: SizedBox(
                height: 652,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AspectRatio(
                          aspectRatio: 4/3,
                          child: Image.network("https://www.teahub.io/photos/full/101-1019747_passeio-das-aguas-cinema.jpg", height: 172,),
                        ),
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFBFDB38),
                          ),
                          onPressed: onPressed,
                          child: buildText(text: "Sign Up", size: 24, color: const Color(0xFFEEEEEE)),
                        ),
                      ],
                    ),
                  ),
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

  onPressed() async {
    if (_formKey.currentState!.validate()) {

      print(emailController.text);
      Costumer costumer = Costumer(email: emailController.text, password: passwordController.text, name: nameController.text, logged: false);
      await CostumerSharedPreferencesHelper.storeCostumerData(costumer: costumer);

      bool accountSucceed = await Account().createAccount();
      if (accountSucceed) {
        //showDialog(),

        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return LoginPage();}));
      }
    }
  }
}
