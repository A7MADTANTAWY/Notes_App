import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/widgets/custom_app_bar.dart';

class DetailsPage extends StatelessWidget {
  final NoteModel note;
  const DetailsPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        note: note,
        title: "Details",
        icon: Icons.edit,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: BlocBuilder<NotesCubitCubit, NotesCubitState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      note.content,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          note.date,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 28,
                            color: Colors.redAccent.withOpacity(0.8),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            note.delete();
                            BlocProvider.of<NotesCubitCubit>(context)
                                .loadNotes();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
