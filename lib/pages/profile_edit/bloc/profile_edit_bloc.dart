import 'dart:async';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/rest_services/users/user_controller.dart';
import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final UserController _userController = UserController(UserService());

  ProfileEditBloc() : super(ProfileEditState(isLoading: true)) {
    add(UserFillEvent());
  }

  @override
  Stream<ProfileEditState> mapEventToState(ProfileEditEvent event) async* {
    if (event is LeadingIconButtonPressedEvent) {
      yield ProfileEditState(
          dni: '',
          name: '',
          lastname: '',
          username: '',
          email: '',
          phone: '',
          password: '',
          typeUser: 0,
          status: 1,
          isLoading: false,
          isChecked: false);
      Navigator.pop(event.context);
    }

    if (event is CheckBoxFormPressedEvent) {
      yield ProfileEditState(
          dni: state.dni,
          name: state.name,
          lastname: state.lastname,
          username: state.username,
          email: state.email,
          phone: state.phone,
          password: state.password,
          typeUser: state.typeUser,
          status: state.status,
          isLoading: false,
          isChecked: !state.isChecked);
    }

    if (event is UpdateProfileEvent) {
      FocusScope.of(event.context).unfocus();
      if (event.formKey.currentState!.validate()) {
        bool userUpdateEmail = false, userUpdatePassword = false;
        yield ProfileEditState(
            dni: state.dni,
            name: state.name,
            lastname: state.lastname,
            username: state.username,
            email: state.email,
            phone: state.phone,
            password: state.password,
            typeUser: state.typeUser,
            status: state.status,
            isChecked: state.isChecked,
            isLoading: true);

        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          try {
            FirebaseAuth.instance.currentUser?.reload();
            await currentUser
                .updateEmail(event.email)
                .then((_) => userUpdateEmail = true);
            if (state.isChecked) {
              if (DBCrypt().checkpw(event.passwordBefore, state.password)) {
                await currentUser
                    .updatePassword(event.password)
                    .then((_) => userUpdatePassword = true)
                    .catchError((onError) => userUpdatePassword = false);

                await currentUser
                    .reauthenticateWithCredential(EmailAuthProvider.credential(
                        email: (userUpdateEmail) ? event.email : state.email,
                        password: (userUpdatePassword)
                            ? event.password
                            : state.email))
                    .then((value) => currentUser = value.user)
                    .catchError((_) => currentUser = null);
              }
            } else {
              userUpdatePassword = true;
            }
          } on FirebaseException catch (_) {
            currentUser = null;
          }
        } else {
          yield ProfileEditState(
              dni: state.dni,
              name: state.name,
              lastname: state.lastname,
              username: state.username,
              email: state.email,
              phone: state.phone,
              password: state.password,
              typeUser: state.typeUser,
              status: state.status,
              isChecked: state.isChecked,
              isLoading: false);
          Fluttertoast.showToast(
              msg: "No se pudo actualizar el usuario",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (userUpdateEmail && userUpdatePassword && currentUser != null) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          if (sharedPreferences.containsKey('idFirebase')) {
            UserModel? user = await _userController.readUser(
                sharedPreferences.getString('idFirebase').toString());
            if (user != null) {
              await _userController.updateUser(
                  UserModel(
                      id: user.id,
                      dni: event.dni,
                      name: event.name,
                      lastname: event.lastname,
                      username: event.username,
                      email: event.email,
                      phone: event.phone,
                      password: state.isChecked
                          ? DBCrypt()
                              .hashpw(event.password, DBCrypt().gensalt())
                          : state.password));
            } else {
              yield ProfileEditState(
                  dni: state.dni,
                  name: state.name,
                  lastname: state.lastname,
                  username: state.username,
                  email: state.email,
                  phone: state.phone,
                  password: state.password,
                  typeUser: state.typeUser,
                  status: state.status,
                  isChecked: state.isChecked,
                  isLoading: false);
              Fluttertoast.showToast(
                  msg: "No se pudo actualizar el usuario",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {
            yield ProfileEditState(
                dni: state.dni,
                name: state.name,
                lastname: state.lastname,
                username: state.username,
                email: state.email,
                phone: state.phone,
                password: state.password,
                typeUser: state.typeUser,
                status: state.status,
                isChecked: state.isChecked,
                isLoading: false);
            Fluttertoast.showToast(
                msg: "No se pudo actualizar el usuario",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          yield ProfileEditState(
              dni: state.dni,
              name: state.name,
              lastname: state.lastname,
              username: state.username,
              email: state.email,
              phone: state.phone,
              password: state.password,
              typeUser: state.typeUser,
              status: state.status,
              isChecked: state.isChecked,
              isLoading: false);
          Fluttertoast.showToast(
              msg: "No se pudo actualizar el usuario",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        yield ProfileEditState(
            dni: state.dni,
            name: state.name,
            lastname: state.lastname,
            username: state.username,
            email: state.email,
            phone: state.phone,
            password: state.password,
            typeUser: state.typeUser,
            status: state.status,
            isChecked: state.isChecked,
            isLoading: false);
        Fluttertoast.showToast(
            msg: "Verifique los campos",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    if (event is UserFillEvent) {
      yield ProfileEditState(isLoading: true);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey('idFirebase')) {
        UserModel? user = await _userController.readUser(
            sharedPreferences.getString('idFirebase').toString());
        if (user != null) {
          yield ProfileEditState(
              dni: user.dni.toString(),
              name: user.name.toString(),
              lastname: user.lastname.toString(),
              username: user.username.toString(),
              email: user.email.toString(),
              phone: user.phone.toString(),
              password: user.password.toString(),
              isLoading: false,
              isChecked: false);
        } else {
          Fluttertoast.showToast(
              msg: 'Error al cargar usuario',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Error al cargar usuario',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
