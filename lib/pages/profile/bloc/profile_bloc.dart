import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/rest_services/events/event_controller.dart';
import '/rest_services/events/event_model.dart';
import '/rest_services/events/event_service.dart';
import '/rest_services/users/user_controller.dart';
import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EventController _eventController = EventController(EventService());
  final UserController _userController = UserController(UserService());

  ProfileBloc() : super(ProfileState(isLoading: true)) {
    add(UserFillEvent());
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LeadingIconButtonPressedEvent) {
      yield ProfileState(
          eventModelList: const [],
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

    if (event is GoEventDetailEvent) {
      Navigator.pushNamed(event.context, '/event_detail',arguments: event.event);
      Fluttertoast.showToast(
          msg: 'Denunciar ${event.event.title}',
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
        UserModel? user = await _userController.getUserById(
            sharedPreferences.getString('idFirebase').toString());
        if (user != null) {
          List<EventModel>? eventList =
              await _eventController.getEventsByUser(user.id.toString());

          if (eventList != null) {
            if (eventList.isNotEmpty) {
              yield ProfileState(
                  eventModelList: eventList,
                  eventMade: eventList
                      .where((event) => event.user?.split("|")[1] == user.id)
                      .length,
                  eventApproved: eventList
                      .where((event) => event.user == user.id || event.status == 1)
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
                  eventModelList: const [],
                  eventMade: 0,
                  eventApproved: 0,
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
                eventModelList: const [],
                eventMade: 0,
                eventApproved: 0,
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
