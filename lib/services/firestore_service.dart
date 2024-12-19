import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    await _db.collection('users').doc(user.id).set({
      'email': user.email,
      'role': user.role,
    });
  }

  Future<User?> getUserByEmail(String email) async {
    QuerySnapshot snapshot = await _db.collection('users').where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      return User(
        id: doc.id,
        email: doc['email'],
        role: doc['role'],
      );
    }
    return null;
  }
}
