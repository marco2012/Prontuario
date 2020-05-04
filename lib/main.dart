import 'package:Prontuario_Guardie_Zoofile/page/home_navigator.dart';
import 'package:Prontuario_Guardie_Zoofile/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

void main() => runApp(myApp());

class myApp extends StatefulWidget {
  @override
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      initialRoute: pageSplash,
      routes: {
        pageSplash: (context) => SplashPage(),
        pageHome: (context) => HomeNavigator(),
      },
    );
  }
}
