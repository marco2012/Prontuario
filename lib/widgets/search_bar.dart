import 'package:Prontuario_Guardie_Zoofile/model/Articolo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatefulWidget {

  final List<Articolo> articoli;
  final List<Articolo> filteredArticoli;
  final searchCallback;

  const SearchBar({
    Key key,
    @required this.articoli,
    @required this.filteredArticoli,
    @required this.searchCallback,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
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
          widget.searchCallback(widget.filteredArticoli, query);
        },
      ),
    );
  }
}
