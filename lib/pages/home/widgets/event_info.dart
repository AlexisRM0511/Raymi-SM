import 'package:flutter/material.dart';
import 'package:raymism/shared/styles.dart';

class EventInfo extends StatelessWidget {
  final String text;
  final Function onPressed;

  const EventInfo({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(text, style: Styles.textStyle())),
      Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
              icon: const Icon(Icons.refresh), onPressed: () => onPressed()))
    ]);
  }
}
