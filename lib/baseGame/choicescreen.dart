import 'dart:convert';
import 'dart:ffi';

import 'package:babayagamobile/class/HistoireJson.dart';
import 'package:babayagamobile/fight/prepareTeam.dart';
import 'package:babayagamobile/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:swipe/swipe.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';

import '../class/PersonnageJson.dart';

class ChoiceScreen extends StatefulWidget {
  final List<Personnage> perso;
  final List<Histoire> histoire;
  final int startat;
  final int chaos;

  ChoiceScreen(this.perso,this.histoire, this.startat, this.chaos, {super.key});

  @override
  _ChoiceScreen createState() => _ChoiceScreen(perso, histoire, startat, chaos);
}

class _ChoiceScreen extends State<ChoiceScreen> {
  _ChoiceScreen(perso, histoire, startat, chaos);

  late Personnage el = widget.perso.first;
  late Histoire hist = getChoix(widget.startat);
  late List<Histoire> lhist = widget.histoire;
  late int chaos = widget.chaos;

  late Text c1 = Text(hist.choix1.txt);
  late Text c2 = Text(hist.choix2.txt);
  late Text c3 = Text(hist.choix3.txt);
  late Text desc = Text(hist.description);
  late bool visi1 = true;
  late bool visi2 = true;
  late bool visi3 = true;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/images/fond/landscape.png"),//hist.fond
              fit: BoxFit.cover,
            ),
          ),
          constraints: BoxConstraints.expand(),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
              ),

              const Image(
                image: AssetImage('asset/images/personnages/poulpours.png'),//hist.img
                width: 300,
                height: 400,
              ),
              Container(
                  height: 190,
                  child: Card (
                    margin: EdgeInsets.all(10),
                    color: Colors.transparent,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      // if you need this

                    ),

                    elevation: 10,
                    child: Center(
                      child: desc,
                    ),
                  )
              ),

          Visibility(
            visible: visi1,
            child:
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue),
                  onPressed: () {
                    if (hist.combat > 0) {
                      Navigator.push(context, PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return PrepareTeam(widget.perso, hist.combat, lhist, hist.choix1.numerochoix, hist.choix1.numerochoix, chaos); //PrepareTeam(perso);
                          }));
                    }
                    else {
                      if (hist.choix1.id == -1) {
                        Navigator.push(context, PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return HomeScreen();
                            }));
                      }
                      hist = getChoix(hist.choix1.numerochoix)!;
                       chaos += hist.chaos;
                       print(chaos);
                    }
                  },
                  child: c1)),

              Container(
                width: 300,
              child: Row(
                children: [
                  Visibility(
                      visible: visi2,
                      child:
                  Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        hist = getChoix(hist.choix2.numerochoix)!;
                        chaos += hist.chaos;
                        print(chaos);
                      },
                      child: c2))),
                  Visibility(
                    visible: visi3,
                      child:
                  Expanded(child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        hist = getChoix(hist.choix3.numerochoix)!;
                        chaos += hist.chaos;
                        print(chaos);
                      },
                      child: c3))),
                ],
              ),
              )
            ],
          ),
        )
    );
  }

  Histoire getChoix(int numerochoix) {
    Histoire res = lhist.first;
    for (var el in lhist) {
      if (el.id == numerochoix) {
        setState(() {
          c1 = Text(el.choix1.txt);
          if (el.combat > 0) {
            c1 = Text("commencer le combat");
          }
          if (el.choix1.id == -1) {
            c1 = Text("looser");
          }
          c2 = Text(el.choix2.txt);
          c3 = Text(el.choix3.txt);
          desc = Text(el.description);
          visi1 = true;
          visi2 = true;
          visi3 = true;
          if ((c1.data == "" && el.combat != 2) || el.choix1.chaosrequis > chaos) {
            visi1 = false;
          }
          if (c2.data == "" || el.combat == 2 || el.choix2.chaosrequis > chaos) {
            visi2 = false;
          }
          if (c3.data == "" || el.combat == 2 || el.choix3.chaosrequis > chaos) {
            visi3 = false;
          }
        });
        res = el;
      }
    }
    return res;
  }
}
