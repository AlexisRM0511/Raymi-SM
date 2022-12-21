import 'package:flutter/material.dart';

class TextProfileDatos extends StatelessWidget {
  final String textDni;
  final String textEmail;
  final String textPhone;
  final String textUsername;

  const TextProfileDatos(
      {required this.textDni,
      required this.textEmail,
      required this.textPhone,
      required this.textUsername,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = 15.0;

    TextStyle style =
        const TextStyle(fontSize: size, fontStyle: FontStyle.italic);


    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
          children: [
            Row(children: [
              const Icon(Icons.person, size: size, color: Colors.black),
              const SizedBox(width: 10.0),
              Text(textUsername, style: style),
            ]),
            const SizedBox(height: 5.0),
            Row(children: [
              const Icon(Icons.email, size: size, color: Colors.black),
              const SizedBox(width: 10.0),
              Text(textEmail, style: style),
            ]),
            const SizedBox(height: 5.0),
            Row(children: [
              const Icon(Icons.credit_card, size: size, color: Colors.black),
              const SizedBox(width: 10.0),
              Text(textDni, style: style),
            ]),
            const SizedBox(height: 5.0),
            Row(children: [
              const Icon(Icons.phone, size: size, color: Colors.black),
              const SizedBox(width: 10.0),
              Text(textPhone, style: style),
            ]),
          ]),
    );
  }
}
