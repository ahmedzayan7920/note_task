import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/notes/notes_cubit.dart';
import '../../../logic/notes/notes_state.dart';
import 'recent_search_item.dart';

class RecentSearchSection extends StatelessWidget {
  const RecentSearchSection({
    super.key,
    required Animation<double> animation,
    this.onTap,
  }) : _animation = animation;

  final Animation<double> _animation;
  final void Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey[300]),
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                if (state is NotesSuccessState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.recentSearches.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => onTap?.call(state.recentSearches[index]),
                        child: RecentSearchItem(
                          title: state.recentSearches[index],
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}