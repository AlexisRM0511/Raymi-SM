part of 'event_detail_bloc.dart';

@immutable
abstract class EventDetailEvent {}

class LeadingIconButtonPressedEvent extends EventDetailEvent {
  final BuildContext context;

  LeadingIconButtonPressedEvent({required this.context});
}

class GoEventEditEvent extends EventDetailEvent {
  final BuildContext context;
  final EventModel event;

  GoEventEditEvent({required this.context, required this.event});
}
