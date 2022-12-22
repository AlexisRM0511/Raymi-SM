import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raymism/shared/constants.dart';
import 'package:raymism/shared/utils.dart';
import '/rest_services/users/user_controller.dart';
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
        yield SignInState(isLoading: false);
        if (await _userController.signIn(event.email, event.password) != null) {
          Navigator.pushReplacementNamed(event.context, '/home');
        }
      } else {
        yield SignInState(isLoading: false);
        Utils.alertError(Constants.credentialsInvalid);
      }
    }
  }
}
