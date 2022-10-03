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

                children: [
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    iconSize: 100,
                    onPressed:() {
                      print("test");
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context))
                      )
                    },
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
