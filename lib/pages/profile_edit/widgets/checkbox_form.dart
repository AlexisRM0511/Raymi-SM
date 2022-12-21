import 'package:flutter/material.dart';

class CheckBoxForm extends StatefulWidget {
  final String text;
  final bool controller;
  final Function onPressed;

  const CheckBoxForm(
      {Key? key,
      required this.text,
      required this.controller,
      required this.onPressed})
      : super(key: key);

  @override
  State<CheckBoxForm> createState() => _CheckBoxFormState();
}

class _CheckBoxFormState extends State<CheckBoxForm> {
  get text => widget.text;

  get controller => widget.controller;

  get onPressed => widget.onPressed;

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(bottom: 10.0),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(text, style: style, textAlign: TextAlign.left)),
          Row(
            children: [
              Checkbox(value: controller, onChanged: (value) => onPressed()),
              Text(
                  controller
                      ? "Si quiero cambiar mi contraseña"
                      : "No quiero cambiar mi contraseña",
                  style: style),
            ],
          ),
        ],
      ),
    );
  }
}
