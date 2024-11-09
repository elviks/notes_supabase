import 'package:flutter/material.dart';
import 'package:learn/notes_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://anuhbtgkkgjcmzjyoygv.supabase.co",
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFudWhidGdra2dqY216anlveWd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzExNjQ5NjgsImV4cCI6MjA0Njc0MDk2OH0.lPENcDft9VyHI9wDdlfUuWoownNfec0sX0-OSPAwuPE',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotesPage(),
    );
  }
}
