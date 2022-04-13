import 'package:charts_flutter/flutter.dart' as charts;

class InfiniteSeries {
  final String attempt;
  final int times;
  final charts.Color barColor;

  InfiniteSeries(
      {required this.attempt,
        required this.times,
        required this.barColor});
}
