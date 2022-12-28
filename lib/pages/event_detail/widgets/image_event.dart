import 'package:flutter/material.dart';

class ImageEvent extends StatefulWidget {
  final String image;

  const ImageEvent({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageEvent> createState() => _ImageEventState();
}

class _ImageEventState extends State<ImageEvent> {
  get image => widget.image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
