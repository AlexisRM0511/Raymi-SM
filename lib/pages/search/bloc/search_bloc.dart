import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/rest_services/events/event_controller.dart';
import '/rest_services/events/event_model.dart';
import '/rest_services/events/event_service.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());
  final EventController _eventController = EventController(EventService());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is LeadingIconButtonPressedEvent) {
      yield SearchState(isLoading: false, eventModelList: const []);
      Navigator.pop(event.context);
    }

    if (event is GoEventDetailEvent) {
      Navigator.pushNamed(event.context, '/event_detail',
          arguments: event.event);
      Fluttertoast.showToast(
          msg: 'Evento ${event.event.title}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    if (event is SearchEventsEvent) {
      if (event.search.isEmpty) {
        Fluttertoast.showToast(
            msg: "Ingrese un título para buscar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        yield SearchState(isLoading: true);
        List<EventModel>? events =
            await _eventController.getEventsByTitle(event.search);
        yield SearchState(isLoading: false, eventModelList: events ?? []);
      }
    }
  }
}
