import 'dart:convert';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raymism/shared/constants.dart';
import 'package:raymism/shared/utils.dart';
import '/rest_services/response_data.dart';
import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_repository.dart';

class UserService implements UserRepository {
  final CollectionReference collectionUsers =
      FirebaseFirestore.instance.collection(Constants.collectionUsers);

  @override
  Future<UserModel?> createUser(UserModel user) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email.toString(), password: user.password.toString())
        .then((userCredential) async {
      user.id = userCredential.user!.uid;
      user.password =
          DBCrypt().hashpw(user.password.toString(), DBCrypt().gensalt());
      user.createdAt = Timestamp.now();
      await collectionUsers.doc(userCredential.user!.uid).set(user.toJson());
      return user;
    }).catchError((e) {
      switch (e.code) {
        case 'weak-password':
          Utils.alertError(Constants.passwordWeak);
          break;
        case 'email-already-in-use':
          Utils.alertError(Constants.emailInUse);
          break;
        case 'invalid-email':
          Utils.alertError(Constants.invalidEmail);
          break;
        default:
          Utils.alertError(Constants.errorCreatingUser);
          break;
      }
    });
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    return await collectionUsers.doc(id).get().then((value) {
      UserModel userModel =
          UserModel.fromJson(value.data() as Map<String, dynamic>);
      Utils.alertSuccess("Bienvenido ${userModel.name}");
      return userModel;
    }).catchError((e) {
      Utils.alertError(Constants.errorLogin);
    });
  }

  @override
  Future<String?> updateUser(UserModel user) async {}

  @override
  Future<String?> deleteUser(String id) async {}

  @override
  Future<UserModel?> signIn(String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) async {
      return await getUserById(userCredential.user!.uid);
    }).catchError((e) {
      switch ((e as FirebaseAuthException).code) {
        case 'user-not-found':
          Utils.alertError(Constants.userNotFound);
          break;
        case 'wrong-password':
          Utils.alertError(Constants.wrongPassword);
          break;
        case 'invalid-email':
          Utils.alertError(Constants.invalidEmail);
          break;
        case 'user-disabled':
          Utils.alertError(Constants.userDisabled);
          break;
        case 'too-many-requests':
          Utils.alertError(Constants.tooManyRequests);
          break;
        default:
          Utils.alertError(Constants.errorLogin);
          break;
      }
      return null;
    });
  }
}
