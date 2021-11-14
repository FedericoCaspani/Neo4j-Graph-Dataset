import 'package:covid_free_app/Payload/Models/VaccineCount.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VaccineRatio extends StatelessWidget {
  final double barWidth = 22;
  List<VaccineCount> vaccineRatio = [];

  VaccineRatio({Key? key, required this.vaccineRatio}) : super(key: key);

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
                  const Text('Count of the green pass issued: ', style: TextStyle(fontSize: 24),),
                  const SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: 180,
                      width: 300,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.center,
                          maxY: 10,
                          minY: 0,
                          groupsSpace: 5,
                          barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.blueGrey,
                                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                  String vaccine;
                                  switch(group.x.toInt()) {
                                    case 1:
                                      vaccine = 'Sputnik V';
                                      break;
                                    case 2:
                                      vaccine = 'Johnson&Johnson';
                                      break;
                                    case 3:
                                      vaccine = 'Test';
                                      break;
                                    case 4:
                                      vaccine = 'Pfizer';
                                      break;
                                    case 5:
                                      vaccine = 'Moderna';
                                      break;
                                    case 6:
                                      vaccine = 'Astrazeneca';
                                      break;
                                    default:
                                      throw Error();
                                  }
                                  return BarTooltipItem(
                                      vaccine + '\n',
                                      const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                      children: <TextSpan> [
                                        TextSpan(
                                          text: (rod.y).toString(),
                                          style: const TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                          )
                                        )
                                      ]
                                  );
                                }
                              )
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: SideTitles(showTitles: false),
                            topTitles: SideTitles(showTitles: false),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) => const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                              ),
                              margin: 16,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 1:
                                    return 'S';
                                  case 2:
                                    return 'J';
                                  case 3:
                                    return 'T';
                                  case 4:
                                    return 'P';
                                  case 5:
                                    return 'M';
                                  case 6:
                                    return 'A';
                                  default:
                                    return '';
                                }
                              }
                            ),
                            leftTitles: SideTitles(
                              showTitles: false
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                          barGroups: vaccineRatio.map(
                                    (data) => BarChartGroupData(
                                    x: data.id,
                                    barRods: [
                                      BarChartRodData(
                                          y: data.count.toDouble(),
                                          width: barWidth,
                                          colors: [data.color],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                          )
                                      )
                                    ]
                                )
                            ).toList()
                          )
                        ),
                      ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
