import 'package:flutter/material.dart';

import 'features/notes/ui/views/notes_view.dart';

void main() {
  runApp(const NoteTaskApp());
}

class NoteTaskApp extends StatelessWidget {
  const NoteTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotesView(),
    );
  }
}
