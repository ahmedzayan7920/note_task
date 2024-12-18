import 'package:note_task/core/enums/note_color.dart';

class NoteModel {
  final String id;
  final String title;
  final String body;
  final NoteColor color;
  final DateTime createdAt;
  NoteModel({
    required this.id,
    required this.title,
    required this.body,
    required this.color,
    required this.createdAt,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? body,
    NoteColor? color,
    DateTime? createdAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'color': color.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      color: NoteColor.values.firstWhere(
        (element) => element.name == map['color'] as String,
        orElse: () => NoteColor.teal,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, body: $body, color: $color, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.body == body &&
        other.color == color &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        color.hashCode ^
        createdAt.hashCode;
  }
}
