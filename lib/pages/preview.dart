import 'package:flutter/material.dart';

class Previews extends StatefulWidget {
  const Previews({Key? key}) : super(key: key);

  @override
  State<Previews> createState() => _PreviewsState();
}

class _PreviewsState extends State<Previews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4C6793),
      appBar: AppBar(
        title: buildText(text: "Previews", size: 24, color: const Color(0xFFEEEEEE)),
        backgroundColor: const Color(0xFF00092C),
      ),
      body: ListView(
        children: const [
          Text("data"),
        ],
      ),
    );
  }

  buildText({required String text, required double size, required Color color}){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: size,
        color: color,
      ),
    );
  }


}
