import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/config.dart';

class DateTimePicker extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onTap;
  final bool color;

  const DateTimePicker(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: Dimensions.kBorderRadiusAllSmallest,
          border: Border.all(
            color: const Color(0xFFF7F7F7),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12).h,
              child: Opacity(
                opacity: color ? 0.25 : 1,
                child: Text(
                  label,
                  style: textTheme.labelLarge,
                ),
              ),
            ),
            Dimensions.kSpacer,
            SvgPicture.asset(icon),
            Dimensions.kHorizontalSpaceSmaller
          ],
        ),
      ),
    );
  }
}
