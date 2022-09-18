class Note {
  String? noteID;
  String noteTitle;
  DateTime? createDateTime;
  DateTime? latestEditDateTime;

  DateTime? get getDate {
    if (latestEditDateTime != null) {
      return latestEditDateTime;
    }
    return createDateTime;
  }

  Note({
    this.noteID,
    this.noteTitle = '',
    this.createDateTime,
    this.latestEditDateTime,
  });
}
