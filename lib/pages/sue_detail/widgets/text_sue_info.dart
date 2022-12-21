import 'package:flutter/material.dart';

class TextSueInfo extends StatefulWidget {
  final String text;

  const TextSueInfo({required this.text, Key? key}) : super(key: key);

  @override
  State<TextSueInfo> createState() => _TextSueInfoState();
}

class _TextSueInfoState extends State<TextSueInfo> {
  get text => widget.text;

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.only(top: 20.0, bottom: 5.0),
        child: Text(text, style: style));
  }
}
