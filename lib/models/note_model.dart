// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoteModel {
  final String title;
  final String subtitle;
  NoteModel({
    required this.title,
    required this.subtitle,
  });

  NoteModel copyWith({
    String? title,
    String? subtitle,
  }) {
    return NoteModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NoteModel(title: $title, subtitle: $subtitle)';

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.subtitle == subtitle;
  }

  @override
  int get hashCode => title.hashCode ^ subtitle.hashCode;
}
