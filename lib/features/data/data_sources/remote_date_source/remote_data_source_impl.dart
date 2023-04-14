import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_miload/consts.dart';
import 'package:flutter_miload/features/data/data_sources/remote_date_source/remote_data_source.dart';
import 'package:flutter_miload/features/data/models/user/user_model.dart';
import 'package:flutter_miload/features/domain/entities/user/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  FirebaseRemoteDataSourceImpl(
      {required this.firestore, required this.firebaseAuth});
  @override
  Future<void> createUser(UserEnitity user) async {
    final uid = await getCurrentUserId();
    return await firestore.collection(FirebaseConsts.users).doc(uid).set({
      "username": user.username,
      "email": user.email,
      "uid": uid,
    });
  }

  @override
  Future<void> deleteUser(UserEnitity user) {
    throw UnimplementedError();
  }

  @override
  Future<List<UserEnitity>> getAllUsers(UserEnitity user) async {
    final List<UserEnitity> allUsers = [];
    final data = await firestore.collection(FirebaseConsts.users).get();
    for (var item in data.docs) {
      allUsers.add(UserModel.fromMap(item.data()));
    }
    return allUsers;
  }

  @override
  Future<String> getCurrentUserId() async =>  firebaseAuth.currentUser!.uid;

  @override
  Future<UserEnitity> getUser(String uid) {
    return firestore
        .collection(FirebaseConsts.users)
        .doc(uid)
        .get()
        .then((value) => UserModel.fromMap(value.data()!));
  }

  @override
  Future<bool> isSignedIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEnitity user) async {
    try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(msg: "user not found!");
      } else if (e.code == "wrong-password") {
        Fluttertoast.showToast(msg: "invalid email or password");
      }
    }
  }

  @override
  Future<void> signOut() async => firebaseAuth.signOut();

  @override
  Future<void> signUp(UserEnitity user) async {
    try {
     await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((value) async => {
                if (value.user?.uid != null)
                  {
                    await createUser(user),
                  }
              });
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Fluttertoast.showToast(msg: "Email already in use");
      } else {
        Fluttertoast.showToast(msg: "something went wrong");
      }
    }
  }

  @override
  Future<void> updateUser(UserEnitity user) async {
    Map<String, dynamic> userInformation = {};

    if (user.username != '' && user.username != null) {
      userInformation['username'] = user.username;
    }

    firestore
        .collection(FirebaseConsts.users)
        .doc(user.uid)
        .update(userInformation);
  }
}
