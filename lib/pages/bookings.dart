import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bookings extends StatefulWidget {

  const Bookings({Key? key,}) : super(key: key);

  @override
  _Bookings createState() => _Bookings();
}

class _Bookings extends State<Bookings>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF4C6793),
      body: ListView(
        children: [
          Text("teste"),
        ],
      ),
    );
  }
}