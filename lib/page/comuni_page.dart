// https://www.coderzheaven.com/2019/01/27/radio-radiolisttile-in-flutter-android-ios/
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MakeCall.dart';
import '../constants.dart';

class TimeValue {
  final int _key;
  final String _value;

  TimeValue(this._key, this._value);
}

class ComuniPage extends StatefulWidget {
  @override
  ComuniPageState createState() => ComuniPageState();
}

class ComuniPageState extends State<ComuniPage> {
  final preferences = SharedPreferences.getInstance();

  String selectedComune;

  _loadComune() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedComune = (prefs.getString('comune') ?? '');
    });
  }

  List<String> comuni = [];
  Future<void> _getComuni() async {
    MakeCall()
        .firebaseCalls(FirebaseDatabase.instance.reference())
        .then((articoliFromServer) => {
              setState(() {
                articoliFromServer.removeAt(0);
                comuni = articoliFromServer.map((a) => a.comune).toSet().toList();
              })
            });
  }

  @override
  void initState() {
    super.initState();
    _loadComune();
    _getComuni();
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (String comune in comuni) {
      widgets.add(
        RadioListTile(
          value: comune,
          groupValue: selectedComune,
          title: Text(comune),
//          subtitle: Text(user.lastName),
          onChanged: (currentComune) {
            setState(() {
              selectedComune = currentComune;
            });
            preferences.then((pref) => pref.setString('comune', currentComune));
          },
          selected: selectedComune == comune,
          activeColor: Colors.green,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleziona comune"),
        backgroundColor: colorPrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: createRadioListUsers(),
          ),
        ],
      ),
    );
  }
}
