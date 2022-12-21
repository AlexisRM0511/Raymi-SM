import 'package:flutter/material.dart';

class InputPasswordForm extends StatefulWidget {
  final String text;
  final TextEditingController textController;
  final bool checkboxController;

  const InputPasswordForm({
    Key? key,
    required this.text,
    required this.textController,
    required this.checkboxController,
  }) : super(key: key);

  @override
  State<InputPasswordForm> createState() => _InputPasswordFormState();
}

class _InputPasswordFormState extends State<InputPasswordForm> {
  get textController => widget.textController;

  get text => widget.text;

  get checkboxController => widget.checkboxController;

  bool _passwordInVisible = true;

  @override
  Widget build(BuildContext context) {
    final regexPassword = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.09,
            child: TextFormField(
                readOnly: !checkboxController,
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
                        color: Colors.black,
                        disabledColor: Colors.grey,
                        alignment: Alignment.centerRight,
                        icon: Icon(_passwordInVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: checkboxController
                            ? () => setState(
                                () => _passwordInVisible = !_passwordInVisible)
                            : null)),
                validator: (value) {
                  if (checkboxController &&
                      (value.toString().isEmpty ||
                          !regexPassword.hasMatch(value.toString()))) {
                    return 'Ingrese una contraseña válida';
                  }
                  return null;
                })));
  }
}
