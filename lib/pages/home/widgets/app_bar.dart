import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget with PreferredSizeWidget {
  final Function signOutOnPressed;
  final Function profileOnPressed;

  const AppBarHome(
      {required this.signOutOnPressed,
      required this.profileOnPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title:
            const Text('Limachay', style: TextStyle(color: Color(0xFFEFEFEF))),
        backgroundColor: const Color(0xFF36A32C),
        leading: Container(
            alignment: Alignment.center,
            child: Image.asset('assets/icon/logo.png',
                width: 40, height: 40, fit: BoxFit.cover)),
        actions: [
          IconButton(
              icon: const Icon(Icons.account_circle, color: Color(0xFFEFEFEF)),
              onPressed: () => profileOnPressed()),
          IconButton(
              icon: const Icon(Icons.exit_to_app, color: Color(0xFFEFEFEF)),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: const Text('Cerrar sesión'),
                        content: const Text(
                            '¿Estás seguro de que quieres cerrar sesión?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              signOutOnPressed();
                            },
                            child: const Text('Cerrar sesión'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancelar'),
                          )
                        ]);
                  }))
        ]);
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
