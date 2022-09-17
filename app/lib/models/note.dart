class Note {
  String? noteID;
  String noteTitle;
  DateTime? createDateTime;
  DateTime? lastestEditDateTime;

  Note({
    this.noteID,
    this.noteTitle = '',
    this.createDateTime,
    this.lastestEditDateTime,
  });
}
