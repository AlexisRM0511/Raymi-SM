import 'package:flutter/material.dart';
import 'package:raymism/shared/colors.dart';
import 'package:raymism/shared/constants.dart';

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
        title: const Text(Constants.appName,
            style: TextStyle(color: CustomColor.white)),
        backgroundColor: CustomColor.primaryColor,
        leading: Container(
            alignment: Alignment.center,
            child: Image.asset(Constants.pathLogo,
                width: 40, height: 40, fit: BoxFit.cover)),
        actions: [
          IconButton(
              icon: const Icon(Icons.account_circle, color: CustomColor.white),
              onPressed: () => profileOnPressed()),
          IconButton(
              icon: const Icon(Icons.exit_to_app, color: CustomColor.white),
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
