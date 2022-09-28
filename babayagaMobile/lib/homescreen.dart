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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,

          children: const [
            Spacer(),
            Icon(Icons.account_circle_sharp,
              color: Colors.black87,
              size: 100,

            ),
          ],
        ),

        const Text("Babayaga",
        style: TextStyle(
          fontSize: 70,
          fontFamily: 'Osaka',
          color: Colors.white,
        ),
        ),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(220, 100), backgroundColor: Colors.deepOrange),
              onPressed: () {
                print("YO");
              },
              child: Text("Jouer")
          ),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(220, 100), backgroundColor: Colors.deepOrange),
              onPressed: () {
                print("YOOO");
              },
              child: Text("Stat")
          ),




      ],


    ),



    )
    );

  }
}
