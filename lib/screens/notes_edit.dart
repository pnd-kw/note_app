import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/providers/user_notes.dart';

import 'package:note_app/models/note.dart';

class NotesEditScreen extends ConsumerStatefulWidget {
  static const routeName = '/note-edit-screen';

  const NotesEditScreen({
    super.key,
  });

  @override
  ConsumerState<NotesEditScreen> createState() => _NotesEditScreenState();
}

class _NotesEditScreenState extends ConsumerState<NotesEditScreen> {
  final _noteEditController = TextEditingController();

  @override
  void didChangeDependencies() {
    final noteId = ModalRoute.of(context)!.settings.arguments as Note;
    _noteEditController.text = noteId.noteContent;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _noteEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteId = ModalRoute.of(context)!.settings.arguments as Note;

    void editNote() {
      final updatedNoteContent = _noteEditController.text;
      final updatedDate =
          DateFormat('E, d MMM yyyy h:mm a').format(DateTime.now());

      ref
          .read(userNotesProvider.notifier)
          .editNote(noteId.id, updatedNoteContent, updatedDate);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.background,
        ),
        title: Text(
          noteId.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Note'),
                  content: const Text('Do you want to delete this note?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        ref.read(userNotesProvider.notifier).deleteNote(noteId);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/note-screen', (Route<dynamic> route) => false);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: _noteEditController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              minLines: 10,
              maxLines: null,
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                editNote();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/note-screen', (Route<dynamic> route) => false);
              },
              icon: const Icon(Icons.check),
              label: const Text('Save'),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
                foregroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
