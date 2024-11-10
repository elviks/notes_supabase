import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  PopUp({super.key, required this.textController, required this.saveNote});
  late TextEditingController textController;
  late Function saveNote;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green[600],
      actions: [
        const SizedBox(
          height: 30,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Type here...',
            hintStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          controller: textController,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              onPressed: () {
                saveNote();
                Navigator.pop(context);
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              textColor: Colors.white,
              child: const Text("Save"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              textColor: Colors.white,
              child: const Text("Cancel"),
            )
          ],
        )
      ],
    );
  }
}
