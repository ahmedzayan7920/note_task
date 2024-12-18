import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_text_form_field.dart';

class NoteDialogContentForm extends StatelessWidget {
  const NoteDialogContentForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.bodyController,
  });

  final GlobalKey<State<StatefulWidget>> formKey;
  final TextEditingController titleController;
  final TextEditingController bodyController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Title',
            prefixIcon: Icons.title,
            controller: titleController,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Body',
            prefixIcon: Icons.notes,
            controller: bodyController,
          ),
        ],
      ),
    );
  }
}