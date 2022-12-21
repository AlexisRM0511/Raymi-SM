part of 'sue_bloc.dart';

@immutable
abstract class SueEvent {}

class SueButtonPressed extends SueEvent {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final String user;
  final String title;
  final String description;
  final String dateAndTime;
  final String location;
  final String photo;
  final int status;
  final bool isKnown;

  SueButtonPressed(
      {required this.context,
      required this.formKey,
      required this.user,
      required this.title,
      required this.description,
      required this.dateAndTime,
      required this.location,
      required this.photo,
      required this.status,
      required this.isKnown});
}

class LeadingIconButtonPressed extends SueEvent {
  final BuildContext context;

  LeadingIconButtonPressed({required this.context});
}

class DescriptionTextEvent extends SueEvent {
  final String description;
  final bool isActivated;

  DescriptionTextEvent({required this.description, required this.isActivated});
}

class AddPhotoButtonPressedEvent extends SueEvent {
  final BuildContext context;

  AddPhotoButtonPressedEvent({required this.context});
}

class RemovePhotoButtonPressedEvent extends SueEvent {}

class DescriptionIconButtonPressedEvent extends SueEvent {
  final String description;
  DescriptionIconButtonPressedEvent({required this.description});
}
