import 'AttackJson.dart';

class Personnage {
  final String nom;
  final int id;
  final int pv;
  final Attack attack;
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
    return Personnage(
      id: json['id'],
      nom: json['nom'],
      pv: json['pv'],
      img: json['img'],
      playable: json['playable'],
      attack: Attack.fromJson(json['attack']),
    );
  }
}