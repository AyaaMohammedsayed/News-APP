import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/core/models/user.dart';

class AuthApiService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<UserModel> _getUserCollection() {
    return _firestore.collection('users').withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    UserModel user = UserModel(
      name: name,
      email: email,
      id: userCredential.user!.uid,
    );

    await _getUserCollection().doc(user.id).set(user);
    return user;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    DocumentSnapshot<UserModel> docSnap =
        await _getUserCollection().doc(userCredential.user!.uid).get();

    if (docSnap.exists && docSnap.data() != null) {
      return docSnap.data()!;
    } else {
      throw Exception('User data not found in database.');
    }
  }

  Future<void> logout() => _firebaseAuth.signOut();
}