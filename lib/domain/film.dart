class Film{

  late final String thumbLink;
  late final String name;
  late final String synopsis;
  late final String date;
  late final String time;
  late final String duration;
  late final String gender;
  late final int room;

  Film({required this.thumbLink, required this.name, required this.synopsis, required this.duration, required this.gender, required this.date, required this.time, required this.room});

  Film.fromJson(Map<String, dynamic> json){
    name = json['name'];
    date = json['date'];
    time = json['time'];
    thumbLink = json['thumblink'];
    synopsis = json['synopsis'];
    duration = json['duration'];
    gender = json['gender'];
    room = json['room'];
  }
}
