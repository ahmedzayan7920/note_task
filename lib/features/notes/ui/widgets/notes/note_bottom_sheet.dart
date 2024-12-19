import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_task/core/enums/note_color.dart';

import '../../../models/note_model.dart';
import '../note_dialog/note_dialog.dart';

class NoteBottomSheet extends StatelessWidget {
  const NoteBottomSheet({
    super.key,
    required this.note,
  });
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              IconButton(
                onPressed: () {
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
              Expanded(
                child: Text(
                  DateFormat('dd/MM/yyyy hh:mm a').format(note.createdAt),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          Text(
            note.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(note.body),
        ],
      ),
    );
  }
}
