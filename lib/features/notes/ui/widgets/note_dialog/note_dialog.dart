import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_task/features/notes/logic/add_or_update_note/add_or_update_note_cubit.dart';
import 'package:note_task/features/notes/repos/note_repository.dart';

import '../../../logic/add_or_update_note/add_or_update_note_state.dart';
import '../../../models/note_model.dart';
import 'note_dialog_button.dart';
import 'note_dialog_content_colors.dart';
import 'note_dialog_content_form.dart';
import 'note_dialog_header.dart';

class NoteDialog extends StatefulWidget {
  const NoteDialog({
    super.key,
    this.note,
  });
  final NoteModel? note;

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final GlobalKey formKey = GlobalKey<FormState>();
  late int selectedColorIndex;

  @override
  void initState() {
    titleController.text = widget.note?.title ?? '';
    bodyController.text = widget.note?.body ?? '';
    selectedColorIndex = widget.note?.color.index ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOrUpdateNoteCubit(
        noteRepository: NoteRepository(
          firestore: FirebaseFirestore.instance,
        ),
      ),
      child: BlocListener<AddOrUpdateNoteCubit, AddOrUpdateNoteState>(
        listener: (context, state) {
          if (state is AddOrUpdateNoteSuccessState) {
            Navigator.of(context).pop();
          } else if (state is AddOrUpdateNoteFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: AlertDialog(
          title: NoteDialogHeader(
              title: widget.note != null ? 'Edit Note' : 'Add Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NoteDialogContentForm(
                  formKey: formKey,
                  titleController: titleController,
                  bodyController: bodyController,
                ),
                const SizedBox(height: 16),
                NoteDialogContentColors(
                  selectedColorIndex: selectedColorIndex,
                  onTap: (index) {
                    setState(() {
                      selectedColorIndex = index;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            NoteDialogButton(
              formKey: formKey,
              note: widget.note,
              titleController: titleController,
              bodyController: bodyController,
              selectedColorIndex: selectedColorIndex,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}