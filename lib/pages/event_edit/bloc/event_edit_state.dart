part of 'event_edit_bloc.dart';

class EventEditState {
  final String user;
  final String title;
  final String description;
  final String dateAndTime;
  final String location;
  final String photo;
  final int status;
  final bool isKnown;
  final bool isLoading;
  final bool isListening;

  EventEditState(
      {this.user = '',
      this.title = '',
      this.description = '',
      this.dateAndTime = '',
      this.location = '',
      this.photo = '',
      this.status = -1,
      this.isKnown = false,
      this.isLoading = false,
      this.isListening = false});

  @override
  String toString() {
    return 'EventState{user: $user, title: $title, description: $description, dateAndTime: $dateAndTime, location: $location, photo: $photo, status: $status, isKnown: $isKnown, isLoading: $isLoading}';
  }
}
