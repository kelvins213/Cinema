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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
          title: buildText(text: "Previews", size: 24, color: const Color(0xFFEEEEEE)),
          backgroundColor: const Color(0xFF950101),
        ),
          body: ListView(
            children: [
              FutureBuilder<List<CinemaPreview>>(
                future: prevs,
                builder: (context, snaptshot){
                  if (snaptshot.hasData) {
                    List<CinemaPreview> previews = snaptshot.data ?? [];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2
                          ),
                          itemCount: previews.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        previews[index].thumbLink
                                    ),
                                    fit: BoxFit.fitWidth
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: width,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(24),
                                          bottomRight: Radius.circular(24),
                                        ),
                                        color: const Color(0xFFF1F6F9).withOpacity(0.4),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    child: buildText(text: previews[index].name, size: 18, color: const Color(0xFF000000)),
                                                  ),
                                                ),
                                                const SizedBox(height: 12,),
                                                SizedBox(
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    child: buildText(text: previews[index].date, size: 18, color: const Color(0xFF000000)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
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
        fontWeight: FontWeight.w500,
        fontSize: size,
        color: color,
      ),
    );
  }
}


/*
Container(
                              height: 300,
                              width: width * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      previews[index].thumbLink
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 130,
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24),
                                      ),
                                      color: const Color(0xFFF1F6F9).withOpacity(0.4),
                                    ),
                                    child: buildText(text: "testing", size: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),

*/