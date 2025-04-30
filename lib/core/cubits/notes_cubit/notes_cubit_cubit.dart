import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/core/constants/constants.dart';
import 'package:notes_app/core/models/note_model.dart';

part 'notes_cubit_state.dart';

class NotesCubitCubit extends Cubit<NotesCubitState> {
  NotesCubitCubit() : super(NotesCubitInitial());

  List<NoteModel>? notes;
  void loadNotes() {
    var notesBox = Hive.box(kNotesBox);
    notes = notesBox.values.cast<NoteModel>().toList();
    emit(NotesCubitSuccess());
  }
}
