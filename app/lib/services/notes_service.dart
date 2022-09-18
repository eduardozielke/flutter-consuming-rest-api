import 'dart:convert';

import 'package:app/models/api_response.dart';
import 'package:app/models/note.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const api = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': 'ed30b444-87b9-4f30-8a47-abcf9fd066e8'};

  Future<APIResponse<List<Note>>> getNotesList() async {
    return http.get(Uri.parse('$api/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonNotes = json.decode(data.body);
        final notes = <Note>[];

        for (var jsonNote in jsonNotes) {
          final note = Note(
            noteID: jsonNote['noteID'],
            noteTitle: jsonNote['noteTitle'],
            createDateTime: DateTime.parse(jsonNote['createDateTime']),
            latestEditDateTime: jsonNote['latestEditDateTime'] != null
                ? DateTime.parse(jsonNote['latestEditDateTime'])
                : null,
          );
          notes.add(note);
        }
        return APIResponse<List<Note>>(
          data: notes,
        );
      }
      return APIResponse<List<Note>>(
        error: true,
        errorMessage: 'An error ocurred',
      );
    }).catchError(
      (_) => APIResponse<List<Note>>(
        error: true,
        errorMessage: 'An error ocurred',
      ),
    );
  }
}
