
import 'dart:convert';

import '../class/HistoireJson.dart';
import '../class/PersonnageJson.dart';
import 'package:http/http.dart' as http;


Future<List<Personnage>> getPersonnageList() async {
  String productURl= "http://141.145.200.31:4081/admin/perso/ls";
  final response = await http.get(Uri.parse(productURl));
  List jsonResponse = json.decode(response.body);
  var list = jsonResponse.map((job) => new Personnage.fromJson(job)).toList();
  return list;
}

Future<List<Histoire>> getHistoireList() async {
  String productURl= "http://141.145.200.31:4081/admin/histoire/ls";
  final response = await http.get(Uri.parse(productURl));
  List jsonResponse = json.decode(response.body);
  var list = jsonResponse.map((job) => new Histoire.fromJson(job)).toList();
  return list;
}

Future<List<Personnage>> getRPersonnageList() async {
  String productURl= "http://141.145.200.31:4081/perso/ls";
  final response = await http.get(Uri.parse(productURl));
  List jsonResponse = json.decode(response.body);
  var list = jsonResponse.map((job) => new Personnage.fromJson(job)).toList();
  return list;
}

Future<List<Histoire>> getRHistoireList() async {
  String productURl= "http://141.145.200.31:4081/histoire/ls";
  final response = await http.get(Uri.parse(productURl));
  List jsonResponse = json.decode(response.body);
  var list = jsonResponse.map((job) => new Histoire.fromJson(job)).toList();
  return list;
}

Future<String> sendData(List<int> array) async {
  String res = "";
  for (int i = 0; i < array.length; i++) {
    if (i != 0) {
      res += "!" + array[i].toString();
    }
    else {
      res += array[i].toString();
    }
  }
  print(res);
  String productURl= "http://141.145.200.31:4081/admin/state/add";
  final http.Response response = await http.post(
    Uri.parse(productURl),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: "choix=" + res,
  );
  return response.body;
}