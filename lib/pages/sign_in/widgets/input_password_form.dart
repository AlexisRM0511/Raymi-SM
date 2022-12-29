import 'package:flutter/material.dart';
import 'package:raymism/shared/colors.dart';
import 'package:raymism/shared/constants.dart';

class InputPasswordForm extends StatefulWidget {
  final String text;
  final TextEditingController textController;

  const InputPasswordForm({
    Key? key,
    required this.text,
    required this.textController,
  }) : super(key: key);

  @override
  State<InputPasswordForm> createState() => _InputPasswordFormState();
}

class _InputPasswordFormState extends State<InputPasswordForm> {
  get textController => widget.textController;

  get text => widget.text;
  bool _passwordInVisible = true; //a boolean value

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.09,
            child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: textController,
                obscureText: _passwordInVisible,
                obscuringCharacter: '*',
                style: const TextStyle(color: CustomColor.black),
                decoration: InputDecoration(
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
                      borderSide:
                          const BorderSide(color: CustomColor.primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(
                        _passwordInVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordInVisible = !_passwordInVisible;
                        });
                      },
                    )),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return Constants.invalidPassword;
                  }
                  return null;
                })));
  }
}
