// https://hackernoon.com/creating-a-custom-listview-using-the-firebase-realtime-database-in-flutter-j02xw3w6z
import 'dart:convert';
import 'package:Prontuario_Guardie_Zoofile/model/Articolo.dart';
import 'package:firebase_database/firebase_database.dart';

class MakeCall{

  List<Articolo> listItems=[];

  Future<List<Articolo>> firebaseCalls (DatabaseReference databaseReference) async{
    DataSnapshot dataSnapshot = await databaseReference.once();
    var jsonResponse = dataSnapshot.value['masterSheet'];
//    for(var i = 1; i < jsonResponse.length; i++) {
//      var a = jsonResponse[i];
//      listItems.add(Articolo(a[0],a[1],a[2],a[3]));
//    }
    List<Articolo> list = parseArticolo(jsonResponse);
    return list;
  }

  static List<Articolo> parseArticolo (List<dynamic> responseBody){
//    final parsed = responseBody.cast<Map<String, dynamic>>();
//    return parsed.map<Articolo>((json) => Articolo.fromJson(json)).toList();
    return responseBody.map((json) => Articolo.fromJson(json)).toList();
  }

}
