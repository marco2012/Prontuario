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
  List<String> comuni = ['Caricamento...'];
  Future<void> _getComuni() async {
    MakeCall()
        .firebaseCalls(FirebaseDatabase.instance.reference())
        .then((articoliFromServer) => {
              setState(() {
                articoliFromServer.removeAt(0);
                comuni =
                    articoliFromServer.map((a) => a.comune).toSet().toList();
                comuni.insert(0, "Tutti");
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
          title: Text(
            comune,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
//          subtitle: Text(user.lastName),
          onChanged: (currentComune) {
            setState(() {
              selectedComune = currentComune;
            });
            preferences.then((pref) => pref.setString('comune', currentComune));
          },
          selected: selectedComune == comune,
          activeColor: colorPrimary,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Seleziona Comune \ndi interesse",
                  style: TextStyle(
                      color: Colors.black87.withOpacity(0.8),
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: createRadioListUsers(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
