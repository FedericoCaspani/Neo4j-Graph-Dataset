import 'package:covid_free_app/Screens/Contacts/Contacts.dart';
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
  final List<Widget> _children = <Widget>[
    Contacts(),

  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        onTap: onTabTapped,
        selectedItemColor: kPrimaryColor,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.menu),
              label: "Menu"
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.map),
              label: "Map"
          )
        ],
      ),
    );
  }
}