import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_task/core/enums/note_color.dart';
import 'package:note_task/features/notes/models/note_model.dart';

import '../../../logic/notes/notes_cubit.dart';
import '../../../logic/notes/notes_state.dart';
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
          return SingleChildScrollView(
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(state.notes.length, (index) {
                final note = state.notes[index];

                return GestureDetector(
                  onTap: () {
                    _showNoteBottomSheet(context, note);
                  },
                  child: Card(
                    color: note.color.getColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  note.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<NotesCubit>()
                                      .pinNote(note: note);
                                },
                                child: Icon(
                                  note.isPinned
                                      ? Icons.push_pin
                                      : Icons.push_pin_outlined,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            note.body,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
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
      isDismissible: false,
      builder: (context) {
        return NoteBottomSheet(note: note);
      },
    );
  }
}