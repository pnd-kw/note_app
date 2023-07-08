import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/screens/add_note.dart';

import 'package:note_app/screens/notes.dart';
import 'package:note_app/screens/notes_edit.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 248, 17, 56),
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.quicksandTextTheme().copyWith(
    titleSmall: GoogleFonts.quicksand(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.quicksand(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.quicksand(
      fontWeight: FontWeight.bold,
    ),
  ),
);

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const NotesScreen(),
      routes: {
        NotesScreen.routeName: (ctx) => const NotesScreen(),
        AddNoteScreen.routeName: (ctx) => const AddNoteScreen(),
        NotesEditScreen.routeName: (ctx) => const NotesEditScreen(),
      },
    );
  }
}
