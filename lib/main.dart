import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/core/bloc_observer/block_observer.dart';
import 'package:notes_app/core/constants/constants.dart';
import 'package:notes_app/core/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/core/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/screens/home_page/home_page.dart';

void main() async {
  Hive.registerAdapter(NoteModelAdapter());

  await Hive.initFlutter();

  Bloc.observer = SimpleBlockObserver();

  await Hive.openBox(kNotesBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddNoteCubit(),
        ),
        BlocProvider(
          create: (context) => NotesCubitCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Poppins',
        ),
        home: const HomePage(),
      ),
    );
  }
}
