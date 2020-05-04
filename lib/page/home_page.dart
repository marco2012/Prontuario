import 'dart:math';
import 'package:Prontuario_Guardie_Zoofile/model/Articolo.dart';
import 'package:Prontuario_Guardie_Zoofile/widgets/my_header.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../MakeCall.dart';
import '../constants.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final databaseReference = FirebaseDatabase.instance.reference();
  String bg_image;

  String getBackgroundImage() {
    var rng = new Random().nextInt(6);
    return "assets/images/dogs/dog$rng.jpg";
  }

  List<Articolo> articoli = List();
  List<Articolo> filteredArticoli = List();

  Future<void> _getData() async {
    MakeCall().firebaseCalls(databaseReference).then((articoliFromServer) => {
          setState(() {
            articoliFromServer.removeAt(0);
            articoli = articoliFromServer;
            filteredArticoli = articoli;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    _getData();
    bg_image = getBackgroundImage();
  }

  Widget _buildList() {
    return filteredArticoli.length != 0
        ? RefreshIndicator(
            child: ListView.builder(
              itemCount: filteredArticoli.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  //You need to make my child interactive
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                DetailsScreen(filteredArticoli[index])));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(10),
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 33),
                          blurRadius: 23,
                          spreadRadius: -13,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/law.svg",
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                filteredArticoli[index].titolo,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(filteredArticoli[index].articolo)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            onRefresh: _getData,
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _searchBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Cerca",
          icon: SvgPicture.asset("assets/icons/search.svg"),
          border: InputBorder.none,
        ),
        onChanged: (String query) {
          setState(() {
            filteredArticoli = articoli
                .where((a) => (a.titolo
                        .toLowerCase()
                        .contains(query.toLowerCase()) ||
                    a.articolo.toLowerCase().contains(query.toLowerCase()) ||
                    a.testo.toLowerCase().contains(query.toLowerCase())))
                .toList();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            MyHeader(
              image: bg_image,
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Prontuario \nGuardie Zoofile",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(4.0, 4.0),
                            blurRadius: 4.0,
                            color: Color.fromARGB(128, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                    _searchBar(),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        child: _buildList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
