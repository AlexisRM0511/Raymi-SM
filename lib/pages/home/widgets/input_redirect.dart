import 'package:flutter/material.dart';

class InputRedirect extends StatelessWidget {
  final String hint;
  final Icon icon;
  final Function onPressed;

  const InputRedirect(
      {Key? key,
      required this.hint,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 10.0, left: 10.0),
        // child: TextField(
        //     readOnly: true,
        //     onTap: () => onPressed(),
        //     decoration: InputDecoration(
        //         border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(30.0)),
        //         hintText: hint,
        //         isDense: true,
        //         suffixIcon: icon)));
        child: OutlinedButton(
            onPressed: () => onPressed(),
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                side: const BorderSide(color: Colors.grey)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(hint, style: const TextStyle(color: Colors.grey)),
                  icon,
                ])));
  }
}
