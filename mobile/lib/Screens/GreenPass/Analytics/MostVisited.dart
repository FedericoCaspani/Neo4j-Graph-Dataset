import 'package:covid_free_app/Payload/Models/MostVisited.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MostVisited extends StatelessWidget {

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<MostVisitedTimeSeries> mostVisited = <MostVisitedTimeSeries>[];

  MostVisited({Key? key, required this.mostVisited}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                          color: Color(0xff232d37),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: 180,
                          width: 300,
                          child: LineChart(
                            LineChartData(
                                borderData: FlBorderData(show: false),
                                lineTouchData: LineTouchData(
                                    handleBuiltInTouches: true,
                                    touchTooltipData: LineTouchTooltipData(
                                        tooltipBgColor: Colors.blueGrey.withOpacity(0.8)
                                    )
                                ),
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: true,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: const Color(0xff37434d),
                                      strokeWidth: 1,
                                    );
                                  },
                                  getDrawingVerticalLine: (value) {
                                    return FlLine(
                                      color: const Color(0xff37434d),
                                      strokeWidth: 1,
                                    );
                                  }),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    rightTitles: SideTitles(showTitles: false),
                                    topTitles: SideTitles(showTitles: false),
                                    bottomTitles: SideTitles(
                                      showTitles: true,
                                      getTextStyles: (context, value) => const TextStyle(
                                        color: Color(0xff68737d),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                      ),
                                       getTitles: (value) {
                                         var date = new DateTime.fromMillisecondsSinceEpoch(value.toInt()).toString().split("-");
                                         switch(date[1]) {
                                           case '01': return 'JAN';
                                           case '02': return 'FEB';
                                           case '03': return 'MAR';
                                           case '04': return 'APR';
                                           case '05': return 'MAY';
                                           case '06': return 'JUN';
                                           case '07': return 'JUL';
                                           case '08': return 'AUG';
                                           case '09': return 'SEP';
                                           case '10': return 'OCT';
                                           case '11': return 'NOV';
                                           case '12': return 'DEC';
                                           default: return '';
                                         }
                                       }
                                    ),
                                    leftTitles: SideTitles(
                                      showTitles: true,
                                      interval: 3,
                                      getTextStyles: (context, value) => const TextStyle(
                                        color: Color(0xff67727d),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )
                                    )
                                  ),
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
                                  maxY: 10,
                                  minY: 0
                              ),
                            swapAnimationDuration: const Duration(milliseconds: 250),
                          ),
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