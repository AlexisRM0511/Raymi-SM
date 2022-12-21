part of 'profile_bloc.dart';

class ProfileState {
  final List<SueModel> sueModelList;
  final String message;
  final bool isError;
  final int sueMade;
  final int sueApproved;
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
      {this.sueModelList = const [],
      this.message = "No hay delitos registrados",
      this.isError = false,
      this.sueMade = 0,
      this.sueApproved = 0,
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
