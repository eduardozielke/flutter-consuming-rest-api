import 'package:app/models/api_response.dart';
import 'package:app/models/note.dart';
import 'package:app/pages/note_delete.dart';
import 'package:app/pages/note_modify.dart';
import 'package:app/services/notes_service.dart';
import 'package:app/utils/format_date_and_time.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.instance<NotesService>();
  late APIResponse<List<Note>> _apiResponse;
  bool _isLoading = false;

  List<Note> notes = [];

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() => _isLoading = true);

    _apiResponse = await service.getNotesList();

    setState(() => _isLoading = false);
  }

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
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }

          return ListView.builder(
            itemCount: _apiResponse.data!.length,
            itemBuilder: (__, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data![index].noteID),
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
                    title: Text(_apiResponse.data![index].noteTitle),
                    subtitle: Text(
                      'Last edited on ${formatDateAndTime(_apiResponse.data![index].getDate!)}',
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
          );
        },
      ),
    );
  }
}
