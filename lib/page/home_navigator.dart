import 'package:Prontuario_Guardie_Zoofile/page/splash_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'home_page.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _currentPage = 1;

  List<Widget> _pages = [Center(child: Text('test')), HomePage(), Center(child: Text('Impostazioni'))];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        color: colorParagraph2,
        backgroundColor: Colors.white,
        activeColor: colorPrimary,
        elevation: 0.5,
        onTap: (int val) {
          if (val == _currentPage) return;
          setState(() {
            _currentPage = val;
          });
        },
        initialActiveIndex: _currentPage,
        style: TabStyle.fixedCircle,
        items: <TabItem>[
          TabItem(icon: Icons.history, title: ''),
          TabItem(icon: Icons.book, title: ''),
          TabItem(icon: Icons.settings, title: ''),
        ],
      ),
      body: _pages[_currentPage],
    );
  }
}
