import 'package:flutter_test/flutter_test.dart';
import 'package:i_que_peso/data/data_source.dart';
import 'package:i_que_peso/models/entry.dart';
import 'package:i_que_peso/services/data_service.dart';

void main() {
  group("Basic Ops", () {
    final testEntry = Entry(weight: 122, fed: true, feel: 1, notes: "");
    final startEntries = DataService.getEntries();

    test("add entry", () {
      final expected = [testEntry] + startEntries;
      DataService.addEntry(testEntry);
      expect(DataService.getEntries(), expected);
      DataService.deleteEntry(testEntry);
    });

    test("edit entry", () {
      DataService.addEntry(testEntry);
      final editedTestEntry =
          Entry(weight: 123, fed: false, feel: 2, notes: "");

      DataService.editEntry(testEntry, editedTestEntry);
      expect(testEntry, editedTestEntry);
    });
  });

  group("Statistics", () {
    final dateTimeNow = Entry.dateFormat.format(DateTime.now());

    test("Test 7 day mean", () {
      final testEntries = [
        Entry.withDatetime(
            weight: 80.12,
            fed: true,
            feel: 1,
            notes: "",
            dateTime: "01/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 78.50,
            fed: false,
            feel: 2,
            notes: "",
            dateTime: "02/02/2022 - 01:01"),
        Entry.withDatetime(
            weight: 77.32,
            fed: false,
            feel: 3,
            notes: "",
            dateTime: "03/02/2022 - 01:01"),
        Entry.withDatetime(
            weight: 81.43,
            fed: true,
            feel: 4,
            notes: "",
            dateTime: "02/03/2022 - 01:01"),
        Entry.withDatetime(
            weight: 80.12,
            fed: true,
            feel: 1,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
        Entry.withDatetime(
            weight: 78.50,
            fed: false,
            feel: 2,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
        Entry.withDatetime(
            weight: 77.32,
            fed: false,
            feel: 3,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
        Entry.withDatetime(
            weight: 81.43,
            fed: true,
            feel: 4,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
      ];
      DataSource.setEntries(testEntries);
      expect(DataService.get7DayWeightMean(), 79.3425);
    });

    test("Test 30 day mean", () {
      final testEntries = [
        Entry.withDatetime(
            weight: 80.12,
            fed: true,
            feel: 1,
            notes: "",
            dateTime: "01/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 78.50,
            fed: false,
            feel: 2,
            notes: "",
            dateTime: "02/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 77.32,
            fed: false,
            feel: 3,
            notes: "",
            dateTime: "03/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 81.43,
            fed: true,
            feel: 4,
            notes: "",
            dateTime: "02/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 80.12,
            fed: true,
            feel: 1,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
        Entry.withDatetime(
            weight: 78.50,
            fed: false,
            feel: 2,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
        Entry.withDatetime(
            weight: 77.32,
            fed: false,
            feel: 3,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
        Entry.withDatetime(
            weight: 81.43,
            fed: true,
            feel: 4,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
      ];
      DataSource.setEntries(testEntries);
      expect(DataService.get30DayWeightMean(), 79.3425);
    });

    test("Test 7 day satisfaction mean", () {
      final testEntries = [
        Entry.withDatetime(
            weight: 80.12,
            fed: true,
            feel: 1,
            notes: "",
            dateTime: "01/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 78.50,
            fed: false,
            feel: 2,
            notes: "",
            dateTime: "02/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 77.32,
            fed: false,
            feel: 3,
            notes: "",
            dateTime: "03/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 81.43,
            fed: true,
            feel: 4,
            notes: "",
            dateTime: "02/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 80.12,
            fed: true,
            feel: 1,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
        Entry.withDatetime(
            weight: 78.50,
            fed: false,
            feel: 2,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
        Entry.withDatetime(
            weight: 77.32,
            fed: false,
            feel: 3,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
        Entry.withDatetime(
            weight: 81.43,
            fed: true,
            feel: 4,
            notes: "",
            dateTime: "$dateTimeNow - 01:01"),
      ];
      DataSource.setEntries(testEntries);
      expect(DataService.get7DayFeelMean(), 2.5);
    });

    test("Test Last 15 Entries with 4 entries", () {
      final testEntries = [
        Entry.withDatetime(
            weight: 80.12,
            fed: true,
            feel: 1,
            notes: "",
            dateTime: "15/12/2021 - 01:01"),
        Entry.withDatetime(
            weight: 78.50,
            fed: false,
            feel: 2,
            notes: "",
            dateTime: "02/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 77.32,
            fed: false,
            feel: 3,
            notes: "",
            dateTime: "03/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 81.43,
            fed: true,
            feel: 4,
            notes: "",
            dateTime: "01/01/2022 - 01:01"),
      ];
      DataSource.setEntries(testEntries);
      expect(DataService.getLast15Entries(), [
        Entry.withDatetime(
            weight: 77.32,
            fed: false,
            feel: 3,
            notes: "",
            dateTime: "03/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 78.50,
            fed: false,
            feel: 2,
            notes: "",
            dateTime: "02/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 81.43,
            fed: true,
            feel: 4,
            notes: "",
            dateTime: "01/01/2022 - 01:01"),
        Entry.withDatetime(
            weight: 80.12,
            fed: true,
            feel: 1,
            notes: "",
            dateTime: "15/12/2021 - 01:01"),
      ]);
    });

    test("Test Variation", () {
      final now = DateTime.now();
      final date9DaysAgo = DateTime(now.year, now.month, now.day - 9);
      final testEntries = [
        Entry.withDatetime(
            weight: 120,
            fed: true,
            feel: 1,
            notes: "",
            dateTime: Entry.dateFormat.format(now)),
        Entry.withDatetime(
            weight: 110,
            fed: true,
            feel: 4,
            notes: "",
            dateTime: Entry.dateFormat.format(date9DaysAgo)),
      ];
      DataSource.setEntries(testEntries);
      expect(
          double.parse(
              DataService.getWeightVariationPercentage().toStringAsFixed(2)),
          -8.33);
    });
  });

  group("Verifications", () {
    final testEntry = Entry.withDatetime(
        weight: 80.12,
        fed: true,
        feel: 1,
        notes: "",
        dateTime: "15/12/2021 - 01:01");
    final dateTimeNow = DateTime.now();
    final dateTime8DaysAgo =
        DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 8);
    final dateTime7DaysAgo =
        DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 7);

    test("Test Edit Entry from now", () {
      testEntry.dateTime = Entry.dateFormat.format(dateTimeNow);
      expect(DataService.verifyEdit(testEntry), true);
    });

    test("Test Edit Entry from 7 days ago ", () {
      testEntry.dateTime = Entry.dateFormat.format(dateTime7DaysAgo);
      expect(DataService.verifyEdit(testEntry), true);
    });

    test("Test Edit Entry from 8 days ago ", () {
      testEntry.dateTime = Entry.dateFormat.format(dateTime8DaysAgo);
      expect(DataService.verifyEdit(testEntry), false);
    });

    test("Test Delete Entry from now", () {
      testEntry.dateTime = Entry.dateFormat.format(dateTimeNow);
      expect(DataService.verifyDelete(testEntry), true);
    });

    test("Test Delete Entry from 7 days ago ", () {
      testEntry.dateTime = Entry.dateFormat.format(dateTime7DaysAgo);
      expect(DataService.verifyDelete(testEntry), true);
    });

    test("Test Delete Entry from 8 days ago ", () {
      testEntry.dateTime = Entry.dateFormat.format(dateTime8DaysAgo);
      expect(DataService.verifyDelete(testEntry), false);
    });

    test("Test Entry Field Verification 1", () {
      expect(
          DataService.verifyEntryFields(testEntry.weight.toString(),
              testEntry.feel, testEntry.fed, testEntry.notes),
          true);
    });

    test("Test Entry Field Verification 2", () {
      expect(
          DataService.verifyEntryFields(
              testEntry.weight.toString(),
              testEntry.feel,
              testEntry.fed,
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"),
          true);
    });

    test("Test Entry Field Verification 3", () {
      //too much chars in notes
      expect(
          DataService.verifyEntryFields(
              testEntry.weight.toString(),
              testEntry.feel,
              testEntry.fed,
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"
              "123456789ABCDEF"),
          false);
    });

    test("Test Entry Field Verification 4", () {
      //not enough chars in notes
      expect(
          DataService.verifyEntryFields(testEntry.weight.toString(),
              testEntry.feel, testEntry.fed, "aksdnaksdnaksd"),
          false);
    });

    test("Test Entry Field Verification 5", () {
      //weight is required
      expect(
          DataService.verifyEntryFields("", testEntry.feel, testEntry.fed, ""),
          false);
    });

    test("Test Entry Field Verification 6", () {
      //weight is a number
      expect(
          DataService.verifyEntryFields(
              "asd", testEntry.feel, testEntry.fed, ""),
          false);
    });
  });
}
