import 'package:flutter/material.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:provider/provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;

  NoteDetailScreen({this.note});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      return;
    }

    final note = Note(
      id: widget.note?.id,
      title: _titleController.text,
      content: _contentController.text,
    );

    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    if (widget.note == null) {
      await noteProvider.addNote(note);
    } else {
      await noteProvider.updateNote(note);
    }

    Navigator.pop(context);
  }

  Future<void> _deleteNote() async {
    if (widget.note != null) {
      final noteProvider = Provider.of<NoteProvider>(context, listen: false);
      await noteProvider.deleteNote(widget.note!.id!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        backgroundColor: Colors.yellow,
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteNote,
            ),
        ],
      ),
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade400,
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
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade400,
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
                child: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Content',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  maxLines: 10,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveNote,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade500,
              ),
              child:const  Text(
                'Save',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
