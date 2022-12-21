import 'package:flutter/material.dart';

class TextSignUpForm extends StatelessWidget {
  final String text;

  const TextSignUpForm({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 30.0),
                child: Text(text, style: style))));
  }
}
