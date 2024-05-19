import 'package:flutter/foundation.dart';
import '../models/notes.dart';
import '../database/db_helper.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    _notes = await DatabaseHelper().getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await DatabaseHelper().insert(note);
    await fetchNotes();
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    await DatabaseHelper().update(note);
    await fetchNotes();
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await DatabaseHelper().delete(id);
    await fetchNotes();
    notifyListeners();
  }
}
