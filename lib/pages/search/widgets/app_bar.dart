import 'package:flutter/material.dart';
import 'package:raymism/shared/colors.dart';

class AppBarSearch extends StatelessWidget with PreferredSizeWidget {
  final Function onPressed;

  const AppBarSearch({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => onPressed(),
      ),
        title: const Text('Buscar Delito',
            style: TextStyle(color: CustomColor.white)),
        backgroundColor: CustomColor.primaryColor);
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
