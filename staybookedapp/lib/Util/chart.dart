import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class pieChartDisplay extends StatelessWidget {
  pieChartDisplay({Key? key}) : super(key: key);

  final dataMap = <String, double>{
    "Empty Rooms": 5,
    "Filled Rooms": 3,
    "Under Repair": 2,
  };

  final colorList = [
    Colors.green,
    Colors.blue,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Room Status",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                // Adjust the size to the available space rather than a fixed size
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
                  legendOptions: LegendOptions(
                    showLegendsInRow: true,
                    legendPosition: LegendPosition.bottom,
                    showLegends: true,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
