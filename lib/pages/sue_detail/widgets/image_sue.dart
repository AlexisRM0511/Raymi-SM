import 'package:flutter/material.dart';

class ImageSue extends StatefulWidget {
  final String image;

  const ImageSue({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageSue> createState() => _ImageSueState();
}

class _ImageSueState extends State<ImageSue> {
  get image => widget.image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0)),
        child: (image.isEmpty)
            ? Image.asset('assets/image_not_found.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.fill,
                alignment: FractionalOffset.center)
            : Image.network(image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.fill,
                alignment: FractionalOffset.center));
  }
}
