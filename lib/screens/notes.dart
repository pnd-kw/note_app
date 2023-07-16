import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/providers/user_notes.dart';

// import 'package:note_app/screens/add_note.dart';

import 'package:note_app/widgets/notes_list.dart';

class NotesScreen extends ConsumerStatefulWidget {
  static const routeName = '/note-screen';

  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  late Future<void> _futureNotes;

  @override
  void initState() {
    _futureNotes = ref.read(userNotesProvider.notifier).loadNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userNotes = ref.watch(userNotesProvider);

    return Scaffold(
      body: FutureBuilder(
        future: _futureNotes,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : NotesList(notes: userNotes),
      ),
    );
  }
}
