import 'package:covid_free_app/Payload/API/Maps/Serializable/Q3.dart';
import 'package:covid_free_app/Screens/GreenPass/Analytics/MainAnalytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constraints.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainAnalytics())
          );
        },
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(15.0),
            primary: kPrimaryColor,
            onPrimary: kPrimaryLightColor
        ),
        child: Icon(
          Icons.analytics_outlined,
          size: 35.0,
        ),
      ),
    );
  }

}
