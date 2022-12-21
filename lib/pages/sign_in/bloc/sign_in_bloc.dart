import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/rest_services/users/user_controller.dart';
import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_service.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState());
  final UserController _userController = UserController(UserService());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is GoSignUpEvent) {
      Navigator.pushNamed(event.context, '/signup');
    }

    if (event is SignInButtonPressedEvent) {
      FocusScope.of(event.context).unfocus();

      yield SignInState(
          email: event.email, password: event.password, isLoading: true);
      if (event.formKey.currentState!.validate()) {
        late UserCredential? user;

        try {
          user = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
        } on FirebaseAuthException catch (e) {
          user = null;
          yield SignInState(isLoading: false);
          if (e.code == "wrong-password") {
            Fluttertoast.showToast(
                msg: "Contraseña incorrecta",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (e.code == "user-not-found") {
            Fluttertoast.showToast(
                msg: "Usuario no encontrado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (e.code == "user-disabled") {
            Fluttertoast.showToast(
                msg: "Usuario deshabilitado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (e.code == "invalid-email") {
            Fluttertoast.showToast(
                msg: "Correo inválido",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "Error al iniciar sesión",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        if (user != null) {
          UserModel? userModel =
              await _userController.getUserById(user.user!.uid);
          if (userModel != null) {
            Fluttertoast.showToast(
                msg: "Bienvenido ${userModel.username}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            yield SignInState(isLoading: false);

            Navigator.pushReplacementNamed(event.context, '/home');
          } else {
            Fluttertoast.showToast(
                msg: "Error al iniciar sesión",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      } else {
        yield SignInState(isLoading: false);
        Fluttertoast.showToast(
            msg: "Credenciales Incorrectas",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
