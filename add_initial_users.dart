import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class User {
  final String id;
  final String email;
  final String role;

  User({
    required this.id,
    required this.email,
    required this.role,
  });
}

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

Future<void> main() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      authDomain: "YOUR_AUTH_DOMAIN",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_STORAGE_BUCKET",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      appId: "YOUR_APP_ID",
    ),
  );

  final FirestoreService firestoreService = FirestoreService();

  final List<User> initialUsers = [
    User(id: '1', email: 'athlete@example.com', role: 'athlete'),
    User(id: '2', email: 'coach@example.com', role: 'coach'),
    User(id: '3', email: 'admin@example.com', role: 'admin'),
  ];

  for (User user in initialUsers) {
    await firestoreService.addUser(user);
  }

  print('Initial users added to Firestore');
}
