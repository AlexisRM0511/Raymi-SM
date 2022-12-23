part of 'event_bloc.dart';

class EventState {
  final String user;
  final String title;
  final String description;
  final String dateAndTime;
  final String location;
  final String photo;
  final int status;
  final bool isLoading;

  EventState(
      {this.user = '',
      this.title = '',
      this.description = '',
      this.dateAndTime = '',
      this.location = '',
      this.photo = '',
      this.status = -1,
      this.isLoading = false});

  @override
  String toString() {
    return 'EventState{user: $user, title: $title, description: $description, dateAndTime: $dateAndTime, location: $location, photo: $photo, status: $status, isLoading: $isLoading}';
  }
}
