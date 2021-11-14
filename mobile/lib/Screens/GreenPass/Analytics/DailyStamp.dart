import 'package:covid_free_app/Payload/Models/DailyStamp.dart';
import 'package:flutter/cupertino.dart';

import 'PieChart.dart';

class DailyStamp extends StatelessWidget {

  final DailyStampModel dailyStampModel;
  DailyStamp({Key? key, required this.dailyStampModel}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: PieChartModel(
        infected: dailyStampModel.infected,
        notInfected: dailyStampModel.tested,
        ratio: dailyStampModel.ratio,
        notString: 'Tested',
      ),
    );
  }
}