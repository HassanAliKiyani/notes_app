import 'package:flutter/material.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:notes_app/screens/notes_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Notes Creator",
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: NoteListScreen(),
      ),
    );
  }
}
