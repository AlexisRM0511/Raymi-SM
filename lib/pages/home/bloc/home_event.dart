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

class GoSueEvent extends HomeEvent {
  final BuildContext context;

  GoSueEvent({required this.context});
}

class GoStatisticsEvent extends HomeEvent {}

class GoSueDetailEvent extends HomeEvent {
  final BuildContext context;
  final SueModel sue;

  GoSueDetailEvent({required this.context, required this.sue});
}

class ReloadSuesEvent extends HomeEvent {}

class SharedPreferencesEvent extends HomeEvent {}
