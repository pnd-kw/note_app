import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:note_app/providers/user_notes.dart';

class AddNoteScreen extends ConsumerStatefulWidget {
  static const routeName = '/add-note-screen';

  const AddNoteScreen({super.key});

  @override
  ConsumerState<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends ConsumerState<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _noteContentController = TextEditingController();

  // Save Note Function
  void _saveNote() {
    final enteredTitle = _titleController.text;
    final createdDate =
        DateFormat('E, d MMM yyyy h:mm a').format(DateTime.now());
    final updatedDate =
        DateFormat('E, d MMM yyyy h:mm a').format(DateTime.now());
    final enteredContent = _noteContentController.text;

    if (enteredTitle.isEmpty || enteredContent.isEmpty) {
      return;
    }

    ref.read(userNotesProvider.notifier).addNote(
          enteredTitle,
          enteredContent,
          createdDate,
          updatedDate,
        );

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Add a new note',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Current date text
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  DateFormat('E, d MMM yyyy h:mm a').format(DateTime.now()),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            // Note Title TextField
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Note TextField
            TextField(
              controller: _noteContentController,
              decoration: InputDecoration(
                labelText: 'This is my note...',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              minLines: 10,
              maxLines: null,
            ),
            const SizedBox(height: 20),
            // Add Note Button
            TextButton.icon(
              onPressed: () {
                _saveNote();
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Note'),
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
