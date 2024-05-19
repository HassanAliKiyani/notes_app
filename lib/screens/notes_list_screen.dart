import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/note_provider.dart';
import 'notes_details_screen.dart';

class NoteListScreen extends StatefulWidget {
  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Color> multicolor = [
    Colors.amber.shade400,
    Colors.red.shade400,
    Colors.green.shade400,
    Colors.blue.shade400,
    Colors.orange.shade400,
    Colors.purple.shade400,
  ];

   @override
  void initState() {
    super.initState();
    context.read<NoteProvider>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.yellow,
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          final notes = noteProvider.notes;
          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet.'));
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: multicolor[index % multicolor.length],
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    note.title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  subtitle: Text(
                    note.content,
                    style: const TextStyle( fontSize: 16),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailScreen(note: note),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => NoteDetailScreen(note: null),
            )
        );
          context.read<NoteProvider>().fetchNotes();
        },
        backgroundColor: Colors.amber.shade500,
        child: const Icon(Icons.add),
      ),
    );
  }
}
