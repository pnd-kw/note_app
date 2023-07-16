import 'package:uuid/uuid.dart';

// Creating the data model

const uuid = Uuid();

class Note {
  Note({
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.noteContent,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final String createdAt;
  final String updatedAt;
  final String noteContent;
}
