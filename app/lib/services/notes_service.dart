import 'dart:convert';

import 'package:app/models/api_response.dart';
import 'package:app/models/note.dart';
import 'package:app/models/notes.dart';
import 'package:app/models/note_insert.dart';
import 'package:app/services/base_api.dart';

class NotesService {
  static const api = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': 'ed30b444-87b9-4f30-8a47-abcf9fd066e8'};

  Future<APIResponse<List<Notes>>> getNotesList() async {
    APIResponse response = await BaseApi().get('/notes');

    if (!response.error) {
      final notes = noteFromJson(response.data);
      return APIResponse<List<Notes>>(
        data: notes,
      );
    }
    return APIResponse<List<Notes>>(
      error: true,
      errorMessage: 'An error ocurred',
    );
  }

  Future<APIResponse<Note>> getNote(noteId) async {
    APIResponse response = await BaseApi().get('/notes/$noteId');

    if (!response.error) {
      final parsedNote = Note.fromJson(json.decode(response.data));
      return APIResponse(data: parsedNote);
    }
    return APIResponse<Note>(
      error: true,
      errorMessage: 'An error ocurred',
    );
  }

  Future<APIResponse<Notes>> createNote(NoteManipulation note) async {
    APIResponse response = await BaseApi().post('/notes', note.toJson());

    if (!response.error) {
      final parsedNote = Notes.fromJson(json.decode(response.data));
      return APIResponse(data: parsedNote);
    }

    return APIResponse<Notes>(
      error: true,
      errorMessage: 'An error ocurred',
    );
  }

  Future<APIResponse> updateNote(
    NoteManipulation note,
    String noteId,
  ) async {
    APIResponse response = await BaseApi().put(
      '/notes/$noteId',
      note.toJson(),
    );

    if (!response.error) {
      return response;
    }

    return APIResponse<Notes>(
      error: true,
      errorMessage: 'An error ocurred',
    );
  }

  Future<APIResponse> deleteNote(String noteId) async {
    APIResponse response = await BaseApi().delete('/notes/$noteId');

    if (!response.error) {
      return response;
    }

    return APIResponse<Notes>(
      error: true,
      errorMessage: 'An error ocurred',
    );
  }
}
