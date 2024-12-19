import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_task/core/enums/note_color.dart';

import '../../../logic/notes/notes_cubit.dart';
import '../../../logic/notes/notes_state.dart';
import 'package:note_task/features/notes/models/note_model.dart';

import 'note_bottom_sheet.dart';

class NotesViewBuilder extends StatelessWidget {
  const NotesViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesFailureState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is NotesSuccessState) {
          return ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              final note = state.notes[index];
              return GestureDetector(
                onTap: () {
                  _showNoteBottomSheet(context, note);
                },
                child: Card(
                  color: note.color.getColor,
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.body),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<dynamic> _showNoteBottomSheet(BuildContext context, NoteModel note) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return NoteBottomSheet(note: note);
      },
    );
  }
}