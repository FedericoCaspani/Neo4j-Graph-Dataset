import 'package:covid_free_app/Payload/Models/MostVisited.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class MostVisited extends StatelessWidget {

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<MostVisitedTimeSeries> mostVisited = <MostVisitedTimeSeries>[];

  MostVisited({Key? key, required this.mostVisited}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height / 3,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text('The most visited places per day: ', style: TextStyle(fontSize: 24),),
                    const SizedBox(height: 4,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 180,
                        width: 300,
                        child: LineChart(
                          LineChartData(
                              lineTouchData: LineTouchData(
                                  handleBuiltInTouches: true,
                                  touchTooltipData: LineTouchTooltipData(
                                      tooltipBgColor: Colors.blueGrey.withOpacity(0.8)
                                  )
                              ),
                              gridData: FlGridData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: mostVisited.map((value) => FlSpot(
                                      value.time.millisecondsSinceEpoch.toDouble(),
                                      value.count)).toList(),
                                  isCurved: true,
                                  colors: gradientColors,
                                  barWidth: 5,
                                  isStrokeCapRound: true,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    colors: gradientColors.map((color) => color.withOpacity(0.3)).toList()
                                  )
                                ),
                              ],
                              minX: 0,
                              maxX: 14,
                              maxY: 10,
                              minY: 0
                          ),
                          swapAnimationDuration: const Duration(milliseconds: 250),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      );
  }
}