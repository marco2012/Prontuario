import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorsInfo extends StatefulWidget {
  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<DoctorsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
//                  Image.asset("assets/doctor_pic2.png", height: 220),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
//                    width: MediaQuery.of(context).size.width - 222,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Prontuario \nGuardie Zoofile",
                          style: TextStyle(fontSize: 32),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Icaro Onlus",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                launch("mailto:icaro.odv@gmail.com");
                              },
                              child: IconTile(
                                backColor: Color(0xffFFECDD),
                                imgAssetPath: "assets/icons/email.png",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launch("tel:3395938641");
                              },
                              child: IconTile(
                                backColor: Color(0xffFEF2F0),
                                imgAssetPath: "assets/icons/call.png",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launch("http://www.icaro-onlus.net/");
                              },
                              child: IconTile(
                                backColor: Color(0xffEBECEF),
                                imgAssetPath: "assets/icons/website.png",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Informazioni",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Icaro OdV è una Associazione che si prefigge lo scopo di proteggere l'Ambiente e gli Animali attraverso l'opera dei suoi Sodali e, in particolare, delle Guardie Ittiche e Zoofile ad essa afferenti che in virtù del loro proficuo impegno ottengono lusinghieri risultati.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
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

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}
