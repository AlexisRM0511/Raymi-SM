import 'package:flutter/material.dart';

class SueInfo extends StatelessWidget {
  final String text;
  final Function onPressed;

  const SueInfo({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(text, style: style)),
      Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
              icon: const Icon(Icons.refresh), onPressed: () => onPressed()))
    ]);
  }
}
