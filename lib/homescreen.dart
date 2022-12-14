import 'dart:convert';

import 'package:babayagamobile/fight/prepareTeam.dart';
import 'package:babayagamobile/baseGame/choicescreen.dart';
import 'package:babayagamobile/serv/connection.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'class/HistoireJson.dart';
import 'class/PersonnageJson.dart';
import 'parameter.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  late List<Personnage> perso;
  late List<Histoire> histoire;
  late List<Personnage> rperso;
  late List<Histoire> rhistoire;
  bool bperso = false;
  bool bhistoire = false;
  bool bRperso = false;
  bool bRhistoire = false;

  /*
  init history game mode
 */
  Future init() async {
    perso = await getPersonnageList();
    histoire = await getHistoireList();
    bhistoire = true;
    bperso = true;
  }

  /*
  init random game mode
 */
  Future rinit() async {
    rperso = await getRPersonnageList();
    rhistoire = await getRHistoireList();
    bRperso = true;
    bRhistoire = true;
  }

  /*
  view
 */
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
          const Text(
            "Babayaga",
            style: TextStyle(
              fontSize: 70,
              fontFamily: 'Osaka',
              color: Colors.white,
            ),
          ),
          SizedBox(height: 200),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(140, 60),
                  backgroundColor: Colors.purple),
              onPressed: () {
                init();
                if (bperso && bhistoire) {
                  Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return ChoiceScreen(perso, histoire, 1, 0, []); //1
                      }));
                }
              },
              child: Text("Jouer",  style: TextStyle(fontSize: 25),)),
          SizedBox(height: 100),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(140, 60),
                  backgroundColor: Colors.purple),
              onPressed: () {
                rinit();
                if (bRperso && bRhistoire) {
                  Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return ChoiceScreen(rperso, rhistoire, 1, 0, []); //1
                      }));
                }
              },
              child: Text("random",  style: TextStyle(fontSize: 25),)),
        ],
      ),
    ));
  }
}
