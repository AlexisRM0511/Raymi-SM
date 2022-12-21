import 'dart:io';

import 'package:flutter/material.dart';

class InputPhotoForm extends StatefulWidget {
  final String text;
  final String textController;
  final Function onPressedAnd;
  final Function onPressedDelete;

  const InputPhotoForm({
    Key? key,
    required this.text,
    required this.textController,
    required this.onPressedAnd,
    required this.onPressedDelete,
  }) : super(key: key);

  @override
  State<InputPhotoForm> createState() => _InputPhotoFormState();
}

class _InputPhotoFormState extends State<InputPhotoForm> {
  get textController => widget.textController;

  get text => widget.text;

  get onPressedAnd => widget.onPressedAnd;

  get onPressedDelete => widget.onPressedDelete;

  List<String> photos = [];

  @override
  void initState() {
    super.initState();
    photos.add(textController.toString());
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    photos[0] = textController.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.only(bottom: 20.0),
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 10.0),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              for (var photo in photos)
                if (textController.toString().isNotEmpty)
                  Container(
                      width: 100.0,
                      height: 100.0,
                      margin: const EdgeInsets.only(right: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.center,
                              image: FileImage(File(photo)))),
                      child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => onPressedDelete())),
              Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: textController.toString().isEmpty
                            ? Colors.black
                            : Colors.grey,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: IconButton(
                      disabledColor: Colors.grey,
                      color: Colors.black,
                      icon: const Icon(Icons.add),
                      iconSize: 30.0,
                      onPressed: () => textController.toString().isEmpty
                          ? onPressedAnd()
                          : null))
            ])));
  }
}
