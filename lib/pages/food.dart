import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CinemaFood extends StatefulWidget {

  const CinemaFood({Key? key,}) : super(key:key);
  @override
  _CinemaFood createState() => _CinemaFood();
}

class _CinemaFood extends State<CinemaFood>{

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF00092C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        centerTitle: true,
        title: buildText(text: "Food", size: 24),
      ),
      body: ListView(
        children: [

        ],
      ),
    );
  }

  buildText({required String text, required double size}){
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: size,
        color: Colors.white,
      ),
    );
  }
}