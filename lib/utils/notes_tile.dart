import 'package:flutter/material.dart';

class NotesTile extends StatelessWidget {
  NotesTile(
      {super.key,
      required this.deleteNote,
      required this.noteText,
      required this.noteId});
  late Function deleteNote;
  late String noteText;
  late int noteId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.01;
    return Container(
      margin: EdgeInsets.all(padding), // Vertical margin
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: Colors.green[600], borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          noteText,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          onPressed: () {
            deleteNote(noteId);
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.delete,
              color: Colors.red[400],
            ),
          ),
        ),
      ),
    );
  }
}
