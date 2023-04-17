import 'package:cinema/data/shared_preferences/costumer_shared_preferences.dart';
import 'package:cinema/domain/costumer.dart';
import 'package:flutter/material.dart';

class CostumerProfile extends StatefulWidget {
  const CostumerProfile({Key? key}) : super(key: key);

  @override
  State<CostumerProfile> createState() => _CostumerProfileState();
}

class _CostumerProfileState extends State<CostumerProfile> {

  Future<Costumer> costumer = CostumerSharedPreferencesHelper().getCostumerData();

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
        appBar: AppBar(
          backgroundColor: const Color(0xFF950101),
          title: buildText(text: "Profile", size: 24, color: const Color(0xFFEEEEEE)),
        ),
        body: ListView(
         children: [
           FutureBuilder<Costumer>(
              future: costumer,
               builder: (context, snapshot){
                if (snapshot.hasData) {
                  Costumer cos = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: const Color(0xFF000000),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage("https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg"),
                            child: Text(''),
                          ),
                          buildText(text: cos.name, size: 24, color: const Color(0xFFEEEEEE)),
                          buildText(text: cos.email, size: 24, color: const Color(0xFFEEEEEE)),
                          buildText(text: cos.password, size: 24, color: const Color(0xFFEEEEEE)),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              }
           ),
         ],
        ),
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
}
