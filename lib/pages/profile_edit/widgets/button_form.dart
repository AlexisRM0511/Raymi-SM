import 'package:flutter/material.dart';

class ButtonForm extends StatelessWidget {
  final String text;
  final Function onPressed;

  const ButtonForm(
      {Key? key, bgColor, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF79E070)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(color: Colors.black, width: 1.0))));

    return ElevatedButton(
        style: buttonStyle,
        onPressed: () => onPressed(),
        child: Text(text, style: const TextStyle(color: Colors.black)));
  }
}
