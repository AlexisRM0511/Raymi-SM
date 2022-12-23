import 'package:flutter/material.dart';

import '../../../shared/styles.dart';

class TextEventForm extends StatelessWidget {
  final String text;

  const TextEventForm({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 15.0, top: 20.0),
        child: Text(text, style: Styles.textStyle(24.0)));
  }
}
