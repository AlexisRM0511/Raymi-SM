import 'package:flutter/material.dart';

class TextInputEventForm extends StatelessWidget {
  final String text;

  const TextInputEventForm({required this.text, Key? key}) : super(key: key);

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
        child: Text(text, style: style));
  }
}
