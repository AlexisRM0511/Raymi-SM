import 'package:flutter/material.dart';

class InputPasswordBeforeForm extends StatefulWidget {
  final String text;
  final TextEditingController textController;
  final bool checkboxController;
  final String passwordBefore;

  const InputPasswordBeforeForm({
    Key? key,
    required this.text,
    required this.textController,
    required this.checkboxController,
    required this.passwordBefore,
  }) : super(key: key);

  @override
  State<InputPasswordBeforeForm> createState() =>
      _InputPasswordBeforeFormState();
}

class _InputPasswordBeforeFormState extends State<InputPasswordBeforeForm> {
  get textController => widget.textController;

  get text => widget.text;

  get passwordBefore => widget.passwordBefore;

  get checkboxController => widget.checkboxController;

  bool _passwordInVisible = true;

  @override
  Widget build(BuildContext context) {
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
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0)),
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
                  if (checkboxController && (value.toString().isEmpty)) {
                    return 'Ingrese una contraseña válida';
                  }
                  return null;
                })));
  }
}
