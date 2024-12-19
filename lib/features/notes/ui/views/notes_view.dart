import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_task/features/notes/repos/note_repository.dart';

import '../../logic/notes/notes_cubit.dart';
import '../widgets/note_dialog/note_dialog.dart';
import '../widgets/notes/notes_view_builder.dart';
import '../widgets/search/search_section.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(
        noteRepository: NoteRepository(
          firestore: FirebaseFirestore.instance,
        ),
      )..fetchNotes(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SearchSection(),
                SizedBox(height: 16),
                Expanded(
                  child: NotesViewBuilder(),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const NoteDialog();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}