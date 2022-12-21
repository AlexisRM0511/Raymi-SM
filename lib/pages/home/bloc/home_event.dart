part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class ProfileButtonPressedEvent extends HomeEvent {
  final BuildContext context;

  ProfileButtonPressedEvent({required this.context});
}

class SignOutButtonPressedEvent extends HomeEvent {
  final BuildContext context;

  SignOutButtonPressedEvent({required this.context});
}

class GoSearchEvent extends HomeEvent {
  final BuildContext context;

  GoSearchEvent({required this.context});
}

class GoEventEvent extends HomeEvent {
  final BuildContext context;

  GoEventEvent({required this.context});
}

class GoStatisticsEvent extends HomeEvent {}

class GoEventDetailEvent extends HomeEvent {
  final BuildContext context;
  final EventModel event;

  GoEventDetailEvent({required this.context, required this.event});
}

class ReloadEventsEvent extends HomeEvent {}

class SharedPreferencesEvent extends HomeEvent {}
