part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class EventButtonPressed extends EventEvent {
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

  EventButtonPressed(
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

class LeadingIconButtonPressed extends EventEvent {
  final BuildContext context;

  LeadingIconButtonPressed({required this.context});
}

class DescriptionTextEvent extends EventEvent {
  final String description;
  final bool isActivated;

  DescriptionTextEvent({required this.description, required this.isActivated});
}

class AddPhotoButtonPressedEvent extends EventEvent {
  final BuildContext context;

  AddPhotoButtonPressedEvent({required this.context});
}

class RemovePhotoButtonPressedEvent extends EventEvent {}

class DescriptionIconButtonPressedEvent extends EventEvent {
  final String description;
  DescriptionIconButtonPressedEvent({required this.description});
}
