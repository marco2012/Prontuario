import 'package:Prontuario_Guardie_Zoofile/page/splash_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'comuni_page.dart';
import 'home_page.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _currentPage = 1;

  final ComuniPage comuniPage = new ComuniPage();
  final HomePage homePage = new HomePage();

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [comuniPage, homePage, Center(child: Text('Todo'))];
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
          TabItem(icon: Icons.home, title: ''),
          TabItem(icon: Icons.book, title: ''),
          TabItem(icon: Icons.settings, title: ''),
        ],
      ),
      body: _pages[_currentPage],
    );
  }
}
