part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInButtonPressedEvent extends SignInEvent {
  final String email;
  final String password;
  final GlobalKey<FormState> formKey;
  final BuildContext context;

  SignInButtonPressedEvent(
      {required this.context,
      required this.formKey,
      required this.email,
      required this.password});
}

class GoSignUpEvent extends SignInEvent {
  final BuildContext context;
  GoSignUpEvent({required this.context});
}
