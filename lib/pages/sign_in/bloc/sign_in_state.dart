part of 'sign_in_bloc.dart';

class SignInState {
  final String email;
  final String password;
  final bool isLoading;

  SignInState(
      {this.email = '',
      this.password = '',
      this.isLoading = false});

  @override
  String toString() {
    return 'SignInState{email: $email, password: $password, isLoading: $isLoading}';
  }
}
