import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/rest_services/events/event_model.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc() : super(EventDetailState());

  @override
  Stream<EventDetailState> mapEventToState(EventDetailEvent event) async* {
    if (event is LeadingIconButtonPressedEvent) {
      Navigator.pop(event.context);
    }

    if (event is GoEventEditEvent) {
      Navigator.pushNamed(event.context, '/event_edit', arguments: event.event);
    }
  }
}
