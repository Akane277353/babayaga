import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:swipe/swipe.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';


class Choicescreen extends StatelessWidget {
  const Choicescreen({Key? key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,


              ),

              const Image(
                image: AssetImage('asset/images/personnages/poulpours.png'),
                width: 300,
                height: 400,


              ),

              Swipe(
                child:  AnimatedButton(
                  text: 'Choix 1',
                  selectedTextColor: Colors.black,
                  transitionType: TransitionType.BOTTOM_TO_TOP,
                  width: 150,
                  height: 50,
                  textStyle: const TextStyle(


                      color: Colors.deepOrange,
                      ),
                  onPress: () {

                },
                ),
                onSwipeUp: () {
                  print("OUAI");
                },

              ),
              const Card(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: Center(child: Text('Choix 2')),
                ),
              ),

              const Card(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: Center(child: Text('Choix 3')),
                ),
              ),

            ],

          ),

        )
    );

  }
}
