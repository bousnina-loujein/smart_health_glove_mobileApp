import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  final _db = FirebaseFirestore.instance;

  /// Stream last N readings for the current user, ordered by timestamp desc.
  Stream<QuerySnapshot<Map<String, dynamic>>> liveReadingsStream({int limit = 50}) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return _db
        .collection('users')
        .doc(uid)
        .collection('glove_readings')
        .orderBy('ts', descending: true)
        .limit(limit)
        .snapshots();
  }

  /// Simulate a single sensor reading (for testing UI without ESP32).
  Future<void> simulateOneReading() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final now = DateTime.now();
    final rnd = Random();
    final data = {
      'ts': Timestamp.fromDate(now),
      'finger': 'F${rnd.nextInt(5) + 1}',
      'angle': (rnd.nextDouble() * 90.0), // degrees
      'tremor': (rnd.nextDouble() * 1.5),  // pseudo tremor score
    };
    await _db.collection('users').doc(uid).collection('glove_readings').add(data);
  }
}
