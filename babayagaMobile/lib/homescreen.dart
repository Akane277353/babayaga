import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              print("YO");
            },
            child: Text("babayaga")
        ),
        ElevatedButton(
            onPressed: () {
              print("YOOO");
            },
            child: Text("YO")
        )
      ],
    ),
    )
    );

  }
}
