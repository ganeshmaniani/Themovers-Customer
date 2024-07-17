import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class CustomBottomSheet extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomBottomSheet({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return BottomSheet(
      onClosing: () {},
      shadowColor: Colors.black,
      builder: (BuildContext context) {
        return Container(
          height: 66.h,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100).w,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.01),
                offset: const Offset(6, 0),
                blurRadius: 16,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Button(
            onTap: onPressed,
            child: Text(
              'Choose Package',
              style: textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
