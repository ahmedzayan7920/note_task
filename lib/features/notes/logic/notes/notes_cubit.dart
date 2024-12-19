import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/either.dart';
import '../../../../core/models/failure.dart';
import '../../models/note_model.dart';
import '../../repos/note_repository.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NoteRepository _noteRepository;
  StreamSubscription<Either<Failure, List<NoteModel>>>?
      _notesStreamSubscription;

  NotesCubit({
    required NoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(const NotesInitialState());

  void fetchNotes() {
    emit(const NotesLoadingState());

    _notesStreamSubscription = _noteRepository.fetchNotes().listen((result) {
      result.fold(
        (failure) => emit(NotesFailureState(message: failure.message)),
        (notes) => emit(NotesSuccessState(notes: notes)),
      );
    });
  }

  @override
  Future<void> close() {
    _notesStreamSubscription?.cancel();
    return super.close();
  }
}
