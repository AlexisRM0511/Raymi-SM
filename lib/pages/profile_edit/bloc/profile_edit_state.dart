part of 'profile_edit_bloc.dart';

class ProfileEditState {
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
  final bool isChecked;

  ProfileEditState({this.dni = '',
    this.name = '',
    this.lastname = '',
    this.username = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.typeUser = 0,
    this.status = 1,
    this.isLoading = false,
    this.isChecked = false});


  @override
  String toString() {
    return 'ProfileEditState{dni: $dni, name: $name, lastname: $lastname, username: $username, email: $email, phone: $phone, password: $password, typeUser: $typeUser, status: $status, isLoading: $isLoading, isChecked: $isChecked}';
  }
}

