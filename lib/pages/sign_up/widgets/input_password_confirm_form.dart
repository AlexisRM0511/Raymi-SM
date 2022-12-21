import 'package:flutter/material.dart';

class InputConfirmPasswordForm extends StatefulWidget {
  final String text;
  final TextEditingController textController;
  final TextEditingController passwordController;

  const InputConfirmPasswordForm({
    Key? key,
    required this.text,
    required this.textController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<InputConfirmPasswordForm> createState() => _InputConfirmPasswordFormState();
}

class _InputConfirmPasswordFormState extends State<InputConfirmPasswordForm> {
  get textController => widget.textController;

  get passwordController => widget.passwordController;

  get text => widget.text;

  bool _passwordInVisible = true; //a boolean value

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final regexPassword = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.09,
            child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: textController,
                obscureText: _passwordInVisible,
                obscuringCharacter: '*',
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: text,
                    contentPadding: const EdgeInsets.only(left: 14.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(
                        _passwordInVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordInVisible = !_passwordInVisible;
                        });
                      },
                    )),
                validator: (value) {
                  if (value.toString().isEmpty ||
                      !regexPassword.hasMatch(value.toString())) {
                    return 'Ingrese una contraseña válida';
                  } else if (value.toString() != passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                })));
  }
}
