part of 'event_edit_bloc.dart';

@immutable
abstract class EventEditEvent {}

class EventEditButtonPressedEvent extends EventEditEvent {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final String id;
  final String user;
  final String title;
  final String description;
  final String dateAndTime;
  final String location;
  final String photo;
  final int status;
  final bool isKnown;

  EventEditButtonPressedEvent(
      {required this.context,
      required this.formKey,
      required this.id,
      required this.user,
      required this.title,
      required this.description,
      required this.dateAndTime,
      required this.location,
      required this.photo,
      required this.status,
      required this.isKnown});
}

class AddPhotoButtonPressedEvent extends EventEditEvent {
  final BuildContext context;

  AddPhotoButtonPressedEvent({required this.context});
}

class RemovePhotoButtonPressedEvent extends EventEditEvent {}

class LeadingIconButtonPressedEvent extends EventEditEvent {
  final BuildContext context;

  LeadingIconButtonPressedEvent({required this.context});
}

class DescriptionIconButtonPressedEvent extends EventEditEvent {
  final String description;
  DescriptionIconButtonPressedEvent({required this.description});
}

class DescriptionTextEvent extends EventEditEvent {
  final String description;
  final bool isActivated;

  DescriptionTextEvent({required this.description, required this.isActivated});
}
