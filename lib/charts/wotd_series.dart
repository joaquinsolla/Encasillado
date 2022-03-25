import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class WotdSeries {
  final String attempt;
  final int times;
  final charts.Color barColor;

  WotdSeries(
      {required this.attempt,
        required this.times,
        required this.barColor});
}
