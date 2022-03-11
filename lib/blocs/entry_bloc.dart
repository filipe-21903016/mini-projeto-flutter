import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:i_que_peso/data/data_source.dart';
import 'package:i_que_peso/services/data_service.dart';

import '../models/entry.dart';

part 'entry_event.dart';
part 'entry_state.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  EntryBloc() : super(EntryInitialState()) {

    on<LoadEntriesEvent>((event, emit) => emit(EntryInitialState()));

    on<NewEntryEvent>((event, emit) {
      DataService.addEntry(event.entry);
      emit(NewEntryState());
    });

    on<EditEntryEvent>((event, emit) {
      DataService.editEntry(event.entry, event.newEntry);
      emit(EditedEntryState());
    });

    on<TryEditEvent>((event, emit) {
      if (DataService.verifyEdit(event.entry)){
        emit(CanEditState(entry: event.entry));
      }
      else{
        emit(CannotEditState());
      }
    });

    on<DeleteEntryEvent>((event, emit) {
      if (DataService.verifyDelete(event.entry)){
        DataService.deleteEntry(event.entry);
        emit(DeletedEntryState());
      }
    });

    on<FailedDeleteEvent>((event, emit) {
      emit(CannotDeleteState());
    });

  }
}
