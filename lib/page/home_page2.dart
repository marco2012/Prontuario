import 'dart:math';
import 'package:Prontuario_Guardie_Zoofile/model/Articolo.dart';
import 'package:Prontuario_Guardie_Zoofile/page/settings_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MakeCall.dart';
import '../constants.dart';
import '../utils.dart';
import 'details_page.dart';

String selectedCategorie = "Tutti";
List<Articolo> articoli = List();
List<Articolo> filteredArticoli = List();

class HomePage2 extends StatefulWidget {
  @override
  _HomePageState2 createState() => _HomePageState2();
}

class _HomePageState2 extends State<HomePage2> {
  String comune = '';

  _loadComune() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      comune = (prefs.getString('comune') ?? '');
    });
  }

  List<String> categories = [];

  _handleCategories(List<Articolo> articoli) {
    setState(() {
      categories =
          articoli.map((a) => a.categoria.capitalize()).toSet().toList();
      categories.sort((a, b) => a.toString().compareTo(b.toString()));
      categories.insert(0, "Tutti");
    });
  }

  Future<void> _getData() async {
    _loadComune();
    MakeCall()
        .firebaseCalls(FirebaseDatabase.instance.reference())
        .then((articoliFromServer) => {
              setState(() {
                articoliFromServer.removeAt(0);
                _handleCategories(articoliFromServer);
                if (comune != '' && comune != 'Tutti') {
                  articoli = articoliFromServer
                      .where((a) =>
                          (a.comune.toLowerCase() == comune.toLowerCase()))
                      .toList();
                } else {
                  articoli = articoliFromServer;
                }
                filteredArticoli = articoli;
              })
            });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Widget _buildList() {
    return filteredArticoli.length != 0
        ? RefreshIndicator(
            child: ListView.builder(
              itemCount: filteredArticoli.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.white,
//        elevation: 0.0,
//        brightness: Brightness.light,
//      ),
      body: SingleChildScrollView(
        child: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 70, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Prontuario \nGuardie Zoofile",
                      style: TextStyle(
                          color: Colors.black87.withOpacity(0.8),
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xffEFEFEF),
                          borderRadius: BorderRadius.circular(14)),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Cerca",
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                        onChanged: (String query) {
                          setState(() {
                            filteredArticoli = articoli
                                .where((a) => (a.titolo
                                        .toLowerCase()
                                        .contains(query.toLowerCase()) ||
                                    a.articolo
                                        .toLowerCase()
                                        .contains(query.toLowerCase()) ||
                                    a.testo
                                        .toLowerCase()
                                        .contains(query.toLowerCase())))
                                .toList();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Categorie",
                      style: TextStyle(
                          color: Colors.black87.withOpacity(0.8),
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategorieTile(
                              categorie: categories[index],
                              isSelected:
                                  selectedCategorie == categories[index],
                              context: this,
                            );
                          }),
                    ),
                    Expanded(
                      child: _buildList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorieTile extends StatefulWidget {
  final String categorie;
  final bool isSelected;
  _HomePageState2 context;

  CategorieTile({this.categorie, this.isSelected, this.context});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.context.setState(() {
          selectedCategorie = widget.categorie;
          if (selectedCategorie == "Tutti") {
            filteredArticoli = articoli;
          } else {
            filteredArticoli = articoli
                .where((a) => (a.categoria.toLowerCase() ==
                    selectedCategorie.toLowerCase()))
                .toList();
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
            color: widget.isSelected ? colorPrimary : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          widget.categorie,
          style: TextStyle(
              color: widget.isSelected ? Colors.white : Color(0xffA1A1A1)),
        ),
      ),
    );
  }
}
