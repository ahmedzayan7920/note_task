import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/models/either.dart';
import '../../../core/models/failure.dart';
import '../../../core/utils/firebase_constants.dart';
import '../models/note_model.dart';

class NoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Future<Either<Failure, Unit>> addNote({required NoteModel note}) async {
    try {
      final docRef = _firestore.collection(FirebaseConstants.notes).doc();
      note = note.copyWith(id: docRef.id);
      await docRef.set(note.toJson());
      return Either.right(const Unit());
    } catch (e) {
      return Either.left(Failure.fromException(e));
    }
  }

  Future<Either<Failure, Unit>> updateNote({required NoteModel note}) async {
    try {
      final docRef =
          _firestore.collection(FirebaseConstants.notes).doc(note.id);
      await docRef.set(note.toJson());
      return Either.right(const Unit());
    } catch (e) {
      return Either.left(Failure.fromException(e));
    }
  }

  Future<Either<Failure, Unit>> deleteNote({required String noteId}) async {
    try {
      final docRef = _firestore.collection(FirebaseConstants.notes).doc(noteId);
      await docRef.delete();
      return Either.right(const Unit());
    } catch (e) {
      return Either.left(Failure.fromException(e));
    }
  }

  Stream<Either<Failure, List<NoteModel>>> fetchNotes() async* {
    try {
      final noteStream = _firestore
          .collection(FirebaseConstants.notes)
          .orderBy("isPinned", descending: true)
          .orderBy("createdAt", descending: true)
          .snapshots();
      await for (final snapshot in noteStream) {
        final notes =
            snapshot.docs.map((doc) => NoteModel.fromJson(doc.data())).toList();
        yield Either.right(notes);
      }
    } catch (e) {
      yield Either.left(Failure.fromException(e));
    }
  }
}
