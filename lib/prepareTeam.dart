import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class  CardItem{
  final String image;
  final String name;
  final int pv;

const CardItem({
    required this.image,
    required this.name,
    required this.pv,
});
}

class PrepareTeam extends StatefulWidget {
  const PrepareTeam(List<String> team, List<String> available, {super.key});

  get team => null;
  get available => null;

  @override
  _PrepareTeam createState() => _PrepareTeam(team, available);
}

class _PrepareTeam extends State<PrepareTeam>{
  bool display = false;

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

  List<CardItem> liste2 = [];
  late CardItem el = items.first;

  _PrepareTeam(team, available);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/images/personnages/babayaga.png"),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              const Text("My Team :", style: TextStyle(
                color: Colors.white,
                fontSize: 60,
              ),
              ),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 160.0,
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (context, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => buildCard(items[index], ),
                ),
              ),
              const Text("Available Character", style: TextStyle(
                color: Colors.white,
                fontSize: 60,
              ),
              ),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 160.0,
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  scrollDirection: Axis.horizontal,
                  itemCount: liste2.length,
                  separatorBuilder: (context, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => buildCard(liste2[index]),
                ),
              ),
              if (display)...[
                Container(
                  child: displayInfo(el, display)
                )
              ]else...[
                Container(
                  child: const Text("none selected")
                )
              ]
            ],
          )
      ),
    );
  }

  Widget buildCard(CardItem item) => Container(
    width: 200,
    child: Column(
      children: [
        Expanded(
            child: AspectRatio(
              aspectRatio: 4/3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Material(
                  child: Ink.image(
                    image: AssetImage(item.image),
                    fit: BoxFit.cover,
                    child: InkWell(
                      onTap: () {
                        if (item != el) {
                          setState((){
                            el = item;
                            display = true;
                          });
                        } else {
                          display = false;
                        }
                      },
                    ),
                  ),
                ),
              ),
            )),
        const SizedBox(height: 4),
        Text(item.name),
      ],
    ),
  );

  Widget displayInfo(CardItem item, bool display) => Container(
    width: 200,
    child: Column(
      children: [
        if (display) (
        Column(
          children: [Text(item.name, style: const TextStyle(
            color: Colors.white,
            fontSize: 60,
          ),
          ),
            Text("pv : ${item.pv}", style: const TextStyle(
              color: Colors.white,
              fontSize: 60,
            ),
            ),
            ElevatedButton(
                onPressed: () {
                  changeTeam(el);
                },
                child: const Text("change team")
            ),
          ],
        )
        ) else (
          const Text("none selected", style: TextStyle(
          color: Colors.white,
          fontSize: 60,
        ),
    )
        ),
      ],
    ),
  );

  void changeTeam(CardItem el) {
    setState(() {
      if (items.contains(el)) {
        items.remove(el);
        liste2.add(el);
      }
      else {
        liste2.remove(el);
        items.add(el);
      }
    });
  }
}

