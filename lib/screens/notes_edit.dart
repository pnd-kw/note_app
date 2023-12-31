import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/providers/user_notes.dart';

import 'package:note_app/models/note.dart';
import 'package:note_app/widgets/notes_button.dart';
import 'package:note_app/widgets/notes_text_field.dart';

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
  String updatedNoteContent = '';
  final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  final _formEditNote = GlobalKey<FormState>();

  // Get the note initial/latest value
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

    // Edit note function
    void editNote() {
      updatedNoteContent;
      final updatedDate = dateTime;
      // DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      final isValid = _formEditNote.currentState?.validate();

      if (isValid != null && isValid) {
        ref
            .read(userNotesProvider.notifier)
            .editNote(noteId.id, updatedNoteContent, updatedDate);

        Navigator.of(context).pushNamedAndRemoveUntil(
            '/note-screen', (Route<dynamic> route) => false);
      }
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
          // Delete note button
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
            // Current date text
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  'Current Date and Time: $dateTime',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            Form(
              key: _formEditNote,
              child: NotesTextField(
                controller: _noteEditController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field could not be empty.';
                  } else {
                    updatedNoteContent = _noteEditController.text;
                  }
                  return null;
                },
                minLines: 10,
                maxLines: null,
              ),
            ),
            const SizedBox(height: 20),
            // Edit note save button
            NotesButton(
              onPressed: () {
                editNote();
              },
              icon: const Icon(Icons.check),
              label: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
