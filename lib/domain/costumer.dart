class Costumer{

  late final String email;
  late final String password;
  late final String name;
  late final bool logged;

  Costumer({required this.email, required this.password, required this.name, required this.logged});

  Costumer.fromJson(Map<String, dynamic> json){
    logged = json['condicion'];
  }

}