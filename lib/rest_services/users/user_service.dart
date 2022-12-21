import 'dart:convert';
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
  final String apiUrl = "https://limachay.herokuapp.com/users";

  @override
  Future<List<UserModel>?> getUsers() async {
    Uri url = Uri.parse('$apiUrl/all');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      List<UserModel> users = (responseData.data as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
      return users;
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    Uri url = Uri.parse('$apiUrl/$id');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      return UserModel.fromJson(responseData.data);
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<UserModel?> createUser(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email.toString(), password: user.password.toString());

      if (userCredential.user != null) {
        user.id = userCredential.user!.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        return user;
      } else {
        Utils.alertError(Constants.errorCreatingUser);
        return null;
      }
    } on FirebaseAuthException catch (e) {
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
      return null;
    }
  }

  @override
  Future<String?> updateUser(UserModel user) async {
    Uri url = Uri.parse('$apiUrl/update/${user.id}');
    ResponseData responseData = ResponseData.fromJson(
        json.decode((await https.put(url, body: user.toJson())).body));
    if (responseData.status == 200) {
      return "Datos actualizados correctamente";
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<String?> deleteUser(String id) async {
    Uri url = Uri.parse('$apiUrl/delete/$id');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.delete(url)).body));
    if (responseData.status == 200) {
      return "Usuario eliminado correctamente";
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<UserModel?> getUserByDni(String dni) async {
    Uri url = Uri.parse('$apiUrl/dni/$dni');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      if (responseData.data.length > 0) {
        return UserModel.fromJson(responseData.data[0]);
      } else {
        return null;
      }
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    Uri url = Uri.parse('$apiUrl/email/$email');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      if (responseData.data.length > 0) {
        return UserModel.fromJson(responseData.data[0]);
      } else {
        return null;
      }
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<UserModel?> getUserByIdFirebase(String idFirebase) async {
    Uri url = Uri.parse('$apiUrl/idFirebase/$idFirebase');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      if (responseData.data.length > 0) {
        return UserModel.fromJson(responseData.data[0]);
      } else {
        return null;
      }
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }
}
