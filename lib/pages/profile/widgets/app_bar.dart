import 'package:flutter/material.dart';
import 'package:raymism/shared/colors.dart';

class AppBarProfile extends StatelessWidget with PreferredSizeWidget {
  final Function onPressed;
  final String username;

  const AppBarProfile(
      {Key? key, required this.onPressed, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => onPressed(),
        ),
        title: Text('Perfil de $username',
            style: const TextStyle(color: CustomColor.white)),
        backgroundColor: CustomColor.primaryColor);
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
