class Film{

  late final String thumbLink;
  late final String film;
  late final String synopsis;
  late final String date;
  late final String time;
  late final int room;

  Film({required this.thumbLink, required this.film, required this.synopsis, required this.date, required this.time, required this.room});

  Film.fromJson(Map<String, dynamic> json){

  }
}
