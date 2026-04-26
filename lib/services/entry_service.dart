import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:mood_app/models/mood_entry.dart';

class EntryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  CollectionReference<Map<String, dynamic>>? get _entriesCollection {
    final uid = _uid;

    if (uid == null) {
      return null;
    }

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('entries');
  }

  String generateEntryId(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> saveEntry(MoodEntry entry) async {
    final entries = _entriesCollection;

    if (entries == null) {
      return;
    }

    await entries.doc(entry.id).set(entry.toMap());
  }

  Future<void> deleteEntry(String entryId) async {
    final entries = _entriesCollection;

    if (entries == null) {
      return;
    }

    await entries.doc(entryId).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchAllEntries() {
    final entries = _entriesCollection;

    if (entries == null) {
      return const Stream.empty();
    }

    return entries.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchEntriesForMonth(
    DateTime month,
  ) {
    final entries = _entriesCollection;

    if (entries == null) {
      return const Stream.empty();
    }

    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    return entries
        .where(
          'date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(firstDay),
        )
        .where(
          'date',
          isLessThanOrEqualTo: Timestamp.fromDate(lastDay),
        )
        .orderBy('date')
        .snapshots();
  }
}