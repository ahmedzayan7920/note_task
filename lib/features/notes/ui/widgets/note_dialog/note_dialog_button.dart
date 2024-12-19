import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/note_color.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../logic/add_or_update_note/add_or_update_note_cubit.dart';
import '../../../logic/add_or_update_note/add_or_update_note_state.dart';
import '../../../models/note_model.dart';

class NoteDialogButton extends StatelessWidget {
  const NoteDialogButton({
    super.key,
    required this.formKey,
    this.note,
    required this.titleController,
    required this.bodyController,
    required this.selectedColorIndex,
  });

  final GlobalKey<State<StatefulWidget>> formKey;
  final NoteModel? note;
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final int selectedColorIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrUpdateNoteCubit, AddOrUpdateNoteState>(
      builder: (context, state) {
        return CustomElevatedButton(
          text: 'Save',
          isLoading: state is AddOrUpdateNoteLoadingState,
          onPressed: () => _save(context: context),
        );
      },
    );
  }

  _save({required BuildContext context}) {
    if ((formKey.currentState as FormState).validate()) {
      final newNote = NoteModel(
        id: note?.id ?? '',
        title: titleController.text,
        body: bodyController.text,
        color: NoteColor.values[selectedColorIndex],
        createdAt: note?.createdAt ?? DateTime.now(),
        isPinned: note?.isPinned ?? false,
      );
      note != null
          ? BlocProvider.of<AddOrUpdateNoteCubit>(context).updateNote(note: newNote)
          : BlocProvider.of<AddOrUpdateNoteCubit>(context).addNote(note: newNote);
    }
  }
}