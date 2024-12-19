
import 'package:flutter/material.dart';

@immutable
sealed class AddOrUpdateNoteState {
  const AddOrUpdateNoteState();
}

final class AddOrUpdateNoteInitialState extends AddOrUpdateNoteState {
  const AddOrUpdateNoteInitialState();
}

final class AddOrUpdateNoteLoadingState extends AddOrUpdateNoteState {
  const AddOrUpdateNoteLoadingState();
}

final class AddOrUpdateNoteFailureState extends AddOrUpdateNoteState {
  const AddOrUpdateNoteFailureState({required this.message});
  final String message;
}

final class AddOrUpdateNoteSuccessState extends AddOrUpdateNoteState {
  const AddOrUpdateNoteSuccessState();
}
