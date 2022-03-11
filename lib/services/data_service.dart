import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:i_que_peso/data/data_source.dart';
import 'package:i_que_peso/models/entry.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import '../models/entry_series.dart';

class DataService {
  static double getWeightVariationPercentage() {
    final recentWeek = _getEntriesBetweenXAndYDays(1, 7);
    final oldWeek = _getEntriesBetweenXAndYDays(8, 15);
    final mean1 = (recentWeek.map((e) => e.weight).sum / recentWeek.length);
    final mean2 = (oldWeek.map((e) => e.weight).sum / oldWeek.length);

    return ((mean2 - mean1) * 100 / mean1).roundToDouble();
  }

  static double get7DayWeightMean() {
    return _getNDayWeightMean(7);
  }

  static double get30DayWeightMean() {
    return _getNDayWeightMean(30);
  }

  static double _getNDayWeightMean(int n) {
    List<Entry> entries = _getNDaysEntries(n);
    final mean = (entries.map((e) => e.weight).sum) / entries.length;
    return mean.roundToDouble();
  }

  static List<Entry> _getEntriesBetweenXAndYDays(int n1, int n2) {
    List<Entry> allEntries = DataSource.getEntries();
    List<Entry> targetEntries = allEntries
        .where((entry) =>
            DateTime.now()
                .difference(Entry.dateFormat.parse(entry.dateTime))
                .inDays >=
            n1)
        .where((entry) =>
            DateTime.now()
                .difference(Entry.dateFormat.parse(entry.dateTime))
                .inDays <=
            n2)
        .toList();
    return targetEntries;
  }

  static List<Entry> _getNDaysEntries(int n) {
    List<Entry> allEntries = DataSource.getEntries();
    List<Entry> targetEntries = allEntries
        .where((entry) =>
            DateTime.now()
                .difference(Entry.dateFormat.parse(entry.dateTime))
                .inDays <=
            n)
        .toList();
    return targetEntries;
  }

  static double _getNDaysFeelMean(int n) {
    List<Entry> entries = _getNDaysEntries(n);
    final mean = (entries.map((e) => e.feel).sum) / entries.length;
    return mean.roundToDouble();
  }

  static double get7DayFeelMean() {
    return _getNDaysFeelMean(7);
  }

  static List<Entry> getEntries() {
    return DataSource.getEntries();
  }

  static List<Entry> getSortedEntries() {
    DateFormat format = Entry.dateFormat;
    List<Entry> entries = DataSource.getEntries();
    final sortedEntries = entries.sorted(
        (a, b) => format.parse(b.dateTime).compareTo(format.parse(a.dateTime)));
    return sortedEntries;
  }

  static void addEntry(Entry entry) => DataSource.addEntry(entry);

  static void deleteEntry(Entry entry) => DataSource.remove(entry);

  static bool verifyEntryFields(
      String weight, int feel, bool fed, String observations) {
    return !((observations.isNotEmpty &&
            (observations.length < 100 || observations.length > 200)) ||
        double.tryParse(weight) == null);
  }

  static bool verifyEdit(Entry entry) {
    DateTime now = DateTime.now();
    DateTime entryDate = Entry.dateFormat.parse(entry.dateTime);
    return now.difference(entryDate).inDays < 8;
  }

  static bool verifyDelete(Entry entry) {
    DateTime now = DateTime.now();
    DateTime entryDate = Entry.dateFormat.parse(entry.dateTime);
    return now.difference(entryDate).inDays < 8;
  }

  static void editEntry(Entry dst, Entry src) {
    dst.copy(src);
  }

  static double getFirstWeight() {
    return getSortedEntries().last.weight;
  }

  static double getLastWeight() {
    return getSortedEntries().first.weight;
  }

  static List<Entry> getLast15Entries(){
    List<Entry> sortedEntries = getSortedEntries();
    return sortedEntries
        .where((element) => sortedEntries.indexOf(element) < 15).toList();
  }

  static buildEntrySeriesList() {
    return getLast15Entries()
        .reversed
        .map((e) => EntrySeries(
            weight: e.weight,
            dateTime: DateFormat("dd/MM")
                .format(DateFormat("dd/MM/yyyy - HH:mm").parse(e.dateTime)),
            barColor: charts.ColorUtil.fromDartColor(Colors.white)))
        .toList();
  }
}
