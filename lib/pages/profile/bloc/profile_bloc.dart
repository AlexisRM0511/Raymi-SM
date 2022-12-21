import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/rest_services/sues/sue_controller.dart';
import '/rest_services/sues/sue_model.dart';
import '/rest_services/sues/sue_service.dart';
import '/rest_services/users/user_controller.dart';
import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SueController _sueController = SueController(SueService());
  final UserController _userController = UserController(UserService());

  ProfileBloc() : super(ProfileState(isLoading: true)) {
    add(UserFillEvent());
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LeadingIconButtonPressedEvent) {
      yield ProfileState(
          sueModelList: const [],
          dni: '',
          name: '',
          lastname: '',
          username: '',
          email: '',
          phone: '',
          password: '',
          typeUser: -1,
          status: -1,
          isError: false,
          message: "No se delitos registrados",
          isLoading: false);
      Navigator.pop(event.context);
    }

    if (event is UpdateProfileButtonEvent) {
      Navigator.pushNamed(event.context, '/profile_edit');
    }

    if (event is GoSueDetailEvent) {
      Navigator.pushNamed(event.context, '/sue_detail',arguments: event.sue);
      Fluttertoast.showToast(
          msg: 'Denunciar ${event.sue.title}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    if (event is UserFillEvent) {
      yield ProfileState(isLoading: true);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey('idFirebase')) {
        UserModel? user = await _userController.getUserByIdFirebase(
            sharedPreferences.getString('idFirebase').toString());
        if (user != null) {
          List<SueModel>? sueList =
              await _sueController.getSuesByUser(user.id.toString());

          if (sueList != null) {
            if (sueList.isNotEmpty) {
              yield ProfileState(
                  sueModelList: sueList,
                  sueMade: sueList
                      .where((sue) => sue.user?.split("|")[1] == user.id)
                      .length,
                  sueApproved: sueList
                      .where((sue) => sue.user == user.id || sue.status == 1)
                      .length,
                  dni: user.dni.toString(),
                  name: user.name.toString(),
                  lastname: user.lastname.toString(),
                  email: user.email.toString(),
                  phone: user.phone.toString(),
                  username: user.username.toString(),
                  password: user.password.toString(),
                  isError: false,
                  message: "",
                  isLoading: false);
            } else {
              yield ProfileState(
                  sueModelList: const [],
                  sueMade: 0,
                  sueApproved: 0,
                  dni: user.dni.toString(),
                  name: user.name.toString(),
                  lastname: user.lastname.toString(),
                  email: user.email.toString(),
                  phone: user.phone.toString(),
                  username: user.username.toString(),
                  password: user.password.toString(),
                  isError: true,
                  message: "No se encontraron Delitos",
                  isLoading: false);
            }
          } else {
            yield ProfileState(
                sueModelList: const [],
                sueMade: 0,
                sueApproved: 0,
                dni: user.dni.toString(),
                name: user.name.toString(),
                lastname: user.lastname.toString(),
                email: user.email.toString(),
                phone: user.phone.toString(),
                username: user.username.toString(),
                password: user.password.toString(),
                isError: true,
                message: "Registro devuelve Null",
                isLoading: false);
          }
        } else {
          yield ProfileState(isLoading: false);
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
        yield ProfileState(isLoading: false);
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
