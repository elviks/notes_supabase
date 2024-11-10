import 'package:flutter/material.dart';
import 'package:learn/utils/notes_tile.dart';
import 'package:learn/utils/pop_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  //create a note
  void addNote() {
    showDialog(
      context: context,
      builder: (context) =>
          PopUp(textController: textController, saveNote: saveNote),
    );
  }

  void saveNote() async {
    await Supabase.instance.client.from('notes').insert(
      {'body': textController.text},
    );
    textController.clear();
  }

  void deleteNote(int noteId) async {
    await Supabase.instance.client.from('notes').delete().eq('id', noteId);
  }

  //read the note
  final _notesStream =
      Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Nottie',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.green[600],
        onPressed: addNote,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapshot) {
          //loading
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //loaded
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final noteId = note['id'] as int;
              final noteText = note['body'];
              return Column(
                children: [
                  NotesTile(
                      deleteNote: deleteNote,
                      noteText: noteText,
                      noteId: noteId),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
