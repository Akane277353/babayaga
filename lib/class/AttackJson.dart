class Attack {
  final String nomAttack;
  final int degat;

  Attack({
    required this.nomAttack,
    required this.degat,
  });

  factory Attack.fromJson(List<dynamic> json) {
    return Attack(
      degat: json[0]['degat'],
      nomAttack: json[0]['nom'],
    );
  }
}