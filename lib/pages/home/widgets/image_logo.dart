import 'package:flutter/material.dart';

class ImageLogo extends StatelessWidget {
  const ImageLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset('assets/loginLogo.png',
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.3));
  }
}
