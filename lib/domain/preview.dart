class CinemaPreview{

  late final String name;
  late final String date;
  late final String thumbLink;
  late final String synopsis;

  CinemaPreview({required this.name, required this.date, required this.thumbLink, required this.synopsis});

  CinemaPreview.fromJson(Map<String, dynamic> json){
    name = json['name'];
    date = json['date'];
    thumbLink = json['thumblink'];
    synopsis = json['synopsis'];
  }

}