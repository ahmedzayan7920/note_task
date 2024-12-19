import 'package:flutter/material.dart';

import '../../models/note_model.dart';

@immutable
sealed class NotesState {
  const NotesState();
}

final class NotesInitialState extends NotesState {
  const NotesInitialState();
}

final class NotesLoadingState extends NotesState {
  const NotesLoadingState();
}

final class NotesFailureState extends NotesState {
  const NotesFailureState({required this.message});
  final String message;
}

final class NotesSuccessState extends NotesState {
  const NotesSuccessState({required this.notes});
  final List<NoteModel> notes;
}
