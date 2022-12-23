import 'package:flutter/material.dart';
import 'package:raymism/shared/colors.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color textColor;
  final Color buttonColor;

  const Button(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.textColor,
      required this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(color: CustomColor.black, width: 1.0))));

    return ElevatedButton(
        style: buttonStyle,
        onPressed: () => onPressed(),
        child: Text(text, style: TextStyle(color: textColor)));
  }
}
