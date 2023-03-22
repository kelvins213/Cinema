class Film{

  late final String thumbLink;
  late final String name;
  late final String synopsis;
  late final String date;
  late final String time;
  late final int room;

  Film({required this.thumbLink, required this.name, required this.synopsis, required this.date, required this.time, required this.room});

  Film.fromJson(Map<String, dynamic> json){
    name = json['name'];
    date = json['date'];
    time = json['time'];
    thumbLink = json['thumblink'];
    synopsis = json['synopsis'];
    room = json['room'];
  }
}
