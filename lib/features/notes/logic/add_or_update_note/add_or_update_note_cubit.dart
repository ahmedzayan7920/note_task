import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/note_model.dart';
import '../../repos/note_repository.dart';
import 'add_or_update_note_state.dart';

class AddOrUpdateNoteCubit extends Cubit<AddOrUpdateNoteState> {
  final NoteRepository _noteRepository;

  AddOrUpdateNoteCubit({
    required NoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(const AddOrUpdateNoteInitialState());

  addNote({required NoteModel note}) async {
    emit(const AddOrUpdateNoteLoadingState());
    final result = await _noteRepository.addNote(note: note);
    result.fold(
      (failure) => emit(AddOrUpdateNoteFailureState(message: failure.message)),
      (_) => emit(const AddOrUpdateNoteSuccessState()),
    );
  }

  updateNote({required NoteModel note}) async {
    emit(const AddOrUpdateNoteLoadingState());
    final result = await _noteRepository.updateNote(note: note);
    result.fold(
      (failure) => emit(AddOrUpdateNoteFailureState(message: failure.message)),
      (_) => emit(const AddOrUpdateNoteSuccessState()),
    );
  }
}
