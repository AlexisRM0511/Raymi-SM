import 'package:flutter/material.dart';

class AppBarEventEdit extends StatelessWidget with PreferredSizeWidget {
  final Function onPressed;

  const AppBarEventEdit({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => onPressed(),
        ),
        title: const Text('EventoDelito',
            style: TextStyle(color: Color(0xFFEFEFEF))),
        backgroundColor: const Color(0xFF36A32C));
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
