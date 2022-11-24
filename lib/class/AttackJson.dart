class Attack {
  final String nomAttack;
  final int degat;

  Attack({
    required this.nomAttack,
    required this.degat,
  });

  factory Attack.fromJson(Map<String, dynamic> json) {
    return Attack(
      degat: json['degat'],
      nomAttack: json['nomAttack'],
    );
  }
}