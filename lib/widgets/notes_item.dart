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
    var initialDate = notes.createdAt.toString;
    var updatedDate = notes.updatedAt.toString;

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
          },
          // Note title
          title: Text(
            notes.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Note content preview
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
              // Note created date and latest update
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Created Date : ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        notes.createdAt.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Latest Update : ',
                        style: TextStyle(fontSize: 10),
                      ),
                      initialDate != updatedDate
                          ? Text(
                              notes.updatedAt.toString(),
                              style: const TextStyle(fontSize: 10),
                            )
                          : Text(
                              notes.createdAt.toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
