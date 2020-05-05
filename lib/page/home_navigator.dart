import 'package:Prontuario_Guardie_Zoofile/page/settings_page.dart';
import 'package:Prontuario_Guardie_Zoofile/widgets/buttom_nav_layout.dart';
import 'package:Prontuario_Guardie_Zoofile/widgets/fab_bottom_app_bar.dart';
import 'package:Prontuario_Guardie_Zoofile/widgets/fab_with_icons.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'home_page2.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _currentPage = 0;
  List<Widget> _pages = [HomePage2(), DoctorsInfo()];

  Widget _convexAppBar() {
    return ConvexAppBar(
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
      style: TabStyle.reactCircle,
      items: <TabItem>[
//          TabItem(icon: Icons.home, title: ''),
        TabItem(icon: Icons.book, title: ''),
        TabItem(icon: Icons.settings, title: ''),
      ],
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: (int val) {
            },
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () { print("pressed"); },
        child: Icon(Icons.search),
        elevation: 2.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: colorPrimary,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (int val) {
          if (val == _currentPage) return;
          setState(() {
            _currentPage = val;
          });
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.book, text: 'Articoli'),
          FABBottomAppBarItem(iconData: Icons.info, text: 'Info'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
      // This trailing comma makes auto-formatting nicer for build methods.
      body: IndexedStack(
        index: _currentPage,
        children: _pages,
      ),
    );
  }
}
