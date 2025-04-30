import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/screens/details_page.dart/details_page.dart';
import 'package:notes_app/screens/edit_note_page/edit_note_page.dart';

class Note extends StatelessWidget {
  final NoteModel note;
  const Note({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                note: note,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  note.title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  note.content,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      note.date,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70.withOpacity(0.5),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 28,
                        color: Colors.yellowAccent.withOpacity(0.8),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                    note: note,
                                  )),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNotePage(
                              note: note,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 28,
                        color: Colors.redAccent.withOpacity(0.8),
                      ),
                      onPressed: () {
                        note.delete();
                        BlocProvider.of<NotesCubitCubit>(context).loadNotes();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
