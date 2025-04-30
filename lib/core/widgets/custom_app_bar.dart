import 'package:flutter/material.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/screens/edit_note_page/edit_note_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final NoteModel? note;
  final String title;
  final IconData icon;
  final Function()? onPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      required this.icon,
      this.note,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      toolbarHeight: 80,
      title: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.1),
            ),
            child: IconButton(
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              onPressed: () {
                if (title == 'Details') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNotePage(
                        note: note!,
                      ),
                    ),
                  );
                } else if (title == 'Edit Note') {
                  onPressed?.call();
                }
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
