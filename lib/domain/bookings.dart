class CostumerReservs{

  late final String thumbLink;
  late final String name;
  late final int cod;
  late final String synopsis;
  late final String date;
  late final String time;
  late final int room;
  late final String duration;
  late final String gender;
  late final List<dynamic> chairs;

  CostumerReservs({required this.duration, required this.gender, required this.cod, required this.name, required this.date, required this.time, required this.thumbLink, required this.synopsis, required this.room, required this.chairs});

  CostumerReservs.fromJson(Map<String, dynamic> json){
    cod = json['cod'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    thumbLink = json['thumblink'];
    room = json['room'];
    chairs = json['chairs'];
    synopsis = json['synopsis'];
    duration = json['duration'];
    gender = json['gender'];
  }
}