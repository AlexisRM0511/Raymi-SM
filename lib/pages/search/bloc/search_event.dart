part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchEventsEvent extends SearchEvent {
  final String search;
  SearchEventsEvent({required this.search});
}

class LeadingIconButtonPressedEvent extends SearchEvent {
  final BuildContext context;
  LeadingIconButtonPressedEvent({required this.context});
}

class GoEventDetailEvent extends SearchEvent {
  final BuildContext context;
  final EventModel event;

  GoEventDetailEvent({required this.context, required this.event});
}