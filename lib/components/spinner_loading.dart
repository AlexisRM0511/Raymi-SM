import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:raymism/shared/colors.dart';

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
            color: CustomColor.black2,
            child: SpinKitWave(
                size: 40.0,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.isEven
                              ? CustomColor.white
                              : CustomColor.primaryColor));
                })));
  }
}
