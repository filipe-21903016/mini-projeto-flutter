import 'package:i_que_peso/models/entry.dart';

class DataSource {
  DataSource._privateConstructor();

  static final DataSource _instance = DataSource._privateConstructor();
  static final List<Entry> _entries = [
    Entry.withDatetime(weight: 80.0, fed: true, feel: 1, notes: "", dateTime: "01/01/2022 - 01:01"),
    Entry.withDatetime(weight: 78.0, fed: false, feel: 2, notes: "", dateTime: "02/02/2022 - 01:01"),
    Entry.withDatetime(weight: 77.0, fed: false, feel: 3, notes: "", dateTime: "03/02/2022 - 01:01"),
    Entry.withDatetime(weight: 81.0, fed: true, feel: 4, notes: "", dateTime: "02/03/2022 - 01:01"),
    Entry.withDatetime(weight: 82.0, fed: true, feel: 5, notes: "", dateTime: "03/03/2022 - 01:01"),
    Entry.withDatetime(weight: 76.0, fed: false, feel: 1, notes: "", dateTime: "04/03/2022 - 01:01"),
    Entry.withDatetime(weight: 81.0, fed: true, feel: 4, notes: "", dateTime: "05/03/2022 - 01:01"),
    Entry.withDatetime(weight: 83.0, fed: false, feel: 5, notes: "", dateTime: "05/03/2022 - 01:20"),
    Entry.withDatetime(weight: 77.0, fed: false, feel: 3, notes: "", dateTime: "02/03/2022 - 01:01"),
    Entry.withDatetime(weight: 78.0, fed: true, feel: 4, notes: "", dateTime: "06/03/2022 - 01:01"),
    Entry.withDatetime(weight: 79.0, fed: false, feel: 2, notes: "", dateTime: "07/03/2022 - 01:01"),
    Entry.withDatetime(weight: 83.0, fed: false, feel: 1, notes: "", dateTime: "08/03/2022 - 01:01"),
    Entry.withDatetime(weight: 81.0, fed: false, feel: 2, notes: "", dateTime: "09/03/2022 - 01:01"),
    Entry.withDatetime(weight: 82.0, fed: false, feel: 3, notes: "", dateTime: "09/03/2022 - 01:02"),
    Entry.withDatetime(weight: 84.0, fed: false, feel: 5, notes: "", dateTime: "10/03/2022 - 01:01"),
  ];

  factory DataSource() => _instance;

  static void addEntry(Entry entry) {
    _entries.insert(0, entry);
  }

  static getEntries() {
    return _entries;
  }

  static getNLastEntries(int n) {
    if (_entries.length >= n) {
      return _entries.sublist(_entries.length - n, _entries.length);
    }
    return _entries;
  }

  static remove(Entry entry) {
    _entries.remove(entry);
  }
}
