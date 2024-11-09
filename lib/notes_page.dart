import 'package:flutter/material.dart';
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
      builder: (context) => AlertDialog(
        actions: [
          TextField(
            controller: textController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  saveNote();
                  Navigator.pop(context);
                },
                color: Colors.black,
                textColor: Colors.white,
                child: const Text("Save"),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                textColor: Colors.white,
                child: const Text("Cancel"),
              )
            ],
          )
        ],
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
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
              //get individual note
              final note = notes[index];
              final noteId = note['id'] as int; // Ensure noteId is an integer
              final noteText = note['body'];
              return ListTile(
                title: Text(noteText),
                trailing: IconButton(
                  onPressed: () {
                    deleteNote(noteId);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
