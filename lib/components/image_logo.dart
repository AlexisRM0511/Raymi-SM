import 'package:flutter/material.dart';

class ImageLogo extends StatelessWidget {
  final double width;
  final double height;

  const ImageLogo({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset('assets/icon/logo_red.png',
            width: MediaQuery.of(context).size.width * width,
            height: MediaQuery.of(context).size.height * height));
  }
}
