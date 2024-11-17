import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReminderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addReminder({
  required String namaObat,
  required String waktuKonsumsi,
  required int konsumsiPerHari,
  required List<String> times,
  String? keterangan,
}) async {
  User? user = _auth.currentUser;
  if (user != null) {
    await _firestore.collection('reminders').add({
      'userId': user.uid,
      'namaObat': namaObat,
      'waktuKonsumsi': waktuKonsumsi,
      'konsumsiPerHari': konsumsiPerHari,
      'times': times,
      'keterangan': keterangan ?? '',
      'timestamp': FieldValue.serverTimestamp(), // Add timestamp field
    });
  } else {
    throw Exception('User not logged in');
  }
}

  Stream<List<Map<String, dynamic>>> getUserRemindersStream() {
    User? user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('reminders')
        .where('userId', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {
              'id': doc.id,
              ...doc.data() as Map<String, dynamic>,
            }).toList());
  }

  Future<void> updateReminder({
  required String id,
  required String namaObat,
  required String waktuKonsumsi,
  required int konsumsiPerHari,
  required List<String> times,
  String? keterangan,
}) async {
  await _firestore.collection('reminders').doc(id).update({
    'namaObat': namaObat,
    'waktuKonsumsi': waktuKonsumsi,
    'konsumsiPerHari': konsumsiPerHari,
    'times': times,
    'keterangan': keterangan ?? '',
  });
}

  Future<void> deleteReminder(String documentId) async {
    await _firestore.collection('reminders').doc(documentId).delete();
  }
}