part of 'sue_edit_bloc.dart';

@immutable
abstract class SueEditEvent {}

class SueEditButtonPressedEvent extends SueEditEvent {
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

  SueEditButtonPressedEvent(
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

class AddPhotoButtonPressedEvent extends SueEditEvent {
  final BuildContext context;

  AddPhotoButtonPressedEvent({required this.context});
}

class RemovePhotoButtonPressedEvent extends SueEditEvent {}

class LeadingIconButtonPressedEvent extends SueEditEvent {
  final BuildContext context;

  LeadingIconButtonPressedEvent({required this.context});
}

class DescriptionIconButtonPressedEvent extends SueEditEvent {
  final String description;
  DescriptionIconButtonPressedEvent({required this.description});
}

class DescriptionTextEvent extends SueEditEvent {
  final String description;
  final bool isActivated;

  DescriptionTextEvent({required this.description, required this.isActivated});
}
