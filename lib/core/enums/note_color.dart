import 'package:flutter/material.dart';

enum NoteColor {
  teal,
  blueGrey,
  blue,
  peach,
  violet,
}

extension NoteColorExtension on NoteColor {
  Color get getColor {
    switch (this) {
      case NoteColor.teal:
        return const Color(0xFFC3EFD0);
      case NoteColor.blueGrey:
        return const Color(0xFFE2E0F9);
      case NoteColor.blue:
        return const Color(0xFFC0E8FC);
      case NoteColor.peach:
        return const Color(0xFFFFDF99);
      case NoteColor.violet:
        return const Color(0xFFC7B3FC);
    }
  }
}
