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

class GoSueDetailEvent extends ProfileEvent {
  final BuildContext context;
  final SueModel sue;

  GoSueDetailEvent({required this.context, required this.sue});
}