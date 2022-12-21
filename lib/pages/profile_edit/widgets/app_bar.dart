import 'package:flutter/material.dart';

class AppBarProfileEdit extends StatelessWidget with PreferredSizeWidget {
  final Function onPressed;

  const AppBarProfileEdit({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => onPressed(),
      ),
        title: const Text('Editar Perfil',
            style: TextStyle(color: Color(0xFFEFEFEF))),
        backgroundColor: const Color(0xFF36A32C));
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
