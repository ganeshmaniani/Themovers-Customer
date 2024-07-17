import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';

class CustomStepperStateCard extends StatelessWidget {
  final String index;
  final String label;
  final bool completed;
  final bool active;
  const CustomStepperStateCard(
      {super.key,
      required this.index,
      required this.label,
      required this.completed,
      required this.active});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      children: [
        Container(
          width: 24.h,
          height: 24.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: completed
                ? Colors.green
                : active
                    ? Colors.blue
                    : Colors.white,
            borderRadius: Dimensions.kBorderRadiusAllLarge,
          ),
          child: Text(
            index,
            style: textTheme.titleMedium?.copyWith(
              color: completed || active ? Colors.white : Colors.black54,
            ),
          ),
        ),
        Dimensions.kHorizontalSpaceSmaller,
        Text(
          label,
          style: textTheme.titleMedium?.copyWith(
            color: completed
                ? Colors.green
                : active
                    ? Colors.blue
                    : Colors.black54,
          ),
        ),
      ],
    );
  }
}
