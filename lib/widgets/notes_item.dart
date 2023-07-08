import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/notes_edit.dart';

class NotesItem extends StatelessWidget {
  const NotesItem({
    super.key,
    required this.notes,
  });

  final Note notes;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context)
                .pushNamed(NotesEditScreen.routeName, arguments: notes);
            // // Navigator.of(context).push(
            // //   MaterialPageRoute(
            // //     builder: (ctx) => NotesEditScreen(notes: notes),
            // //   ),
            // );
          },
          title: Text(
            notes.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: notes.noteContent,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text(
                notes.createdAt.toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
          // trailing: IconButton(
          //   onPressed: () {

          //   },
          //   icon: const Icon(Icons.delete),
          // ),
        ),
      ),
    );
  }
}
