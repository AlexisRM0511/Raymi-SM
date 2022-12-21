part of 'profile_edit_bloc.dart';

@immutable
abstract class ProfileEditEvent {}

class LeadingIconButtonPressedEvent extends ProfileEditEvent {
  final BuildContext context;

  LeadingIconButtonPressedEvent({required this.context});
}

class UserFillEvent extends ProfileEditEvent {}

class CheckBoxFormPressedEvent extends ProfileEditEvent {}

class UpdateProfileEvent extends ProfileEditEvent {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final String dni;
  final String name;
  final String lastname;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String passwordBefore;

  UpdateProfileEvent(
      {required this.context,
      required this.formKey,
      required this.dni,
      required this.name,
      required this.lastname,
      required this.username,
      required this.email,
      required this.phone,
      required this.password,
      required this.passwordBefore});
}
