import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/core/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/screens/home_page/widgets/custom_button.dart';
import 'package:notes_app/core/widgets/custom_text_field.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? title, content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: BlocConsumer<AddNoteCubit, AddNoteState>(
            listener: (context, state) {
              if (state is AddNoteFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is AddNoteSuccess) {
                Navigator.pop(context);
                BlocProvider.of<NotesCubitCubit>(context).loadNotes();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Note added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            builder: (context, state) {
              return state is AddNoteLoading
                  ? Center(child: CircularProgressIndicator())
                  : Form(
                      key: formKey,
                      autovalidateMode: autoValidateMode,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Create New Note',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CustomTextField(
                            onSave: (value) {
                              title = value;
                            },
                            hint: 'Title',
                            maxLines: 1,
                          ),
                          CustomTextField(
                            onSave: (value) {
                              content = value;
                            },
                            hint: 'Content',
                            maxLines: 6,
                          ),
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                NoteModel noteModel = NoteModel(
                                  title: title!,
                                  content: content!,
                                  date: DateFormat('dd-MM-yyyy hh:mm a')
                                      .format(DateTime.now()),
                                );
                                BlocProvider.of<AddNoteCubit>(context)
                                    .addNote(noteModel);
                              } else {
                                setState(() {
                                  autoValidateMode = AutovalidateMode.always;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 30),
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
