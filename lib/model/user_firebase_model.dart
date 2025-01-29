import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseModel {
  final String? name;
  final String? email;
  final String? hobby;
  final int? age;

  UserFirebaseModel({
    this.name,
    this.email,
    this.hobby,
    this.age,
  });

  factory UserFirebaseModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserFirebaseModel(
      name: data?['name'],
      email: data?['email'],
      hobby: data?['hobby'],
      age: data?['age'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (hobby != null) "hobby": hobby,
      if (age != null) "age": age,
    };
  }
}
