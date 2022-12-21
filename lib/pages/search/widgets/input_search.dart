import 'package:flutter/material.dart';

class InputSearch extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Function onPressed;

  const InputSearch(
      {Key? key,
      required this.hint,
      required this.onPressed,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                hintText: hint,
                isDense: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => onPressed(),
                ))));
  }
}
