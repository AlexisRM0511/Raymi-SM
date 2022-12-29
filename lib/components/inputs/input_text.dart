import 'package:flutter/material.dart';
import 'package:raymism/components/label.dart';
import 'package:raymism/shared/colors.dart';

class InputText extends StatelessWidget {
  final String text;
  final TextEditingController textController;

  const InputText({
    Key? key,
    required this.text,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(children: [
              Label(text: text),
              TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: textController,
                  style: const TextStyle(color: CustomColor.black),
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: CustomColor.white,
                      hintText: text,
                      contentPadding: const EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: CustomColor.primaryColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: CustomColor.white),
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'campo obligatorio';
                    }
                    return null;
                  })
            ])));
  }
}
