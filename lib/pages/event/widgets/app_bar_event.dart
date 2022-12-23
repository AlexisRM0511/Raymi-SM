import 'package:flutter/material.dart';
import 'package:raymism/shared/colors.dart';
import 'package:raymism/shared/constants.dart';

class AppBarEvent extends StatelessWidget with PreferredSizeWidget {
  final Function onPressed;

  const AppBarEvent({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => onPressed(),
      ),
        title: const Text(Constants.registerEvent,
            style: TextStyle(color: CustomColor.white)),
        backgroundColor: CustomColor.primaryColor);
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
