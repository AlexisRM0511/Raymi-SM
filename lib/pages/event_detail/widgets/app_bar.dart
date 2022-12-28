import 'package:flutter/material.dart';
import 'package:raymism/shared/colors.dart';

class AppBarEventDetail extends StatelessWidget with PreferredSizeWidget {
  final Function onPressed;
  final String title;

  const AppBarEventDetail(
      {Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => onPressed(),
        ),
        title: Text(title, style: const TextStyle(color: CustomColor.white)),
        backgroundColor: CustomColor.primaryColor);
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
