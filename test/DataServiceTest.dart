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
      expect(expected, DataService.getEntries());
    });

    /*
    test("edit entry", () {
      final editedTestEntry = Entry(weight: 123, fed: false, feel: 2, notes: "");
      final expected = [editedTestEntry] + startEntries;


      DataService.editEntry(testEntry, editedTestEntry);
      expect(expected, DataService.getEntries());
    });

     */
  });
}
