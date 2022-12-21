import 'package:flutter/material.dart';

class CheckBoxForm extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  const CheckBoxForm({Key? key, required this.text, required this.controller})
      : super(key: key);

  @override
  State<CheckBoxForm> createState() => _CheckBoxFormState();
}

class _CheckBoxFormState extends State<CheckBoxForm> {
  get text => widget.text;

  get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 10.0),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(text, style: style, textAlign: TextAlign.left)),
          Row(
            children: [
              Checkbox(
                  value: controller.text == "true",
                  onChanged: (value) => setState(() {
                        controller.text = value.toString();
                      })),
              Text(
                  controller.text == "true"
                      ? "Conozco a la persona"
                      : "No conozco a la persona",
                  style: style),
            ],
          ),
        ],
      ),
    );
  }
}
