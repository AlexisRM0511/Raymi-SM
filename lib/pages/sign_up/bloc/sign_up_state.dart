part of 'sign_up_bloc.dart';

class SignUpState {
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

  SignUpState(
      {this.dni = '',
      this.name = '',
      this.lastname = '',
      this.username = '',
      this.email = '',
      this.phone = '',
      this.password = '',
      this.typeUser = 0,
      this.status = 1,
      this.isLoading = false});

  @override
  String toString() {
    return 'SignUpState{dni: $dni, name: $name, lastname: $lastname, username: $username, email: $email, phone: $phone, password: $password, typeUser: $typeUser, status: $status, isLoading: $isLoading}';
  }
}
