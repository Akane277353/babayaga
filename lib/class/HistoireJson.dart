import 'ChoixJson.dart';

class Histoire {
  final String description;
  //, img, fond, combat
  final int id, chaos;
  final Choix choix1, choix2, choix3;

  Histoire({
    required this.description,
    //required this.img,
    //required this.fond,
    required this.id,
    required this.chaos,
    //required this.combat,
    required this.choix1,
    required this.choix2,
    required this.choix3
  });

  factory Histoire.fromJson(Map<String, dynamic> json) {
    return Histoire(
      description: json['description'],
      //img: json['img'],
      //fond: json['fond'],
      id: json['id'],
      chaos: json['chaos'],
      //combat: json['combat'],
      choix1: Choix.fromJson(json['choix1']),
      choix2: Choix.fromJson(json['choix2']),
      choix3: Choix.fromJson(json['choix3']),
    );
  }
}