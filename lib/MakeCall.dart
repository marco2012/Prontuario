// https://hackernoon.com/creating-a-custom-listview-using-the-firebase-realtime-database-in-flutter-j02xw3w6z
import 'dart:convert';
import 'package:Prontuario_Guardie_Zoofile/model/Articolo.dart';
import 'package:firebase_database/firebase_database.dart';

class MakeCall{

  List<Articolo> listItems=[];

  Future<List<Articolo>> firebaseCalls (DatabaseReference databaseReference) async{
    DataSnapshot dataSnapshot = await databaseReference.once();
    var jsonResponse = dataSnapshot.value['masterSheet'];
    List<Articolo> list = parseArticolo(jsonResponse);
    return list;
  }

  static List<Articolo> parseArticolo (List<dynamic> responseBody){
    return responseBody.map((json) => Articolo.fromJson(json)).toList();
  }

}
