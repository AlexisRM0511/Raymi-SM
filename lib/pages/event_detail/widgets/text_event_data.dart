import 'package:flutter/material.dart';

class TextEventData extends StatefulWidget {
  final String text;

  const TextEventData({Key? key, required this.text}) : super(key: key);

  @override
  State<TextEventData> createState() => _TextEventDescriptionState();
}

class _TextEventDescriptionState extends State<TextEventData> {
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
