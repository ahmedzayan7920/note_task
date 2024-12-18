import 'package:cloud_firestore/cloud_firestore.dart';

class Failure {
  final String message;

  const Failure(this.message);

  factory Failure.fromException(dynamic e) {
    if (e is FirebaseException) {
      return Failure(e.message ?? e.toString());
    } else {
      return Failure(e.toString());
    }
  }
}
