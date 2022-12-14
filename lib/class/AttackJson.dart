
/*
transforme un json en objet attaque
 */

class Attack {
  final String nomAttack;
  final int degat;

  Attack({
    required this.nomAttack,
    required this.degat,
  });

  factory Attack.fromJson(List<dynamic> json, int i) {
    return Attack(
      degat: json[i]['degat'],
      nomAttack: json[i]['nom'],
    );
  }
}