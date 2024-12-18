import 'package:flutter/material.dart';

import '../../../../../core/enums/note_color.dart';

class NoteDialogContentColors extends StatelessWidget {
  const NoteDialogContentColors({
    super.key,
    required this.selectedColorIndex,
    this.onTap,
  });

  final int selectedColorIndex;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Center(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: NoteColor.values.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final color = NoteColor.values[index];
            return GestureDetector(
              onTap:()=> onTap?.call(index),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.getColor,
                  shape: BoxShape.circle,
                  border: selectedColorIndex == index
                      ? Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}