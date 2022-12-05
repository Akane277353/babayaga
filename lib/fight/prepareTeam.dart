import 'package:babayagamobile/class/PersonnageJson.dart';
import 'package:babayagamobile/fight/fight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../class/HistoireJson.dart';

class PrepareTeam extends StatefulWidget {
  final List<Personnage> perso;
  final List<Histoire> histoire;
  final int next;

  PrepareTeam(this.perso, this.histoire, this.next, {super.key});

  @override
  _PrepareTeam createState() => _PrepareTeam(perso, histoire, next);
}

class _PrepareTeam extends State<PrepareTeam> {
  _PrepareTeam(perso,histoire, next);

  List<Personnage> liste2 = [];
  late Personnage el = widget.perso.first;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Fight(el, liste2, widget.perso, widget.histoire, widget.next);
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
                widget.perso.length, (index) => buildCard(widget.perso[index])
            )
        )
    );
  }

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
                      image: AssetImage("asset/images/personnages/perso.png"),
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

  void changeTeam(Personnage el) {
    setState(() {
      if (liste2.contains(el)) {
        liste2.remove(el);
      } else {
        liste2.add(el);
      }
    });
  }

  bool inTeam(Personnage el) {
    return liste2.contains(el);
  }
}
