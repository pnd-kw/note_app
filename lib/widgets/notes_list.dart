import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:note_app/models/note.dart';
import 'package:note_app/providers/user_notes.dart';
import 'package:note_app/widgets/custom_scroll_appbar.dart';

import 'package:note_app/widgets/notes_item.dart';

class NotesList extends ConsumerStatefulWidget {
  const NotesList({
    super.key,
    required this.notes,
  });

  final List<Note> notes;

  @override
  ConsumerState<NotesList> createState() => _NotesListState();
}

class _NotesListState extends ConsumerState<NotesList> {
  Icon _searchIcon = const Icon(Icons.search);
  bool isSearchClicked = false;
  final _searchInputController = TextEditingController();
  List<Note> filteredList = [];
  bool searchOnce = false;

  // Transform search button
  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(
          Icons.close,
        );
        isSearchClicked = true;
      } else {
        _searchIcon = const Icon(
          Icons.search,
        );
        isSearchClicked = false;
        _searchInputController.clear();
      }
    });
  }

  void _filterList(value) {
    ref.watch(userNotesProvider.notifier).searchNote(value);
    setState(() {
      filteredList = widget.notes
          .where((notes) =>
              notes.title.toLowerCase().contains(value) ||
              notes.noteContent.toLowerCase().contains(value))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notes.isEmpty) {
      // Render screen if note is empty
      return CustomScrollAppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/add-note-screen');
            },
            icon: const Icon(Icons.add),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            'Monote',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        sliverFillRemaining: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'No notes have been taken yet, let${"'"}s'
              ' write something down to help you remember.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
        ),
      );
    }
    return CustomScrollAppBar(
      actions: [
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              // Search button
              IconButton(
                onPressed: () {
                  _searchPressed();
                },
                icon: _searchIcon,
              ),
              // Add note button
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/add-note-screen');
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
      title: isSearchClicked
          // Render search text field when search button clicked
          ? SizedBox(
              height: 50,
              width: 250,
              child: TextField(
                controller: _searchInputController,
                onChanged: (value) {
                  _filterList(value);
                },
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'search...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            )
          // Render appbar title when search button closed
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                'Monote',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
      sliverPadding: _searchInputController.text.isNotEmpty
          // Render list of note implement filtering
          ? SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: filteredList.length, (context, index) {
                return NotesItem(notes: filteredList[index]);
              }),
            )
          // Render all list of note
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: widget.notes.length, (context, index) {
                return NotesItem(notes: widget.notes[index]);
              }),
            ),
    );
  }
}
