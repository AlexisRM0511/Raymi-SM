import 'package:flutter/material.dart';

class InputLocationForm extends StatelessWidget {
  final String text;
  final TextEditingController textController;

  const InputLocationForm({
    Key? key,
    required this.text,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
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
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Por favor ingrese una ubicación válida';
                  }
                  return null;
                })));
  }
}
