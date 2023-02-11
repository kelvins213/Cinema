import 'package:flutter/material.dart';

class CinemaFood extends StatefulWidget {

  final List<int> chairsBooked;

  const CinemaFood({
    Key? key,
    required this.chairsBooked,
  }) : super(key: key);

   @override
  _CinemaFood createState() => _CinemaFood();
}

class _CinemaFood extends State<CinemaFood>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<int> get chairs => widget.chairsBooked;
  int chairPrice = 7;
  int popcornPrice = 0;
  int sodaPrice = 0;
  int totalPrice = 0;

  Widget build(BuildContext context){

    chairPrice = chairPrice * chairs.length;
    totalPrice = totalPrice + chairPrice;

    return Scaffold(
      backgroundColor: const Color(0xFF00092C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        centerTitle: true,
        title: buildText(text: "Food", size: 24, color: const Color(0xFFEEEEEE)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Card(
                    color: Color(0xFFDC0000),
                    child: Icon(
                      Icons.event_seat,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    child: Card(
                      color: const Color(0xFF000000),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: chairs.length,
                          itemBuilder: (context, index){
                            String text = chairs[index].toString();
                            return buildText(text: text, size: 24, color: const Color(0xFFEEEEEE));
                            },
                          separatorBuilder: (context, index){
                            return const SizedBox(width: 8);
                            },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                height: 600,
                width: 298,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network("https://st2.depositphotos.com/5823990/11304/i/450/depositphotos_113044302-stock-photo-glass-bowl-with-popcorn-isolated.jpg", width: 158,),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00092C),
                            ),
                            onPressed: () => onPressed(value: - 5, type: "popcorn", operation: "-"),
                            child: const Icon(
                                Icons.remove
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00092C),
                            ),
                            onPressed: () => onPressed(value: 5, type: "popcorn", operation: "+"),
                            child: const Icon(
                                Icons.add
                            ),
                          ),
                          Card(
                            color: const Color(0xFF03C988),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.monetization_on),
                                  Text(
                                    '$popcornPrice',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network("https://www.emporiofreicaneca.com.br/wp-content/uploads/2022/11/Coca-Cola-350ml.png", width: 158,),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00092C),
                            ),
                            onPressed: () => onPressed(value: - 2, type: "soda", operation: "-"),
                            child: const Icon(
                              Icons.remove,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00092C),
                            ),
                            onPressed: () => onPressed(value: 2, type: "soda", operation: "+"),
                            child: const Icon(
                                Icons.add
                            ),
                          ),
                          Card(
                            color: const Color(0xFF03C988),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.monetization_on),
                                  Text(
                                    '$sodaPrice',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            color: const Color(0xFF03C988),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.monetization_on),
                                  Text(
                                    '$totalPrice',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
    );
  }

  buildText({required String text, required double size, required Color color}){
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: size,
        color: color,
      ),
    );
  }

  onPressed({required int value, required String type, required String operation}){
    setState(() {
      if (type == "popcorn") {
        if (operation == "+") {
          popcornPrice = popcornPrice + value;
        } else {
          if (popcornPrice >= 5) {
            popcornPrice = popcornPrice + value;
          }
        }
      } else {
        if (operation == "+") {
          sodaPrice = sodaPrice + value;
        } else {
          if (sodaPrice >= 2) {
            sodaPrice = sodaPrice + value;
          }
        }
      }

      totalPrice = popcornPrice + sodaPrice;
    });
  }
}