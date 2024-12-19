import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/models/either.dart';
import '../../../../core/models/failure.dart';
import '../../models/note_model.dart';
import '../../repos/note_repository.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NoteRepository _noteRepository;
  final SharedPreferences _sharedPreferences;
  StreamSubscription<Either<Failure, List<NoteModel>>>?
      _notesStreamSubscription;

  NotesCubit({
    required NoteRepository noteRepository,
    required SharedPreferences sharedPreferences,
  })  : _noteRepository = noteRepository,
        _sharedPreferences = sharedPreferences,
        super(const NotesInitialState());

  List<NoteModel> _notes = [];
  List<NoteModel> _filteredNotes = [];

  String _query = '';
  List<String> _recentQueries = [];
  List<String> get recentQueries => _recentQueries;

  void fetchNotes() {
    emit(const NotesLoadingState());

    _notesStreamSubscription = _noteRepository.fetchNotes().listen((result) {
      result.fold(
        (failure) => emit(NotesFailureState(message: failure.message)),
        (notes) {
          _notes = notes;
          _getRecentQueries();
          emit(NotesSuccessState(notes: notes, recentSearches: _recentQueries));
        },
      );
    });
  }

  void pinNote({required NoteModel note}) {
    _noteRepository.updateNote(note: note.copyWith(isPinned: !note.isPinned));
  }

  searchNotes({required String query}) {
    _query = query;
     _filteredNotes = _notes
        .where((note) =>
            note.title.toLowerCase().contains(query.toLowerCase()) ||
            note.body.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(NotesSuccessState(
        notes: _filteredNotes, recentSearches: _recentQueries));
  }

  _getRecentQueries() {
    _recentQueries = _sharedPreferences.getStringList('recentQueries') ?? [];
    emit(NotesSuccessState(notes: _filteredNotes, recentSearches: _recentQueries));
  }

  saveRecentQuery() async {
    if (_query.isEmpty) return;
    final recentSearches = _recentQueries;

    if (recentSearches.contains(_query)) recentSearches.remove(_query);
    recentSearches.insert(0, _query);
    if (recentSearches.length > 3) recentSearches.removeLast();

    await _sharedPreferences.setStringList('recentQueries', recentSearches);
    _getRecentQueries();
  }

  @override
  Future<void> close() {
    _notesStreamSubscription?.cancel();
    return super.close();
  }
}
