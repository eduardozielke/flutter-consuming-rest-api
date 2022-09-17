import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  final String? noteID;
  bool get isEditing => noteID != null;

  const NoteModify({Key? key, this.noteID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'Create note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(hintText: 'Note content'),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  if (isEditing) {
                    //Edit note api
                  } else {
                    //Create note api
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
