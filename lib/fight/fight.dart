import 'package:babayagamobile/class/PersonnageJson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Fight extends StatefulWidget {
  final Personnage ennemy;
  final List<Personnage> team;

  Fight(this.ennemy,this.team, {super.key});

  @override
  _Fight createState() => _Fight(ennemy, team);
}

class _Fight extends State<Fight> {
  final Personnage ennemy;
  final List<Personnage> team;
  _Fight(this.ennemy,this.team);

  late var current = team[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children: [
            Flexible(
              child: Container(
                child: GridView.count(
                    crossAxisCount: 4,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    //widget.available
                    children: List.generate(
                        1, (index) => buildCard(widget.ennemy)
                    )
                )
              ),
            ),
            Flexible(
              child: Container(
                child: GridView.count(
                    crossAxisCount: 4,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    //widget.available
                    children: List.generate(
                        widget.team.length, (index) => buildCard(widget.team[index])
                    )
                )
              ),
            ),
            Flexible(
              child: Container(
                  child: ListView.builder(
                      itemCount: 5,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Text(current.nom));
                      }),
              ),
            ),
          ],
        )

    );
  }
  Widget buildCard(Personnage item) => Container(
    width: 200,
    child: GestureDetector(
      onTap: () {
          setState(() {
            current = item;
          });
      },
      child: Card(
        color: alive(item) ? Colors.black : Colors.white,
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

  bool alive(Personnage item) {
    return int.parse(item.pv) > 0;
  }

}
