import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Entry extends Equatable{
  static final dateFormat = DateFormat("dd/MM/yyyy - HH:mm");
  double weight; //registered weight
  bool fed; //fed in the last 3h ?
  int feel; //between 1 and 5 how do you feel?
  String notes; // comments between 100 and 200 chars
  String dateTime = dateFormat.format(DateTime.now());

  Entry({
    required this.weight,
    required this.fed,
    required this.feel,
    required this.notes,
  });

  Entry.withDatetime({
    required this.weight,
    required this.fed,
    required this.feel,
    required this.notes,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [weight, fed, feel, notes, dateTime];

  void copy(Entry entry){
    weight = entry.weight;
    fed = entry.fed;
    feel = entry.feel;
    notes = entry.notes;
  }
}