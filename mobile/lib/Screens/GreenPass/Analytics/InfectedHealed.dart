import 'package:covid_free_app/Payload/Models/InfectedHealed.dart';
import 'package:covid_free_app/Screens/GreenPass/Analytics/PieChart.dart';
import 'package:flutter/material.dart';

class InfectedHealed extends StatelessWidget {

  final InfectedHealedModel infectedHealedModel;

  InfectedHealed({Key? key, required this.infectedHealedModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PieChartModel(
        infected: infectedHealedModel.infected,
        notInfected: infectedHealedModel.healthy,
        ratio: infectedHealedModel.ratio,
        notString: 'Healthy',
      ),
    );
  }
}