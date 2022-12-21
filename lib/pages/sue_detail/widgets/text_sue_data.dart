import 'package:flutter/material.dart';

class TextSueData extends StatefulWidget {
  final String text;

  const TextSueData({Key? key, required this.text}) : super(key: key);

  @override
  State<TextSueData> createState() => _TextSueDescriptionState();
}

class _TextSueDescriptionState extends State<TextSueData> {
  get text => widget.text;

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400);

    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Text(text, style: style));
  }
}
