import 'package:flutter/material.dart';

class InputDescriptionForm extends StatefulWidget {
  final String text;
  final String stateText;
  final TextEditingController textController;
  final bool isListening;
  final Function onPressed;

  const InputDescriptionForm({
    Key? key,
    required this.text,
    required this.stateText,
    required this.textController,
    required this.onPressed,
    required this.isListening,
  }) : super(key: key);

  @override
  State<InputDescriptionForm> createState() => _InputDescriptionFormState();
}

class _InputDescriptionFormState extends State<InputDescriptionForm> {
  get text => widget.text;

  get stateText => widget.stateText;

  get textController => widget.textController;

  get isListening => widget.isListening;

  get onPressed => widget.onPressed;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    textController.text = stateText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 5,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 500,
                controller: textController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: text,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(left: 14.0),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 10.0,
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                        color: !isListening ? Colors.grey : Colors.lightBlue,
                        icon: const Icon(Icons.mic),
                        onPressed: () => onPressed())),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Por favor ingrese una descripción válida';
                  }
                  return null;
                })));
  }
}
