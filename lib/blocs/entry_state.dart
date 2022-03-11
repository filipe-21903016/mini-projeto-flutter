part of 'entry_bloc.dart';

abstract class EntryState {
  const EntryState();
}

class LoadEntriesState extends EntryState{
  final List<Entry> entries = DataService.getSortedEntries();
  @override
  List<Object> get props => entries;
}

class EntryInitialState extends LoadEntriesState {}

class NewEntryState extends LoadEntriesState {}

class EditedEntryState extends LoadEntriesState {}

class DeletedEntryState extends LoadEntriesState {}

class CannotDeleteState extends LoadEntriesState {}

class CannotEditState extends EntryState {
  @override
  List<Object?> get props => [];
}

class CanEditState extends EntryState{
  final Entry entry;
  const CanEditState({required this.entry});
  @override
  List<Object?> get props => [entry];
}
