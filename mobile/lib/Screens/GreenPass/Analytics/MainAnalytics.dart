import 'package:covid_free_app/Payload/Models/ColorVaccines.dart';
import 'package:covid_free_app/Payload/Models/DailyStamp.dart';
import 'package:covid_free_app/Payload/Models/InfectedHealed.dart';
import 'package:covid_free_app/Payload/Models/MostVisited.dart';
import 'package:covid_free_app/Payload/Models/VaccineCount.dart';
import 'package:covid_free_app/Screens/GreenPass/Analytics/DailyStamp.dart';
import 'package:covid_free_app/Screens/GreenPass/Analytics/InfectedHealed.dart';
import 'package:covid_free_app/Screens/GreenPass/Analytics/MostVisited.dart';
import 'package:covid_free_app/Screens/GreenPass/Analytics/TableOfPeople.dart';
import 'package:covid_free_app/Screens/GreenPass/Analytics/VaccineRatio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Payload/API/Maps/Serializable/Q3.dart' as vaccineRatio;
import '../../../Payload/API/Maps/Serializable/Q6.dart' as mostVisited;
import '../../../Payload/API/Maps/Serializable/Q4.dart' as infectedHealed;
import '../../../Payload/API/Maps/Serializable/Q5.dart' as dailyStamp;
import '../../../constraints.dart';


class MainAnalytics extends StatefulWidget {
  @override
  _MainAnalyticsState createState() => _MainAnalyticsState();
}

class _MainAnalyticsState extends State<MainAnalytics> {

  List<VaccineCount> vaccineRatioList = <VaccineCount>[];
  List<MostVisitedTimeSeries> mostVisitedTimesSeries = <MostVisitedTimeSeries>[];
  late DailyStampModel dailyStampsInstance;
  late InfectedHealedModel infectedHealedInstance;


  @override
  void initState() {
    super.initState();
    vaccineRatio.placeDailyInfected().then((result) {
      List<VaccineCount> vaccineList = [];
      for (final value in result.values) {
        int count = value.count;
        for (final vac in value.vaccines) {
          String vaccine = vac.name;
          int id = _idChoose(vaccine);
          Color color = vaccineColor[vaccine] ?? Colors.black;
          vaccineList.add(VaccineCount(id: id, count: count, vaccine: vaccine, color: color));
        }
      }
      setState(() {
        vaccineRatioList = vaccineList;
      });
    });
    mostVisited.mostVisited().then((result) {
      final List<MostVisitedTimeSeries> mostVisited = [];
      double count = result.count.toDouble();
      String placeName = result.placeName;
      DateTime dateTime = DateTime.parse(result.date);
      mostVisited.add(MostVisitedTimeSeries(count: count,
          time: dateTime,
          place: placeName));
      setState(() {
        mostVisitedTimesSeries = mostVisited;
      });
    });
    infectedHealed.placeInfectedHealed().then((result) {
      int healthy = result.healthy;
      double ratio = result.ratio;
      int infected = result.infected;
      setState(() {
        infectedHealedInstance = InfectedHealedModel(infected: infected, healthy: healthy, ratio: ratio);
      });
    });
    dailyStamp.placeDailyStamp().then((result) {
      int infected = result.infected;
      int tested = result.tested;
      double ratio = result.ratio;
      setState(() {
        dailyStampsInstance = DailyStampModel(infected: infected, tested: tested, ratio: ratio);
      });
    });
  }

  int _idChoose(String vaccine) {
    switch(vaccine) {
      case "Sputnik V Vaccination": return 1;
      case "Johnson&Johnson Vaccination": return 2;
      case "Covid-19 Test": return 3;
      case "Pfizer Vaccination": return 4;
      case "Moderna Vaccination": return 5;
      case "Astrazeneca Vaccination": return 6;
      default: return 7;
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              ClipOval(
                child: Image.network(
                  logoBarCode,
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 30,),
              VaccineRatio(vaccineRatio: vaccineRatioList,),
              SizedBox(height: 30,),
              MostVisited(mostVisited: mostVisitedTimesSeries,),
              SizedBox(height: 30,),
              InfectedHealed(infectedHealedModel: infectedHealedInstance),
              SizedBox(height: 30,),
              DailyStamp(dailyStampModel: dailyStampsInstance),
              SizedBox(height: 30,),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> TableOfPeople()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15.0),
                      primary: kPrimaryColor,
                      onPrimary: kPrimaryLightColor
                  ),
                  child: Icon(
                    Icons.table_view_outlined,
                    size: 35.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}