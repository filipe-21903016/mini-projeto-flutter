import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class EntrySeries {
  final double weight;
  final String dateTime;
  final charts.Color barColor;

  EntrySeries(
      {required this.weight, required this.dateTime, required this.barColor});
}
