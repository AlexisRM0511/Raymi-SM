part of 'profile_edit_bloc.dart';

class ProfileEditState {
  final String dni;
  final String name;
  final String lastname;
  final String username;
  final String email;
  final String phone;
  final int typeUser;
  final int status;
  final bool isLoading;

  ProfileEditState({this.dni = '',
    this.name = '',
    this.lastname = '',
    this.username = '',
    this.email = '',
    this.phone = '',
    this.typeUser = 0,
    this.status = 1,
    this.isLoading = false});

  @override
  String toString() {
    return 'ProfileEditState{dni: $dni, name: $name, lastname: $lastname, username: $username, email: $email, phone: $phone, typeUser: $typeUser, status: $status, isLoading: $isLoading}';
  }
}

