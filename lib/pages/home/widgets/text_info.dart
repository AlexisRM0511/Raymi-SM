import 'package:flutter/cupertino.dart';

class TextInfo extends StatelessWidget {
  final String text;

  const TextInfo({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30.0, top: 15.0, bottom: 15.0),
        child: Text(text, style: style));
  }
}
