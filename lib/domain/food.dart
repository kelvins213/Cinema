class Food{

  late final int quantPopkorn;
  late final int quantSoda;

  Food({required this.quantPopkorn, required this.quantSoda});

  Food.fromJson(Map<String, dynamic> json){
    quantPopkorn = json['quant_popkorn'];
    quantSoda = json['quant_soda'];
  }
}