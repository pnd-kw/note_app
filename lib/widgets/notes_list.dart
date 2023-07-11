import 'package:flutter/material.dart';

import 'package:note_app/models/note.dart';
import 'package:note_app/screens/add_note.dart';

import 'package:note_app/widgets/notes_item.dart';

class NotesList extends StatefulWidget {
  const NotesList({
    super.key,
    required this.notes,
  });

  final List<Note> notes;

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  Icon _searchIcon = const Icon(Icons.search);
  bool isSearchClicked = false;
  final _searchInputController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    if (widget.notes.isEmpty) {
      return Center(
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
      );
    }
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.background),
          backgroundColor: Theme.of(context).colorScheme.primary,
          expandedHeight: 150,
          pinned: true,
          // title: Text(
          //   'Monote',
          //   style: Theme.of(context).textTheme.titleLarge,
          // ),
          actions: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _searchPressed();
                    },
                    icon: _searchIcon,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const AddNoteScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     _searchPressed();
            //   },
            //   icon: _searchIcon,
            // ),
            // IconButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (ctx) => const AddNoteScreen(),
            //       ),
            //     );
            //   },
            //   icon: const Icon(Icons.add),
            // ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            // centerTitle: true,
            titlePadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            title: isSearchClicked
                ? SizedBox(
                    height: 50,
                    width: 250,
                    child: TextField(
                      controller: _searchInputController,
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
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      'Monote',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
            background: Image.asset(
              'assets/images/header-image.webp',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: widget.notes.length,
              (ctx, index) => NotesItem(notes: widget.notes[index]),
            ),
          ),
        ),
      ],
    );
    // return ListView.builder(
    //   itemCount: notes.length,
    //   itemBuilder: (ctx, index) => NotesItem(notes: notes[index]),
    // );
  }
}
