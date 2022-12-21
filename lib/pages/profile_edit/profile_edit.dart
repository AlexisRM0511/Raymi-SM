import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/profile_edit/bloc/profile_edit_bloc.dart';
import '/pages/profile_edit/widgets/app_bar.dart';
import '/pages/profile_edit/widgets/button_form.dart';
import '/pages/profile_edit/widgets/checkbox_form.dart';
import '/pages/profile_edit/widgets/input_password_before_form.dart';
import '/pages/profile_edit/widgets/input_password_confirm_form.dart';
import '/pages/profile_edit/widgets/input_dni_form.dart';
import '/pages/profile_edit/widgets/input_email_form.dart';
import '/pages/profile_edit/widgets/input_lastname_form.dart';
import '/pages/profile_edit/widgets/input_name_form.dart';
import '/pages/profile_edit/widgets/input_password_form.dart';
import '/pages/profile_edit/widgets/input_phone_form.dart';
import '/pages/profile_edit/widgets/input_username_form.dart';
import '/pages/profile_edit/widgets/spinner_loading.dart';
import '/pages/profile_edit/widgets/text_info_password_form.dart';
import '/pages/profile_edit/widgets/text_signup_form.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordBeforeController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formProfileEditKey = GlobalKey<FormState>();

  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _isInit = true;
    BlocProvider.of<ProfileEditBloc>(context).add(UserFillEvent());
  }

  @override
  Widget build(BuildContext context) {
    final profileEditBloc = BlocProvider.of<ProfileEditBloc>(context);

    return Scaffold(
        appBar: AppBarProfileEdit(
            onPressed: () => profileEditBloc
                .add(LeadingIconButtonPressedEvent(context: context))),
        body: BlocBuilder<ProfileEditBloc, ProfileEditState>(
            builder: (context, state) {
          if (_isInit && !state.isLoading && state.email.isNotEmpty) {
            _isInit = false;
            _dniController.text = state.dni;
            _nameController.text = state.name;
            _lastnameController.text = state.lastname;
            _usernameController.text = state.username;
            _phoneController.text = state.phone;
            _emailController.text = state.email;
          }

          return Stack(
            children: [
              SafeArea(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                      child: Form(
                          key: _formProfileEditKey,
                          child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: Column(children: [
                                const TextSignUpForm(text: "Edita tu perfil"),
                                InputDniForm(
                                    text: "Dni",
                                    textController: _dniController),
                                InputNameForm(
                                    text: "Nombre",
                                    textController: _nameController),
                                InputLastnameForm(
                                    text: "Apellido",
                                    textController: _lastnameController),
                                InputPhoneForm(
                                    text: "Teléfono",
                                    textController: _phoneController),
                                InputUsernameForm(
                                    text: "Nombre de Usuario",
                                    textController: _usernameController),
                                InputEmailForm(
                                    text: "Correo Electrónico",
                                    textController: _emailController),
                                CheckBoxForm(
                                    text: "¿Deseas cambiar tu contraseña?",
                                    controller: state.isChecked,
                                    onPressed: () => profileEditBloc.add(
                                        CheckBoxFormPressedEvent())),
                                InputPasswordBeforeForm(
                                    text: "Contraseña antigua",
                                    checkboxController: state.isChecked,
                                    passwordBefore: state.password,
                                    textController: _passwordBeforeController),
                                InputPasswordForm(
                                    text: "Contraseña nueva",
                                    checkboxController: state.isChecked,
                                    textController: _passwordController),
                                InputConfirmPasswordForm(
                                    text: "Repetir Contraseña",
                                    checkboxController: state.isChecked,
                                    textController: _confirmPasswordController,
                                    passwordController: _passwordController),
                                const TextInfoPasswordForm(
                                    text:
                                        "* La contraseña debe las siguientes características:\n"
                                        "- Una letra mayúscula\n"
                                        "- Una letra minúscula\n"
                                        "- Un número\n"
                                        "- Uno de los siguientes caracteres (@!%*?&)\n"
                                        "- Una longitud mínima de 8 caracteres"),
                                ButtonForm(
                                    text: "Editar Perfil",
                                    onPressed: () => profileEditBloc.add(
                                        UpdateProfileEvent(
                                            context: context,
                                            formKey: _formProfileEditKey,
                                            dni: _dniController.text,
                                            name: _nameController.text,
                                            lastname: _lastnameController.text,
                                            username: _usernameController.text,
                                            phone: _phoneController.text,
                                            email: _emailController.text,
                                            passwordBefore:
                                                _passwordBeforeController.text,
                                            password:
                                                _passwordController.text))),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05)
                              ]))))),
              SpinnerLoading(isLoading: state.isLoading)
            ],
          );
        }));
  }
}
