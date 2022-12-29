import 'package:flutter/material.dart';
import 'package:raymism/shared/colors.dart';

class InputEmailForm extends StatelessWidget {
  final String text;
  final TextEditingController textController;

  const InputEmailForm({
    Key? key,
    required this.text,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final regexEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.09,
            child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: textController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: text,
                    contentPadding: const EdgeInsets.only(left: 14.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: (value) {
                  if (!regexEmail.hasMatch(value.toString()) ||
                      value.toString().isEmpty) {
                    return 'Por favor ingrese un correo válido';
                  }
                  return null;
                })));
  }
}
