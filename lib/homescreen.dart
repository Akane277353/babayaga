import 'dart:convert';

import 'package:babayagamobile/fight/prepareTeam.dart';
import 'package:babayagamobile/baseGame/choicescreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'class/HistoireJson.dart';
import 'class/PersonnageJson.dart';
import 'parameter.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  late List<Personnage> perso;
  late List<Histoire> histoire;

  Future init() async {
    perso = await getPersonnageList();
    histoire = await getHistoireList();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("asset/images/personnages/babayaga.png"),
          fit: BoxFit.cover,
        ),
      ),
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              IconButton(
                icon: Icon(Icons.account_circle),
                iconSize: 100,
                onPressed: () {
                  print("test");
                  Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return Parameter();
                  }));
                },
              ),
            ],
          ),
          const Text(
            "Babayaga",
            style: TextStyle(
              fontSize: 70,
              fontFamily: 'Osaka',
              color: Colors.white,
            ),
          ),
          SizedBox(height: 300),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(140, 60),
                  backgroundColor: Colors.purple),
              onPressed: () {
                Navigator.push(context, PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return ChoiceScreen(perso, histoire, 1); //PrepareTeam(perso);
                }));
              },
              child: Text("Jouer",  style: TextStyle(fontSize: 25),)),
          SizedBox(height: 200),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(140, 60),
                  backgroundColor: Colors.purple),
              onPressed: () {
                print("YOOO");
              },
              child: Text("Stat",  style: TextStyle(fontSize: 25),)),
        ],
      ),
    ));
  }
}

Future<List<Personnage>> getPersonnageList() async {
  print("comes");
  String productURl= "http://141.145.200.31:4081/personage";

  final response = await http.get(Uri.parse(productURl));
  List jsonResponse = json.decode(response.body);
  var list = jsonResponse.map((job) => new Personnage.fromJson(job)).toList();
  print(list[0].attack.nomAttack);
  return list;
}

Future<List<Histoire>> getHistoireList() async {
  print("comes");
  String productURl= "http://141.145.200.31:4081/histoire";

  final response = await http.get(Uri.parse(productURl));
  List jsonResponse = json.decode(response.body);
  var list = jsonResponse.map((job) => new Histoire.fromJson(job)).toList();
  print(list[0].choix1.txt);
  return list;
}