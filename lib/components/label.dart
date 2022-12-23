import 'package:flutter/material.dart';
import 'package:raymism/shared/styles.dart';

class Label extends StatelessWidget {
  final String text;

  const Label({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
        child: Text(text, style: Styles.textStyle(16.0)));
  }
}
