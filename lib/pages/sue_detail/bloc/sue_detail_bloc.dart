import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/rest_services/sues/sue_model.dart';

part 'sue_detail_event.dart';
part 'sue_detail_state.dart';

class SueDetailBloc extends Bloc<SueDetailEvent, SueDetailState> {
  SueDetailBloc() : super(SueDetailState());

  @override
  Stream<SueDetailState> mapEventToState(SueDetailEvent event) async* {
    if (event is LeadingIconButtonPressedEvent) {
      Navigator.pop(event.context);
    }

    if (event is GoSueEditEvent) {
      Navigator.pushNamed(event.context, '/sue_edit', arguments: event.sue);
    }
  }
}
