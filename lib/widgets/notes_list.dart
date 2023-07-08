import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/widgets/notes_item.dart';

class NotesList extends StatelessWidget {
  const NotesList({
    super.key,
    required this.notes,
  });

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'No notes have been taken yet, let${"'"}s'
            ' write something down to help you remember.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
      );
    }

    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (ctx, index) => NotesItem(notes: notes[index])
        // ListTile(
        //   title: Text(
        //     notes[index].title,
        //     style: TextStyle(
        //       color: Theme.of(context).colorScheme.onBackground,
        //     ),
        //   ),
        //   subtitle: Text(
        //     notes[index].noteContent,
        //     style: TextStyle(
        //       color: Theme.of(context).colorScheme.onBackground,
        //     ),
        //   ),
        // ),
        );
  }
}
