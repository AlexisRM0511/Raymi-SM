part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchSuesEvent extends SearchEvent {
  final String search;
  SearchSuesEvent({required this.search});
}

class LeadingIconButtonPressedEvent extends SearchEvent {
  final BuildContext context;
  LeadingIconButtonPressedEvent({required this.context});
}

class GoSueDetailEvent extends SearchEvent {
  final BuildContext context;
  final SueModel sue;

  GoSueDetailEvent({required this.context, required this.sue});
}