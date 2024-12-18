import 'package:flutter/material.dart';

class NoteDialogHeader extends StatelessWidget {
  const NoteDialogHeader({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
