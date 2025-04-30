import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/widgets/custom_app_bar.dart';
import 'package:notes_app/core/widgets/custom_text_field.dart';

class EditNotePage extends StatefulWidget {
  final NoteModel note;

  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            widget.note.title = titleController.text;
            widget.note.content = contentController.text;
            widget.note.save();
            BlocProvider.of<NotesCubitCubit>(context).loadNotes();
            Navigator.pop(context);
          } else {
            setState(() {
              autoValidateMode = AutovalidateMode.always;
            });
          }
        },
        icon: Icons.check,
        title: 'Edit Note',
      ),
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              hint: 'Title',
              maxLines: 1,
            ),
            CustomTextField(
              controller: contentController,
              hint: 'Content',
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}
