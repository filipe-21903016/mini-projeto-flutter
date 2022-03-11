part of 'entry_bloc.dart';

abstract class EntryEvent{
  const EntryEvent();
}

class LoadEntriesEvent extends EntryEvent{
  @override
  List<Object?> get props => [];
}

class NewEntryEvent extends EntryEvent{
  final Entry entry;
  const NewEntryEvent({ required this.entry});
  @override
  List<Object?> get props => [entry];
}

class EditEntryEvent extends EntryEvent{
  final Entry entry;
  final Entry newEntry;
  const EditEntryEvent({required this.entry, required this.newEntry});

  @override
  List<Object?> get props => [entry, newEntry];
}

class TryEditEvent extends EntryEvent{
  final Entry entry;
  const TryEditEvent({ required this.entry});
  @override
  List<Object?> get props => [entry];
}

class FailedDeleteEvent extends EntryEvent{
  @override
  List<Object?> get props => [];
}

class DeleteEntryEvent extends EntryEvent{
  final Entry entry;
  const DeleteEntryEvent({required this.entry});
  @override
  List<Object?> get props => [entry];
}
