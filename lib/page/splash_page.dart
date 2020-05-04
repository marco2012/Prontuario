import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTimeout() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, pageHome);
    });
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 150,
                    left: 50,
                    right: 50,
                    child: Text(
                      "Prontuario \nGuardie Zoofile",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        color: Colors.white,
//                        shadows: <Shadow>[
//                          Shadow(
//                            offset: Offset(2.0, 2.0),
//                            blurRadius: 4.0,
//                            color: Color.fromARGB(128, 0, 0, 0),
//                          ),
//                        ],
                      ),
                    ),
                ),
                Positioned(
                  top: 380,
                  left: 50,
                  right: 50,
                  child: SvgPicture.asset(
                    'assets/icons/manual.svg',
                    height: 100,
                    color: Colors.white,
                  ),
                ),
              ],
            )));
  }
}
