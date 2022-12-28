import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/rest_services/users/user_controller.dart';
import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_service.dart';

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
          typeUser: 0,
          status: 1,
          isLoading: false);
      Navigator.pop(event.context);
    }

    if (event is UserFillEvent) {
      yield ProfileEditState(isLoading: true);
      UserModel? userModel = await _userController.getCurrentUser();
      if (userModel == null) {
        return;
      }
      yield ProfileEditState(
          dni: userModel.dni as String,
          name: userModel.name as String,
          lastname: userModel.lastname as String,
          username: userModel.username as String,
          email: userModel.email as String,
          phone: userModel.phone as String,
          typeUser: userModel.typeUser as int,
          status: userModel.status as int,
          isLoading: false);
    }

    if (event is UpdateProfileEvent) {
      FocusScope.of(event.context).unfocus();
      if (!event.formKey.currentState!.validate()) {
        print("object");
        return;
      }
      yield ProfileEditState(
          dni: event.dni,
          name: event.name,
          lastname: event.lastname,
          username: event.username,
          email: event.email,
          phone: event.phone,
          isLoading: true);
      UserModel user = UserModel(
          dni: event.dni,
          name: event.name,
          lastname: event.lastname,
          username: event.username,
          email: event.email,
          phone: event.phone);
      if (await _userController.updateUser(user)) {
        Navigator.pop(event.context);
      }
      yield ProfileEditState(
          dni: event.dni,
          name: event.name,
          lastname: event.lastname,
          username: event.username,
          email: event.email,
          phone: event.phone,
          isLoading: false);
    }
  }
}
