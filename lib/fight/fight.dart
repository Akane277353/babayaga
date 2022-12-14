import 'dart:math';

import 'package:babayagamobile/class/PersonnageJson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../baseGame/choicescreen.dart';
import '../class/HistoireJson.dart';

class Fight extends StatefulWidget {
  final Personnage ennemy;
  final List<Personnage> team;
  final List<Personnage> perso;
  final List<Histoire> histoire;
  final int next;
  final int lose;
  final int chaos;
  List<int> choix = [];

  Fight(this.ennemy, this.team, this.perso, this.histoire, this.next, this.lose,
      this.chaos, this.choix,
      {super.key});

  @override
  _Fight createState() =>
      _Fight(ennemy, team, perso, histoire, next, lose, chaos, choix);
}

class _Fight extends State<Fight> {
  final Personnage ennemy;
  final List<Personnage> team;
  final List<Personnage> perso;
  final List<Histoire> histoire;
  final int next;
  final int chaos;
  final int lose;
  List<int> choix = [];

  _Fight(this.ennemy, this.team, this.perso, this.histoire, this.next,
      this.lose, this.chaos, this.choix);

  late var current = team[0];

  late var enpv = ennemy.pv;
  late var selectAtt = 0;
  List<dynamic> teampv = [];
  int done = 0;

  /*
  initialize some array
 */
  void init() {
    if (done == 0){
      for (int i = 0; i < team.length; i++) {
        List<dynamic> temp = [];
        temp.add(team[i].nom);
        temp.add(team[i].pv);
        teampv.add(temp);
      }
      done = 1;
    }
  }

  /*
  create the view of the window
 */
  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
        body: Column(
      children: [
        Flexible(
          child: Container(
              child: GridView.count(
                  crossAxisCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  //widget.available
                  children:
                      List.generate(1, (index) => buildCard(widget.ennemy, 0)))),
        ),
        Flexible(
          child: Container(
              child: GridView.count(
                  crossAxisCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  //widget.available
                  children: List.generate(widget.team.length,
                      (index) => buildCard(widget.team[index], index)))),
        ),
        Flexible(
            child: Container(
                child: GridView.count(
                    crossAxisCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    //widget.available
                    children: List.generate(
                        current.attack.length,
                        (index) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(200, 60),
                                backgroundColor: Colors.deepOrange),
                            onPressed: () {
                              selectAtt = index;
                              attack(index);
                            },
                            child: Text(
                                "${current.attack[index].nomAttack}\n           dégats : ${current.attack[index].degat}\n")))))),
      ],
    ));
  }

  /*
  build character card
 */
  Widget buildCard(Personnage item, int nb) => Container(
        width: 200,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (item != ennemy) {
                current = item;
              }
            });
          },
          child: Card(
            color: alive(item, nb) ? Colors.green : Colors.orange,
            elevation: 20,
            child: Column(
              children: [
                Expanded(
                  child: Material(
                    child: Ink.image(
                      image: AssetImage(item.img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(item.nom),
                if (item == ennemy) ...[
                  Text(enpv.toString()),
                ] else ...[
                  Text(teampv[nb][1].toString()),
                ]
              ],
            ),
          ),
        ),
      );

  /*
  retourne true si personnage enn vie
    false si mort
 */
  bool alive(Personnage item, int nb) {
    if (item != ennemy) {
      for (int i = 0; i < teampv.length; i++) {
        if (teampv[i][0] == item.nom){
          return teampv[i][1] > 0;
        }
      }
    }
    return enpv > 0;
  }

  /*
  check if team is dead
 */
  void teamDead() {
    var loose = true;
    for (int i = 0; i < teampv.length; i++) {
      if (teampv[i][1] > 0){
        loose = false;
      }
    }
    if (loose) {
      Navigator.push(context,
          PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
            return ChoiceScreen(perso, histoire, lose, chaos, widget.choix); //PrepareTeam(perso);
          }));
    }
  }

  /*
  a character attack
  the boss attack after him
 */
  void attack(int nb) {
    setState(() {
      if (alive(current, nb)) {
        var cible = Random().nextInt(team.length);
        teampv[cible][1] -= ennemy.attack[Random().nextInt(2)].degat;
        enpv -= current.attack[nb].degat;
      }
      teamDead();
    });
    if (enpv <= 0) {
      end();
    }
  }

  /*
  end of the fight
 */
  void end() {
    Navigator.push(context,
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return ChoiceScreen(perso, histoire, next, chaos, choix); //PrepareTeam(perso);
    }));
  }
}
