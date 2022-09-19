import 'package:app/models/note.dart';
import 'package:app/models/note_insert.dart';
import 'package:app/services/notes_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteModify extends StatefulWidget {
  final String? noteId;
  const NoteModify({Key? key, this.noteId}) : super(key: key);

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteId != null;
  bool isLoading = false;

  NotesService get notesService => GetIt.I<NotesService>();

  late String errorMessage;
  late Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    getNote();
    super.initState();
  }

  void getNote() async {
    if (!isEditing) return;

    setState(() => isLoading = true);
    var response = await NotesService().getNote(widget.noteId);

    if (response.error) {
      errorMessage = response.errorMessage;
      setState(() => isLoading = false);
      return;
    }

    note = response.data!;
    titleController.text = note.noteTitle;
    contentController.text = note.noteContent;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'Create note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Visibility(
          visible: isLoading,
          replacement: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Notes title'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(hintText: 'Notes content'),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() => isLoading = true);

                    NoteManipulation note = NoteManipulation(
                      noteTitle: titleController.text,
                      noteContent: contentController.text,
                    );

                    if (isEditing) {
                      final result =
                          await NotesService().updateNote(note, widget.noteId!);
                      final text = result.error
                          ? result.errorMessage
                          : 'Your note was updated';

                      setState(() => isLoading = false);

                      await showDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text('Done'),
                          content: Text(text),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ).then((data) {
                        if (!result.error) {
                          Navigator.of(context).pop();
                        }
                      });
                    } else {
                      final result = await NotesService().createNote(note);
                      final text = result.error
                          ? result.errorMessage
                          : 'Your note was createad';

                      setState(() => isLoading = false);

                      await showDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text('Done'),
                          content: Text(text),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ).then((data) {
                        if (!result.error) {
                          Navigator.of(context).pop();
                        }
                      });
                    }
                    // Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
