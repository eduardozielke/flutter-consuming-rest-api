import 'package:app/models/note.dart';
import 'package:app/pages/note_delete.dart';
import 'package:app/pages/note_modify.dart';
import 'package:app/utils/format_date_and_time.dart';
import 'package:flutter/material.dart';

class NoteList extends StatelessWidget {
  NoteList({Key? key}) : super(key: key);

  final List<Note> notes = [
    Note(
      noteID: '1',
      createDateTime: DateTime.now(),
      lastestEditDateTime: DateTime.now(),
      noteTitle: 'Note 1',
    ),
    Note(
      noteID: '2',
      createDateTime: DateTime.now(),
      lastestEditDateTime: DateTime.now(),
      noteTitle: 'Note 2',
    ),
    Note(
      noteID: '3',
      createDateTime: DateTime.now(),
      lastestEditDateTime: DateTime.now(),
      noteTitle: 'Note 3',
    ),
    Note(
      noteID: '4',
      createDateTime: DateTime.now(),
      lastestEditDateTime: DateTime.now(),
      noteTitle: 'Note 4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List of notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const NoteModify(),
            ),
          );
        }),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (__, index) {
          return Dismissible(
            key: ValueKey(notes[index].noteID),
            direction: DismissDirection.startToEnd,
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(left: 16),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              final result = await showDialog(
                context: context,
                builder: (_) => const NoteDelete(),
              );
              return result;
            },
            child: Card(
              child: ListTile(
                title: Text(notes[index].noteTitle),
                subtitle: Text(
                  'Last edited on ${formatDateAndTime(notes[index].lastestEditDateTime!)}',
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NoteModify(noteID: '1'),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
