import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Parameter extends StatelessWidget {
  const Parameter({Key? key}) : super(key: key);

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
          constraints: BoxConstraints.expand(),
          child: Text("YOO"),

        )
    );

  }
}
