import 'package:flutter/material.dart';

import '../widgets/search_section.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SearchSection(),
            ],
          ),
        ),
      ),
    );
  }
}
