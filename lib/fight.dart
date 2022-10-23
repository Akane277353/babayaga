import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'carditem.dart';

class Fight extends StatefulWidget {
  final CardItem ennemy;
  final List<CardItem> team;

  Fight(this.ennemy,this.team, {super.key});

  @override
  _Fight createState() => _Fight(ennemy, team);
}

class _Fight extends State<Fight> {
  final CardItem ennemy;
  final List<CardItem> team;
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
                            title: Text(current.name));
                      }),
              ),
            ),
          ],
        )

    );
  }
  Widget buildCard(CardItem item) => Container(
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

  bool alive(CardItem item) {
    return item.pv > 0;
  }

}
