import 'package:babayagamobile/fight/fight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../carditem.dart';

class PrepareTeam extends StatefulWidget {
  final List<String> team;
  final List<String> available;

  PrepareTeam(this.team, this.available, {super.key});

  @override
  _PrepareTeam createState() => _PrepareTeam(team, available);
}

class _PrepareTeam extends State<PrepareTeam> {

  List<CardItem> items = [
    const CardItem(
      image: "asset/images/personnages/perso.png",
      name: "pedro",
      pv: 12,
    ),
    const CardItem(
      image: "asset/images/personnages/perso.png",
      name: "pepito",
      pv: 176,
    ),
    const CardItem(
      image: "asset/images/personnages/perso.png",
      name: "miguel",
      pv: -1535,
    ),
  ];

  CardItem ennemy = CardItem(image: "asset/images/personnages/perso.png", name: "bogdanof hun", pv: 1200);

  List<CardItem> liste2 = [];
  late CardItem el = items.first;

  _PrepareTeam(team, available);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Fight(ennemy, liste2);
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
                items.length, (index) => buildCard(items[index])
            )
        )
    );
  }

  Widget buildCard(CardItem item) => Container(
        width: 200,
        child: GestureDetector(
          onTap: () {
            changeTeam(item);
          },
          child: Card(
            color: inTeam(item) ? Colors.black : Colors.white,
            elevation: 20,
            child: Column(
              children: [
                Expanded(
                  child: Material(
                    child: Ink.image(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(item.name),
                Text(item.pv.toString()),
              ],
            ),
          ),
        ),
      );

  void changeTeam(CardItem el) {
    setState(() {
      if (liste2.contains(el)) {
        liste2.remove(el);
      } else {
        liste2.add(el);
      }
    });
  }

  bool inTeam(CardItem el) {
    return liste2.contains(el);
  }
}
