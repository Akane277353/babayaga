import 'dart:convert';
import 'dart:ffi';

import 'package:babayagamobile/class/HistoireJson.dart';
import 'package:babayagamobile/fight/prepareTeam.dart';
import 'package:babayagamobile/homescreen.dart';
import 'package:babayagamobile/serv/connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:swipe/swipe.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';

import '../class/PersonnageJson.dart';

class Token extends StatefulWidget {
  final String tok;

  Token(this.tok, {super.key});

  @override
  _Token createState() => _Token(tok);
}

class _Token extends State<Token> {
  _Token(tok);

  /*
  view
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/images/fond/landscape4.png"),
              fit: BoxFit.cover,
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Text(
                widget.tok,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
                  ElevatedButton(onPressed: () {
                    Navigator.push(context, PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          print(widget.tok);
                          return HomeScreen();
                        }));
                  },
                      child: Text("menu")),
            ],
          ),
        )
    );
  }
}