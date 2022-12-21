part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class UpdateProfileButtonEvent extends ProfileEvent {
  final BuildContext context;
  UpdateProfileButtonEvent({required this.context});
}

class UserFillEvent extends ProfileEvent {}

class LeadingIconButtonPressedEvent extends ProfileEvent {
  final BuildContext context;
  LeadingIconButtonPressedEvent({required this.context});
}

class GoEventDetailEvent extends ProfileEvent {
  final BuildContext context;
  final EventModel event;

  GoEventDetailEvent({required this.context, required this.event});
}