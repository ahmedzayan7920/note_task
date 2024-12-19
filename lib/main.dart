import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/di/di.dart';
import 'features/notes/ui/views/notes_view.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupDependencyInjection();
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
