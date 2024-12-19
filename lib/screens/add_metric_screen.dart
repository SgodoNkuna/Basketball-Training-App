import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/performance_metric.dart';

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

  Future<void> addMetric(PerformanceMetric metric) async {
    await _db.collection('metrics').doc(metric.id).set({
      'name': metric.name,
      'description': metric.description,
      'date': metric.date.toIso8601String(),
      'value': metric.value,
    });
  }

  Future<List<PerformanceMetric>> getMetrics() async {
    QuerySnapshot snapshot = await _db.collection('metrics').get();
    return snapshot.docs.map((doc) {
      return PerformanceMetric(
        id: doc.id,
        name: doc['name'],
        description: doc['description'],
        date: DateTime.parse(doc['date']),
        value: doc['value'],
      );
    }).toList();
  }

  Future<void> updateMetric(PerformanceMetric metric) async {
    await _db.collection('metrics').doc(metric.id).update({
      'name': metric.name,
      'description': metric.description,
      'date': metric.date.toIso8601String(),
      'value': metric.value,
    });
  }

  Future<void> deleteMetric(String id) async {
    await _db.collection('metrics').doc(id).delete();
  }
}
