import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinnerLoading extends StatefulWidget {
  final bool isLoading;

  const SpinnerLoading({Key? key, required this.isLoading}) : super(key: key);

  @override
  State<SpinnerLoading> createState() => _SpinnerLoadingState();
}

class _SpinnerLoadingState extends State<SpinnerLoading> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isLoading,
        child: Container(
            color: Colors.black.withOpacity(0.5),
            child: SpinKitWave(
                size: 40.0,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.isEven
                              ? const Color(0xFFEFEFEF)
                              : const Color(0xFF36A32C)));
                })));
  }
}
