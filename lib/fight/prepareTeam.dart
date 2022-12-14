import 'package:babayagamobile/class/PersonnageJson.dart';
import 'package:babayagamobile/fight/fight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../class/HistoireJson.dart';

class PrepareTeam extends StatefulWidget {
  final List<Personnage> perso;
  final int id;
  final List<Histoire> histoire;
  final int next;
  final int lose;
  final int chaos;
  List<int> choix = [];


  PrepareTeam(this.perso, this.id, this.histoire, this.next, this.lose, this.chaos, this.choix, {super.key});

  @override
  _PrepareTeam createState() => _PrepareTeam(perso, id, histoire, next, lose, chaos, choix);
}

class _PrepareTeam extends State<PrepareTeam> {
  _PrepareTeam(perso, id, histoire, next, lose, chaos, choix);

  List<Personnage> liste2 = [];
  late Personnage el = widget.perso.first;

  late List<Personnage> playable = canplay(widget.perso);

  /*
  view of the window
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Fight(findEnnemy(), liste2, widget.perso, widget.histoire, widget.next, widget.lose, widget.chaos, widget.choix);
              }));
        },
        label: const Text('start fight'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            //widget.available
            children: List.generate(
                widget.perso.length, (index) => buildCard(playable[index])
            )
        )
    );
  }

  /*
  build character card
 */
  Widget buildCard(Personnage item) => Container(
        width: 200,
        child: GestureDetector(
          onTap: () {
            changeTeam(item);
          },
          child: Card(
            color: inTeam(item) ? Colors.green : Colors.white,
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
                Text(item.pv.toString()),
              ],
            ),
          ),
        ),
      );

  /*
  change character team
 */
  void changeTeam(Personnage el) {
    setState(() {
      if (liste2.contains(el)) {
        liste2.remove(el);
      } else {
        liste2.add(el);
      }
    });
  }

  /*
  check if character in team
 */
  bool inTeam(Personnage el) {
    return liste2.contains(el);
  }

  /*
  check if character is playable
 */
  List<Personnage> canplay(List<Personnage> perso) {
    List<Personnage> l = [];
    for (int i = 0; i < perso.length; i++) {
      if (perso[i].playable == 1) {
        l.add(perso[i]);
      }
    }
    return l;
  }

  /*
  find the ennemy
 */
  Personnage findEnnemy() {
    Personnage el = widget.perso.first;
    for (int i = 0; i < widget.perso.length; i++) {
      if (widget.perso[i].id == widget.id) {
        el = widget.perso[i];
      }
    }
    return el;
  }
}
