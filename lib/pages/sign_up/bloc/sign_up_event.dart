part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpButtonPressedEvent extends SignUpEvent {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final String dni;
  final String name;
  final String lastname;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  SignUpButtonPressedEvent(
      {required this.context,
      required this.formKey,
      required this.dni,
      required this.name,
      required this.lastname,
      required this.username,
      required this.email,
      required this.phone,
      required this.password,
      required this.confirmPassword});
}
