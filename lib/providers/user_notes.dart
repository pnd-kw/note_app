import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:note_app/models/note.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'notes.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT, noteContent TEXT, createdAt DATETIME)');
    },
    version: 1,
  );
  return db;
}

class UserNotesNotifier extends StateNotifier<List<Note>> {
  UserNotesNotifier() : super(const []);

  Future<void> loadNote() async {
    final db = await _getDatabase();
    final dbData = await db.query('user_notes');
    final note = dbData
        .map(
          (row) => Note(
              id: row['id'] as String,
              title: row['title'] as String,
              createdAt: row['createdAt'] as String,
              noteContent: row['noteContent'] as String),
        )
        .toList();

    state = note;
  }

  Future<void> deleteNote(Note notes) async {
    final db = await _getDatabase();
    final id = notes.id;
    db.delete('user_notes', where: 'id = ?', whereArgs: [id]);

    state = [notes, ...state];
  }

  void addNote(String title, String noteContent, String createdAt) async {
    final newNote = Note(
      title: title,
      noteContent: noteContent,
      createdAt: createdAt,
    );

    final db = await _getDatabase();
    db.insert('user_notes', {
      'id': newNote.id,
      'title': newNote.title,
      'noteContent': newNote.noteContent,
      'createdAt': newNote.createdAt,
    });

    state = [newNote, ...state];
  }
}

final userNotesProvider = StateNotifierProvider<UserNotesNotifier, List<Note>>(
    (ref) => UserNotesNotifier());
