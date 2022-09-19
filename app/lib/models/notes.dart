import 'dart:convert';

List<Notes> noteFromJson(String str) =>
    List<Notes>.from(json.decode(str).map((x) => Notes.fromJson(x)));

// String noteToJson(List<Notes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notes {
  String noteId;
  String noteTitle;
  DateTime? createDateTime;
  DateTime? latestEditDateTime;

  DateTime? get getDate {
    if (latestEditDateTime != null) {
      return latestEditDateTime;
    }
    return createDateTime;
  }

  Notes({
    required this.noteId,
    this.noteTitle = '',
    this.createDateTime,
    this.latestEditDateTime,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        noteId: json["noteID"],
        noteTitle: json["noteTitle"],
        createDateTime: DateTime.parse(json['createDateTime']),
        latestEditDateTime: json['latestEditDateTime'] != null
            ? DateTime.parse(json['latestEditDateTime'])
            : null,
      );

  // Map<String, dynamic> toJson() => {
  //     "noteID": noteId,
  //     "noteTitle": noteTitle,
  //     "createDateTime": createDateTime.toIso8601String(),
  //     "latestEditDateTime": latestEditDateTime,
  // };
}
