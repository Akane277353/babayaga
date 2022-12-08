import 'dart:convert';

import 'package:babayagamobile/fight/prepareTeam.dart';
import 'package:babayagamobile/baseGame/choicescreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'class/HistoireJson.dart';
import 'class/PersonnageJson.dart';
import 'parameter.dart';
import 'package:http/http.dart' as http;

class CreateStory extends StatelessWidget {
  CreateStory({Key? key}) : super(key: key);

  late List<Personnage> perso;
  late List<Histoire> histoire;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/images/fond/landscape.png"),
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
            ],
          ),
        ));
  }
}

Future<List<Personnage>> addStory() async {
  String productURl= "http://141.145.200.31:4081/personage";
  final response = await http.get(Uri.parse(productURl));
  List jsonResponse = json.decode(response.body);
  var list = jsonResponse.map((job) => new Personnage.fromJson(job)).toList();
  print(list[0].attack.nomAttack);
  return list;
}

Future<List<Histoire>> addPerso() async {
  String productURl= "http://141.145.200.31:4081/histoire";
  final response = await http.get(Uri.parse(productURl));
  List jsonResponse = json.decode(response.body);
  var list = jsonResponse.map((job) => new Histoire.fromJson(job)).toList();
  print(list[0].choix1.txt);
  return list;
}