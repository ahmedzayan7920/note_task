import 'package:note_task/core/enums/note_color.dart';

class NoteModel {
  final String id;
  final String title;
  final String body;
  final NoteColor color;
  final DateTime createdAt;
  final bool isPinned;

  NoteModel({
    required this.id,
    required this.title,
    required this.body,
    required this.color,
    required this.createdAt,
    required this.isPinned,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? body,
    NoteColor? color,
    DateTime? createdAt,
    bool? isPinned,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'color': color.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isPinned': isPinned,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      color: NoteColor.values.firstWhere(
        (element) => element.name == map['color'],
        orElse: () => NoteColor.teal,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      isPinned: map['isPinned']?? false,
    );
  }

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, body: $body, color: $color, createdAt: $createdAt, isPinned: $isPinned)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.body == body &&
        other.color == color &&
        other.createdAt == createdAt &&
        other.isPinned == isPinned;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        color.hashCode ^
        createdAt.hashCode ^
        isPinned.hashCode;
  }
}