import 'package:flutter/cupertino.dart';
import 'package:raymism/shared/styles.dart';

class TextInfo extends StatelessWidget {
  final String text;

  const TextInfo({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30.0, top: 15.0, bottom: 15.0),
        child: Text(text, style: Styles.textStyle()));
  }
}
