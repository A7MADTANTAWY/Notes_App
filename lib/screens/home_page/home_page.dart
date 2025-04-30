import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/screens/home_page/widgets/add_note.dart';
import 'package:notes_app/core/widgets/custom_app_bar.dart';
import 'package:notes_app/screens/home_page/widgets/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesCubitCubit>(context).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 55,
        width: 55,
        child: FloatingActionButton(
          elevation: 2,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return AddNote();
              },
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.red.withOpacity(0.8),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      appBar: const CustomAppBar(
        title: 'Notes',
        icon: Icons.search,
      ),
      body: BlocBuilder<NotesCubitCubit, NotesCubitState>(
        builder: (context, state) {
          List<NoteModel> notes = context.read<NotesCubitCubit>().notes ?? [];
          bool hasData = notes.isNotEmpty;
          return hasData
              ? ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Note(
                      note: notes[index],
                    );
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/image/no_data.png",
                      ),
                    ),
                    Center(
                      child: Text(
                        "No notes available Make your\nfirst note",
                        textAlign: TextAlign
                            .center, // مهم علشان يخلي السطور مظبوطة في النص
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
                );
        },
      ),
    );
  }
}
