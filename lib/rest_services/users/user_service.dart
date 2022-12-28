import 'package:dbcrypt/dbcrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raymism/shared/constants.dart';
import 'package:raymism/shared/utils.dart';
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
  Future<UserModel?> readUser(String id) async {
    return await collectionUsers.doc(id).get().then((value) {
      return UserModel.fromJson(value.data() as Map<String, dynamic>);
    }).catchError((e) {
      Utils.alertError(Constants.errorGettingUser);
    });
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    try {
      UserModel? userToUpdate =
          await readUser(FirebaseAuth.instance.currentUser!.uid);
      if (userToUpdate == null) {
        Utils.alertError(Constants.errorGettingUser);
        return false;
      }
      userToUpdate.name = user.name;
      userToUpdate.dni = user.dni;
      userToUpdate.lastname = user.lastname;
      userToUpdate.username = user.username;
      userToUpdate.email = user.email;
      userToUpdate.phone = user.phone;
      FirebaseAuth.instance.currentUser?.reload();
      User? currentUser = FirebaseAuth.instance.currentUser;
      currentUser?.reload().then((_) => currentUser.updateEmail(user.email!));
      await collectionUsers.doc(userToUpdate.id).update(userToUpdate.toJson());
      Utils.alertSuccess(Constants.userUpdated);
      return true;
    } catch (e) {
      Utils.alertError(Constants.errorUpdatingUser);
      return false;
    }
  }

  @override
  Future<bool> deleteUser(String id) async {
    try {
      await collectionUsers.doc(id).delete();
      Utils.alertSuccess(Constants.userDeleted);
      return true;
    } catch (e) {
      Utils.alertError(Constants.errorDeletingUser);
      return false;
    }
  }

  @override
  Future<UserModel?> signIn(String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) async {
      return await readUser(userCredential.user!.uid);
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

  @override
  Future<UserModel?> getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser!
        .reload()
        .then((value) async {
      return await readUser(FirebaseAuth.instance.currentUser!.uid);
    }).catchError((e) {
      Utils.alertError(Constants.errorGettingUser);
    });
  }
}
