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

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EventController _eventController = EventController(EventService());
  final UserController _userController = UserController(UserService());

  ProfileBloc() : super(ProfileState(isLoading: true));

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
          isLoading: false);
      Navigator.pop(event.context);
    }

    if (event is UpdateProfileButtonEvent) {
      Navigator.pushNamed(event.context, '/profile_edit');
    }

    if (event is GoEventDetailEvent) {
      Navigator.pushNamed(event.context, '/event_detail',
          arguments: event.event);
      Fluttertoast.showToast(
          msg: 'Evento${event.event.title}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    if (event is UserFillEvent) {
      yield ProfileState(isLoading: true);
      UserModel? user = await _userController.getCurrentUser();
      if (user == null) {
        return;
      }
      List<EventModel>? eventModelList =
          await _eventController.getEventsByUser(user.username as String);
      if (eventModelList == null) {
        return;
      }
      yield ProfileState(
          eventModelList: eventModelList,
          eventMade: eventModelList.length,
          eventApproved: eventModelList
              .where((element) => element.status == 1)
              .toList()
              .length,
          dni: user.dni as String,
          name: user.name as String,
          lastname: user.lastname as String,
          username: user.username as String,
          email: user.email as String,
          phone: user.phone as String,
          isLoading: false);
    }
  }
}
