import 'AttackJson.dart';

class Personnage {
  final String nom;
  final int id;
  final String pv;
  final Attack attack;

  Personnage({
    required this.nom,
    required this.id,
    required this.pv,
    required this.attack
  });

  factory Personnage.fromJson(Map<String, dynamic> json) {
    return Personnage(
      id: json['id'],
      nom: json['nom'],
      pv: json['pv'],
      attack: Attack.fromJson(json['attack']),
    );
  }
}