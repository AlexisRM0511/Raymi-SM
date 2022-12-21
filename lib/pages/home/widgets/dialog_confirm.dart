import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool?> showMyDialog(title, description, context) => showDialog<bool>(
    context: context,
    builder: (context) =>
        AlertDialog(title: Text(title), content: Text(description), actions: [
          TextButton(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              Navigator.of(context).pop(false);
            },
            child: const Text("Si quiero salir"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancelar"),
          )
        ]));
