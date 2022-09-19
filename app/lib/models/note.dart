class Note {
  String? noteID;
  String noteTitle;
  String noteContent;
  DateTime? createDateTime;
  DateTime? latestEditDateTime;

  Note({
    this.noteID,
    this.noteTitle = '',
    this.noteContent = '',
    this.createDateTime,
    this.latestEditDateTime,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      noteID: json['noteID'],
      noteTitle: json['noteTitle'],
      noteContent: json['noteContent'],
      createDateTime: DateTime.parse(json['createDateTime']),
      latestEditDateTime: json['latestEditDateTime'] != null
          ? DateTime.parse(json['latestEditDateTime'])
          : null,
    );
  }
}
