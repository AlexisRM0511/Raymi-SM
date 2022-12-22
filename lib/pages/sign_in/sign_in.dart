import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raymism/shared/colors.dart';
import '/pages/sign_in/bloc/sign_in_bloc.dart';
import '../../components/button.dart';
import '../../components/image_logo.dart';
import '/pages/sign_in/widgets/input_email_form.dart';
import '/pages/sign_in/widgets/input_password_form.dart';
import '../../components/spinner_loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formSignInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signInBloc = BlocProvider.of<SignInBloc>(context);

    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
          body: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
        return Stack(children: [
          SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: CustomColor.backgroundColor,
                  child: Form(
                      key: _formSignInKey,
                      child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(children: [
                            const ImageLogo(width: 0.5, height: 0.5),
                            InputEmailForm(
                                text: 'Correo Electrónico',
                                textController: _emailController),
                            InputPasswordForm(
                                text: 'Contraseña',
                                textController: _passwordController),
                            Button(
                                buttonColor: CustomColor.primaryColor,
                                textColor: CustomColor.white,
                                text: 'Iniciar Sesión',
                                onPressed: () => signInBloc.add(
                                    SignInButtonPressedEvent(
                                        context: context,
                                        formKey: _formSignInKey,
                                        email: _emailController.text,
                                        password: _passwordController.text))),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            const Text("¿No posee una Cuenta aún?"),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Button(
                                buttonColor: CustomColor.white,
                                textColor: CustomColor.black,
                                text: 'Registrarte',
                                onPressed: () => signInBloc
                                    .add(GoSignUpEvent(context: context))),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            const Text("Copyright © Limachay 2022")
                          ]))))),
          SpinnerLoading(isLoading: state.isLoading)
        ]);
      })),
    );
  }
}
