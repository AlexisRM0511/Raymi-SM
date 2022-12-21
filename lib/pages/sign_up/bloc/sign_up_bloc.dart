import 'dart:async';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raymism/shared/utils.dart';
import '/rest_services/users/user_controller.dart';
import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_service.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState());
  final UserController _userController = UserController(UserService());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressedEvent) {
      FocusScope.of(event.context).unfocus();
      yield SignUpState(
          dni: event.dni,
          name: event.name,
          lastname: event.lastname,
          username: event.username,
          email: event.email,
          phone: event.phone,
          password: event.password,
          status: 1,
          typeUser: 0,
          isLoading: true);
      if (event.formKey.currentState!.validate()) {
        if (event.formKey.currentState!.validate()) {
          UserModel? user = await _userController.createUser(UserModel(
              dni: event.dni,
              name: event.name,
              lastname: event.lastname,
              username: event.username,
              email: event.email,
              phone: event.phone,
              password: DBCrypt().hashpw(event.password, DBCrypt().gensalt()),
              status: 1,
              typeUser: 0));
          if (user != null) {
            Utils.alertSuccess("Bienvenido ${user.username}");
          } else {
            Utils.alertError("Error al crear el usuario");
          }
          yield SignUpState(isLoading: false);
          Navigator.pushReplacementNamed(event.context, '/home');
        }
      } else {
        yield SignUpState(isLoading: false);
        Fluttertoast.showToast(
            msg: "Complete los campos",
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
