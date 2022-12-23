import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/rest_services/events/event_controller.dart';
import '/rest_services/events/event_model.dart';
import '/rest_services/events/event_service.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EventController _eventController = EventController(EventService());

  HomeBloc() : super(HomeState(isLoading: true));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ProfileButtonPressedEvent) {
      Navigator.pushNamed(event.context, '/profile');
    }

    if (event is SignOutButtonPressedEvent) {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(event.context, '/');
    }

    if (event is GoSearchEvent) {
      Navigator.pushNamed(event.context, '/search');
    }

    if (event is GoEventEvent) {
      Navigator.pushNamed(event.context, '/event');
    }

    if (event is GoEventDetailEvent) {
      Navigator.pushNamed(event.context, '/event_detail', arguments: event.event);
      Fluttertoast.showToast(
          msg: 'Denunciar ${event.event.title}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    if (event is GoStatisticsEvent) {
      if (await canLaunchUrl(Uri.parse(
          "https://datastudio.google.com/u/0/reporting/2c7eb918-bddd-4e02-87d9-b5f9b569b364/page/XCZyC"))) {
        await launchUrl(
            Uri.parse(
                "https://datastudio.google.com/u/0/reporting/2c7eb918-bddd-4e02-87d9-b5f9b569b364/page/XCZyC"),
            mode: LaunchMode.inAppWebView);
      } else {
        Fluttertoast.showToast(
            msg: 'Error al cargar la visualización de datos',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    if (event is ReloadEventsEvent) {
      yield HomeState(isLoading: true);
      List<EventModel>? eventList = await _eventController.getEvents();
      if (eventList != null) {
        if (eventList.isNotEmpty) {
          yield HomeState(
              isLoading: false,
              isError: false,
              message: "",
              eventModelList: eventList);
        } else {
          yield HomeState(
              isLoading: false,
              isError: false,
              message: "No se encontraron Delitos",
              eventModelList: const []);
        }
      } else {
        yield HomeState(
            isLoading: false,
            isError: true,
            message: "Registro devuelve Null",
            eventModelList: const []);
      }
    }
  }
}
