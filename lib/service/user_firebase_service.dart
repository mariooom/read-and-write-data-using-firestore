import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infodisplay/model/user_firebase_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _usersCollection => _firestore.collection('users');

  Future<void> saveUser(UserFirebaseModel user) async {
    await _usersCollection.add(user.toFirestore());
  }

  Stream<List<UserFirebaseModel>> getUsers() {
    return _usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserFirebaseModel.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null);
      }).toList();
    });
  }

  Future<UserFirebaseModel?> getUserById(String id) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    if (doc.exists) {
      return UserFirebaseModel.fromFirestore(
        doc as DocumentSnapshot<Map<String, dynamic>>,
        null,
      );
    }
    return null;
  }

  Future<void> updateUser(String id, UserFirebaseModel user) async {
    await _usersCollection.doc(id).update(user.toFirestore());
  }

  Future<void> deleteUser(String id) async {
    await _usersCollection.doc(id).delete();
  }
}
