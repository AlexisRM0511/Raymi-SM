import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raymism/components/button.dart';
import 'package:raymism/components/spinner_loading.dart';
import '/pages/sign_up/bloc/sign_up_bloc.dart';
import '/pages/sign_up/widgets/input_password_confirm_form.dart';
import '/pages/sign_up/widgets/input_dni_form.dart';
import '/pages/sign_up/widgets/input_email_form.dart';
import '/pages/sign_up/widgets/input_lastname_form.dart';
import '/pages/sign_up/widgets/input_name_form.dart';
import '/pages/sign_up/widgets/input_password_form.dart';
import '/pages/sign_up/widgets/input_phone_form.dart';
import '/pages/sign_up/widgets/input_username_form.dart';
import '/pages/sign_up/widgets/text_info_password_form.dart';
import '/pages/sign_up/widgets/text_signup_form.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formSignUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);

    return Scaffold(
        body: BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return Stack(
        children: [
          SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                  child: Form(
                      key: _formSignUpKey,
                      child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(children: [
                            const TextSignUpForm(text: "R e g í s t r a t e"),
                            InputDniForm(
                                text: "Dni", textController: _dniController),
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
                            InputPasswordForm(
                                text: "Contraseña",
                                textController: _passwordController),
                            InputConfirmPasswordForm(
                                text: "Repetir Contraseña",
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
                            Button(
                                text: "Registrarte",
                                onPressed: () => signUpBloc.add(
                                    SignUpButtonPressedEvent(
                                        context: context,
                                        formKey: _formSignUpKey,
                                        dni: _dniController.text,
                                        name: _nameController.text,
                                        lastname: _lastnameController.text,
                                        username: _usernameController.text,
                                        phone: _phoneController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        confirmPassword:
                                            _confirmPasswordController.text))),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05)
                          ]))))),
          SpinnerLoading(isLoading: state.isLoading)
        ],
      );
    }));
  }
}
