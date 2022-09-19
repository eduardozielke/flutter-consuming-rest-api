class NoteManipulation {
  String noteTitle;
  String noteContent;

  NoteManipulation({
    required this.noteTitle,
    required this.noteContent,
  });

  factory NoteManipulation.fromJson(Map<String, dynamic> json) =>
      NoteManipulation(
        noteTitle: json["noteTitle"],
        noteContent: json["noteContent"],
      );

  Map<String, dynamic> toJson() {
    return {
      "noteTitle": noteTitle,
      "noteContent": noteContent,
    };
  }
}
