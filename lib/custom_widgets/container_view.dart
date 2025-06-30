import 'package:flutter/material.dart';

class ContainerView extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final DecoratedBox? decoration;
  

  // ignore: use_super_parameters
  const ContainerView({
    super.key,
    required this.child,
    this.color,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration = const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
    )
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(8.0),
      margin: margin ?? const EdgeInsets.all(8.0),
      decoration: decoration?.decoration ?? const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}