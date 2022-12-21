part of 'profile_bloc.dart';

class ProfileState {
  final List<EventModel> eventModelList;
  final String message;
  final bool isError;
  final int eventMade;
  final int eventApproved;
  final String dni;
  final String name;
  final String lastname;
  final String username;
  final String email;
  final String phone;
  final String password;
  final int typeUser;
  final int status;
  final bool isLoading;

  ProfileState(
      {this.eventModelList = const [],
      this.message = "No hay delitos registrados",
      this.isError = false,
      this.eventMade = 0,
      this.eventApproved = 0,
      this.dni = '',
      this.name = '',
      this.lastname = '',
      this.username = '',
      this.email = '',
      this.phone = '',
      this.password = '',
      this.typeUser = 0,
      this.status = 1,
      this.isLoading = false});
}
