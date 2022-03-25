import 'package:Encasillado/charts/wotd_series.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WotdChart extends StatelessWidget {
  final List<WotdSeries> wotdData;

  WotdChart({required this.wotdData});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<WotdSeries, String>> series = [
      charts.Series(
          id: "wotdData",
          data: wotdData,
          domainFn: (WotdSeries series, _) => series.attempt,
          measureFn: (WotdSeries series, _) => series.times,
          colorFn: (WotdSeries series, _) => series.barColor)
    ];

    late String chartHexColor;
    if (darkMode)
      chartHexColor = '#ffffff';
    else
      chartHexColor = '#000000';

    return Container(
      height: 300,
      padding: EdgeInsets.all(25),
      child: Card(
        color: appWhite,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Aciertos por intento\n",
                style: TextStyle(
                  fontSize: 15,
                  color: appBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Expanded(
                child: charts.BarChart(
                  series, animate: true,
                  domainAxis: new charts.OrdinalAxisSpec(
                      renderSpec: new charts.SmallTickRendererSpec(

                        // Tick and Label styling here.
                          labelStyle: new charts.TextStyleSpec(
                              fontSize: 12,
                              // size in Pts.
                              color: charts.Color.fromHex(code: chartHexColor)),

                          // Change the line colors to match text color.
                          lineStyle: new charts.LineStyleSpec(
                              color: charts.Color.fromHex(code: chartHexColor)))),

                  /// Assign a custom style for the measure axis.
                  primaryMeasureAxis: new charts.NumericAxisSpec(
                      renderSpec: new charts.GridlineRendererSpec(

                        // Tick and Label styling here.
                          labelStyle: new charts.TextStyleSpec(
                              fontSize: 12,
                              // size in Pts.
                              color: charts.Color.fromHex(code: chartHexColor)),

                          // Change the line colors to match text color.
                          lineStyle: new charts.LineStyleSpec(
                              color: charts.Color.fromHex(code: chartHexColor)))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
