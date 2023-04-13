import 'package:cinema/data/api/get/previews.dart';
import 'package:cinema/domain/preview.dart';
import 'package:flutter/material.dart';

class Previews extends StatefulWidget {
  const Previews({Key? key}) : super(key: key);

  @override
  State<Previews> createState() => _PreviewsState();
}

class _PreviewsState extends State<Previews> {

  Future<List<CinemaPreview>> prevs = GetPreviews().getPreviews();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4C6793),
      appBar: AppBar(
        title: buildText(text: "Previews", size: 24, color: const Color(0xFFEEEEEE)),
        backgroundColor: const Color(0xFF00092C),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<CinemaPreview>>(
                future: prevs,
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    List<CinemaPreview> previews = snapshot.data ?? [];
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index){
                        return const SizedBox(height: 12,);
                      },
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0xFF000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 344,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Image.network(previews[index].thumbLink, height: 270,),
                                            const SizedBox(height: 9,),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  color: Color(0xFF000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              color: Colors.greenAccent,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: buildText(text: previews[index].name, size: 24, color: const Color(0xFF000000)),),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.greenAccent,
                                                    border: Border.all(color: const Color(0xFF000000), width: 1.2),
                                                    borderRadius: BorderRadius.circular(6.0),
                                                  ),
                                                  height: 270,
                                                  child: ListView(
                                                    children: [
                                                      buildText(text: previews[index].synopsis, size: 24, color: const Color(0xFF000000)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 9,),
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Color(0xFF000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                color: Colors.greenAccent,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: buildText(text: previews[index].date, size: 24, color: const Color(0xFF000000)),),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: previews.length,);
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                }
            ),
          ),
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
