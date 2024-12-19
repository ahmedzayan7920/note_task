import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/add_or_update_note/add_or_update_note_cubit.dart';
import '../../../logic/add_or_update_note/add_or_update_note_state.dart';
import '../../../models/note_model.dart';
import '../note_dialog/note_dialog.dart';

class NoteBottomSheetHeader extends StatelessWidget {
  const NoteBottomSheetHeader({
    super.key,
    required this.note,
    required this.state,
  });

  final NoteModel note;
  final AddOrUpdateNoteState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: state is AddOrUpdateNoteLoadingState
              ? null
              : () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return NoteDialog(note: note);
                    },
                  );
                },
          icon: const Icon(Icons.edit),
        ),
        TextButton(
          onPressed: state is AddOrUpdateNoteLoadingState
              ? null
              : () {
                  Navigator.of(context).pop();
                },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          child: const Text(
            'Close',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: state is AddOrUpdateNoteLoadingState
              ? null
              : () {
                  context
                      .read<AddOrUpdateNoteCubit>()
                      .deleteNote(noteId: note.id);
                },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}