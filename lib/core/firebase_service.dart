
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/core/models/user.dart';

class FirebaseService {

  static CollectionReference<UserModel> getUserCollection() => FirebaseFirestore
      .instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapShot, _) => UserModel.fromJson(snapShot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );


  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      name: name,
      email: email,
      id: userCredential.user!.uid,
    );
    CollectionReference<UserModel> users = getUserCollection();
    users.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    CollectionReference<UserModel> users = getUserCollection();
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    DocumentSnapshot<UserModel> docSnap =
        await users.doc(userCredential.user!.uid).get();
    return docSnap.data()!;
  }

  static Future logout() => FirebaseAuth.instance.signOut();


}
