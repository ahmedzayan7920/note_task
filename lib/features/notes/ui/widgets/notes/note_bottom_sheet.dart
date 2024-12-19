import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_task/core/enums/note_color.dart';
import 'package:note_task/features/notes/logic/add_or_update_note/add_or_update_note_cubit.dart';
import 'package:note_task/features/notes/repos/note_repository.dart';

import '../../../logic/add_or_update_note/add_or_update_note_state.dart';
import '../../../models/note_model.dart';
import 'note_bottom_sheet_header.dart';

class NoteBottomSheet extends StatelessWidget {
  const NoteBottomSheet({
    super.key,
    required this.note,
  });
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOrUpdateNoteCubit(
        noteRepository: NoteRepository(
          firestore: FirebaseFirestore.instance,
        ),
      ),
      child: BlocConsumer<AddOrUpdateNoteCubit, AddOrUpdateNoteState>(
        listener: (context, state) {
          if (state is AddOrUpdateNoteSuccessState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: note.color.getColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NoteBottomSheetHeader(note: note, state: state),
                if (state is AddOrUpdateNoteLoadingState)
                  const LinearProgressIndicator(),
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(note.body),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _formatDate(),
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (state is AddOrUpdateNoteFailureState)
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.red,
                        ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final noteDate =
        DateTime(note.createdAt.year, note.createdAt.month, note.createdAt.day);

    if (noteDate == today) {
      return 'Today ${DateFormat('hh:mm a').format(note.createdAt)}';
    } else if (noteDate == yesterday) {
      return 'Yesterday ${DateFormat('hh:mm a').format(note.createdAt)}';
    } else {
      return DateFormat('dd/MM/yyyy hh:mm a').format(note.createdAt);
    }
  }
}
