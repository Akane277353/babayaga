import 'AttackJson.dart';

/*
transforme un json en objet personnage
 */

class Personnage {
  final String nom;
  final int id;
  final int pv;
  final List<Attack> attack;
  final String img;
  final int playable;

  Personnage({
    required this.nom,
    required this.id,
    required this.pv,
    required this.attack,
    required this.img,
    required this.playable
  });

  factory Personnage.fromJson(Map<String, dynamic> json) {
    List<Attack> att = [];
    for (int i = 0; i < json["attack"].length; i++) {
      att.add(Attack.fromJson(json["attack"], i));
    }
    print(att[0].degat);
    return Personnage(
      id: json['id'],
      nom: json['nom'],
      pv: json['pv'],
      img: json['img'],
      playable: json['playable'],
      attack:  att,
    );
  }
}