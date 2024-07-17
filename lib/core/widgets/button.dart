import 'package:flutter/material.dart';

import '../../config/config.dart';

class Button extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadius? radius;
  final VoidCallback onTap;
  final Widget child;

  const Button(
      {super.key,
      this.width,
      this.height,
      this.radius,
      this.color,
      required this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? Dimensions.sizeLargest,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? context.colorScheme.primary,
          borderRadius: radius ?? Dimensions.kBorderRadiusAllSmallest,
        ),
        child: child,
      ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadius? radius;
  final VoidCallback onTap;
  final Widget child;

  const OutlineButton(
      {super.key,
      this.width,
      this.height,
      this.color,
      this.radius,
      required this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? Dimensions.sizeLargest,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: color ?? context.colorScheme.onPrimary,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: radius ?? Dimensions.kBorderRadiusAllSmallest,
        ),
        child: child,
      ),
    );
  }
}
