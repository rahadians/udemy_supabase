// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

import 'dart:convert';

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
  Notes({
    required this.id,
    required this.userId,
    required this.title,
    required this.desc,
    required this.createdAt,
  });

  int id;
  int userId;
  String title;
  String desc;
  String createdAt;

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        desc: json["desc"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "desc": desc,
        "created_at": createdAt,
      };

  static List<Notes> fromJsonList(List list) {
    if (list == null) return List<Notes>.empty();
    return list.map((item) => Notes.fromJson(item)).toList();
  }
}
