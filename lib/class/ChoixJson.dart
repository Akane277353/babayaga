
/*
transforme un json en objet choix
 */

class Choix {
  final int id;
  final String txt;
  final int chaosrequis;
  final int numerochoix;
  final List<dynamic> choixrequis;

  Choix({
    required this.id,
    required this.txt,
    required this.chaosrequis,
    required this.numerochoix,
    required this.choixrequis
  });

  factory Choix.fromJson(Map<String, dynamic> json) {
    return Choix(
      id: json["id"],
      txt: json['txt'],
      chaosrequis: json['chaosRequis'],
      numerochoix: json['numeroChoix'],
      choixrequis: json['choixRequis'],
    );
  }
}