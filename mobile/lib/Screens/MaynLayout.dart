import 'package:covid_free_app/Screens/Contacts/Contacts.dart';
import 'package:covid_free_app/Screens/GreenPass/MainGreen.dart';
import 'package:covid_free_app/Screens/Map/MainMap.dart';
import 'package:covid_free_app/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
* Main Layout that has the main functionality
* */

class MainLayout extends StatefulWidget {
 @override
 _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  final  _bottomNavigationBar = [
    BottomNavigationBarItem(
        icon: new Icon(Icons.menu),
        label: "Menu"
    ),
    BottomNavigationBarItem(
        icon: new Icon(Icons.map),
        label: "Map"
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.receipt_long_rounded)
    )
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onTabTapped,
        children: [
          Contacts(),
          MainMap(),
          MainGreen()
        ],
      ),
      /*body: _children[_currentIndex],*/
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        onTap: (index) {
          _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        selectedItemColor: kPrimaryColor,
        items: _bottomNavigationBar,
        currentIndex: _currentIndex,
      ),
    );
  }
}