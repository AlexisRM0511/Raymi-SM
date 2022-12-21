import 'package:flutter/material.dart';

class TextSueForm extends StatelessWidget {
  final String text;

  const TextSueForm({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 15.0, top: 20.0),
        child: Text(text, style: style));
  }
}
