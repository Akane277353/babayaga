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

  Fight(this.ennemy, this.team, this.perso, this.histoire, this.next, this.lose,
      this.chaos,
      {super.key});

  @override
  _Fight createState() =>
      _Fight(ennemy, team, perso, histoire, next, lose, chaos);
}

class _Fight extends State<Fight> {
  final Personnage ennemy;
  final List<Personnage> team;
  final List<Personnage> perso;
  final List<Histoire> histoire;
  final int next;
  final int chaos;
  final int lose;

  _Fight(this.ennemy, this.team, this.perso, this.histoire, this.next,
      this.lose, this.chaos);

  late var current = team[0];

  //late var enpv = int.parse(ennemy.pv);
  late var enpv = ennemy.pv;
  late var selectAtt = -1;

  @override
  Widget build(BuildContext context) {
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
                      List.generate(1, (index) => buildCard(widget.ennemy)))),
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
                      (index) => buildCard(widget.team[index])))),
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
                              attack();
                            },
                            child: Text(
                                "${current.attack[index].nomAttack}\n           dégats : ${current.attack[index].degat}\n")))))),
      ],
    ));
  }

  Widget buildCard(Personnage item) => Container(
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
            color: alive(item) ? Colors.green : Colors.orange,
            elevation: 20,
            child: Column(
              children: [
                Expanded(
                  child: Material(
                    child: Ink.image(
                      image: AssetImage("asset/images/personnages/perso.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(item.nom),
                if (item == ennemy) ...[
                  Text(enpv.toString()),
                ] else ...[
                  Text(item.pv.toString()),
                ]
              ],
            ),
          ),
        ),
      );

  bool alive(Personnage item) {
    if (item != ennemy) {
      return item.pv > 0;
    }
    return enpv > 0;
  }

  void attack() {
    setState(() {
      enpv -= current.attack[selectAtt].degat;
    });
    if (enpv <= 0) {
      end();
    }
  }

  void end() {
    Navigator.push(context,
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return ChoiceScreen(perso, histoire, next, chaos); //PrepareTeam(perso);
    }));
  }
}
