part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class EventButtonPressed extends EventEvent {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final String title;
  final String description;
  final String dateAndTime;
  final String location;
  final String photo;

  EventButtonPressed(
      {required this.context,
      required this.formKey,
      required this.title,
      required this.description,
      required this.dateAndTime,
      required this.location,
      required this.photo});
}

class LeadingIconButtonPressed extends EventEvent {
  final BuildContext context;

  LeadingIconButtonPressed({required this.context});
}

class AddPhotoButtonPressedEvent extends EventEvent {
  final BuildContext context;

  AddPhotoButtonPressedEvent({required this.context});
}

class RemovePhotoButtonPressedEvent extends EventEvent {}
