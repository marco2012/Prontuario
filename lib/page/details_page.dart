import 'package:Prontuario_Guardie_Zoofile/model/Articolo.dart';
import 'package:Prontuario_Guardie_Zoofile/widgets/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class DetailsScreen extends StatefulWidget {
  final Articolo articolo;

  DetailsScreen(this.articolo);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final double fontSize = 16;

  Widget titleRow(String num, String text) {
    return Row(
      children: <Widget>[
        Text(
          num,
          style: TextStyle(color: colorParagraph2, fontSize: fontSize),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(color: colorPrimary, fontSize: fontSize),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Articolo ${widget.articolo.articolo}"),
          backgroundColor: colorPrimary,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            child: new SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.articolo.titolo,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Material(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            elevation: 4,
                            shadowColor: Colors.black38,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                height: 48,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                SvgPicture.asset(
                                "assets/icons/city.svg",
                                ), // icon
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Comune di ${widget.articolo.comune}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorParagraph),
                                    ), // text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Material(
                    color: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black38,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: <Widget>[
                          titleRow('1', 'Articolo'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  widget.articolo.testo,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: colorParagraph,
                                      fontSize: fontSize),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(),
                          SizedBox(
                            height: 8,
                          ),
                          titleRow('2', 'Sanzioni'),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  widget.articolo.sanzione,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontSize: fontSize),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class SeassionCard extends StatelessWidget {
  final int seassionNum;
  final bool isDone;
  final Function press;

  const SeassionCard({
    Key key,
    this.seassionNum,
    this.isDone = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 - 10,
          // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: isDone ? Colors.white : kBlueColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Session $seassionNum",
                      style: Theme.of(context).textTheme.subtitle,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
