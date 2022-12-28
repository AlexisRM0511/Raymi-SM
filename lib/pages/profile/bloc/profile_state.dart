part of 'profile_bloc.dart';

class ProfileState {
  final List<EventModel> eventModelList;
  final int eventMade;
  final int eventApproved;
  final String dni;
  final String name;
  final String lastname;
  final String username;
  final String email;
  final String phone;
  final bool isLoading;

  ProfileState(
      {this.eventModelList = const [],
      this.eventMade = 0,
      this.eventApproved = 0,
      this.dni = '',
      this.name = '',
      this.lastname = '',
      this.username = '',
      this.email = '',
      this.phone = '',
      this.isLoading = false});
}
