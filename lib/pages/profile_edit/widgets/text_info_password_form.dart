import 'package:flutter/material.dart';

class TextInfoPasswordForm extends StatelessWidget {
  final String text;

  const TextInfoPasswordForm({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 30.0),
                child: Text(text, style: style))));
  }
}
