import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:note_app/models/note.dart';

// Database instance
Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'notes.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT, noteContent TEXT, createdAt DATETIME)');
    },
    onUpgrade: (db, oldVersion, newVersion) {
      return db.execute('ALTER TABLE user_notes ADD COLUMN updatedAt DATETIME');
    },
    version: 2,
  );
  return db;
}

class UserNotesNotifier extends StateNotifier<List<Note>> {
  UserNotesNotifier() : super(const []);

  // Load Note Provider
  Future<void> loadNote() async {
    final db = await _getDatabase();
    final dbData = await db.query('user_notes', orderBy: 'updatedAt DESC');
    final note = dbData
        .map(
          (row) => Note(
              id: row['id'] as String,
              title: row['title'] as String,
              createdAt: row['createdAt'] as String,
              updatedAt: row['updatedAt'] as String,
              noteContent: row['noteContent'] as String),
        )
        .toList();

    state = note;
  }

  Future<void> searchNote(String keyword) async {
    final db = await _getDatabase();
    db.query('user_notes',
        where: 'title = ? OR noteContent = ?', whereArgs: [keyword]);
  }

  // Delete Note Provider
  Future<void> deleteNote(Note notes) async {
    final db = await _getDatabase();
    final id = notes.id;
    db.delete('user_notes', where: 'id = ?', whereArgs: [id]);

    state = [...state.where((notes) => notes.id != id)];
  }

  // Edit Note Provider
  Future<void> editNote(String id, String noteContent, String updatedAt) async {
    final db = await _getDatabase();
    db.update(
        'user_notes',
        {
          'noteContent': noteContent,
          'updatedAt': updatedAt,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  // Add Note Provider
  void addNote(String title, String noteContent, String createdAt,
      String updatedAt) async {
    final newNote = Note(
      title: title,
      noteContent: noteContent,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );

    final db = await _getDatabase();
    db.insert('user_notes', {
      'id': newNote.id,
      'title': newNote.title,
      'noteContent': newNote.noteContent,
      'createdAt': newNote.createdAt,
      'updatedAt': newNote.updatedAt,
    });

    state = [newNote, ...state];
  }
}

final userNotesProvider = StateNotifierProvider<UserNotesNotifier, List<Note>>(
    (ref) => UserNotesNotifier());
