import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';
import 'note_dialog_content_colors.dart';
import 'note_dialog_content_form.dart';
import 'note_dialog_header.dart';

class NoteDialog extends StatefulWidget {
  const NoteDialog({
    super.key,
  });

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final GlobalKey formKey = GlobalKey<FormState>();
  int selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const NoteDialogHeader(title: 'Add Note'),
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
            NoteDialogContentColors(selectedColorIndex: selectedColorIndex),
          ],
        ),
      ),
      actions: [
        CustomElevatedButton(
          text: 'Save',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}