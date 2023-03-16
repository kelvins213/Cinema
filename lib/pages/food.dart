import 'package:cinema/data/shared_preferences/booking_shared_preferences.dart';
import 'package:cinema/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CinemaFood extends StatefulWidget {

  final List<int> chairsBooked;
  int totalPrice;

  CinemaFood({
    Key? key,
    required this.chairsBooked,
    required this.totalPrice,
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
  int get  totalPrice => widget.totalPrice;

  int chairPrice = 7;
  int totalPopcornPrice = 0;
  int totalSodaPrice = 0;
  int popPrice = 5;
  int sodaPrice = 2;

  Widget build(BuildContext context){

    //0xFF4C6793
    return Scaffold(
      backgroundColor: const Color(0xFF4C6793),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00092C),
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
                            onPressed: () => onPressed(value: - popPrice, type: "popcorn", operation: "-"),
                            child: const Icon(
                                Icons.remove
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00092C),
                            ),
                            onPressed: () => onPressed(value: popPrice, type: "popcorn", operation: "+"),
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
                                    '$totalPopcornPrice',
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
                            onPressed: () => onPressed(value: - sodaPrice, type: "soda", operation: "-"),
                            child: const Icon(
                              Icons.remove,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00092C),
                            ),
                            onPressed: () => onPressed(value: sodaPrice, type: "soda", operation: "+"),
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
                                    '$totalSodaPrice',
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
            SizedBox(height: 12),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      showConfirmation();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF03C988),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      size: 50,
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
          totalPopcornPrice = totalPopcornPrice + value;
        } else {
          if (totalPopcornPrice >= popPrice) {
            totalPopcornPrice = totalPopcornPrice + value;
          }
        }
      } else {
        if (operation == "+") {
          totalSodaPrice = totalSodaPrice + value;
        } else {
          if (totalSodaPrice >= sodaPrice) {
            totalSodaPrice = totalSodaPrice + value;
          }
        }
      }
      widget.totalPrice = (totalPopcornPrice + totalSodaPrice + (chairPrice * chairs.length));

      print(totalPrice);
    });
  }

  showConfirmation(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            backgroundColor: const Color(0xFF4C6793),
            title: buildText(text: "Your entry is granted!", size: 24, color: const Color(0xFFEEEEEE)),
            content: SizedBox(
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.check,
                    size: 152,
                    color: Color(0xFF03C988),
                  ),
                  buildText(text: "Total Price: ${chairPrice * chairs.length + totalPopcornPrice + totalSodaPrice} dolars", size: 24, color: const Color(0xFFEEEEEE))
                ],
              ),
            ),
            actions: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      child: buildText(text: "Cancel", size: 24, color: const Color(0xFFEEEEEE)),
                      onPressed: (){
                        return Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC0000),
                      ),
                    ),
                    ElevatedButton(
                      child: buildText(text: "Ok", size: 24, color: const Color(0xFFEEEEEE)),
                      onPressed: () async {

                        await BookingSharedPreferencesHelper().storeFood(quantPopkorn: totalPopcornPrice/5, quantSoda: totalSodaPrice/2);

                        Navigator.of(context).popUntil((route) => route.isFirst); //it gets ride of showDialogue page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context){
                                return const CinemaHomePage();
                              }
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF03C988),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
    );
  }
}