import 'package:flutter_test/flutter_test.dart';
import 'package:i_que_peso/data/data_source.dart';
import 'package:i_que_peso/models/entry.dart';

void main() {
  group("Basic Operations", () {
    final startEntries = DataSource.getEntries();
    final testEntry = Entry(weight: 90, fed: false, feel: 1, notes: "");

    test("test add entry", () {
      final expected = [testEntry] + startEntries;
      DataSource.addEntry(testEntry);
      expect(expected, DataSource.getEntries());
    });

    test("test remove entry", () {
      DataSource.remove(testEntry);
      expect(startEntries, DataSource.getEntries());
    });
  });
}
