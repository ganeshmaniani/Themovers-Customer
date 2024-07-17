import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';

class CustomProductCounterCard extends StatelessWidget {
  final int count;
  final VoidCallback increment;
  final VoidCallback decrement;
  final bool limited;
  final bool isEnable;

  const CustomProductCounterCard({super.key,
    required this.count,
    required this.increment,
    required this.decrement,
    required this.limited,
    required this.isEnable});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: decrement,
          child: Container(
            width: 35.w,
            height: 35.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: count == 0
                  ? const Color(0xFFECECEC)
                  : context.colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.horizontal_rule_rounded,
              color: count == 0 ? Colors.black38 : Colors.white,
              size: Dimensions.iconSizeSmall,
            ),
          ),
        ),
        Dimensions.kHorizontalSpaceSmall,
        Container(
          width: 70.w,
          height: 35.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFB00205)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            count.toString(),
            style: textTheme.headlineMedium,
          ),
        ),
        Dimensions.kHorizontalSpaceSmall,
        InkWell(
          onTap: increment,
          child: Container(
            width: 35.w,
            height: 35.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: limited
                  ? count == 5
                  ? const Color(0xFFECECEC) : isEnable ? context.colorScheme
                  .primary : const Color(0xFFECECEC)
                  : context.colorScheme.primary
              ,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.add,
              color: limited
                  ? count == 5
                  ? Colors.black38
                  : Colors.white
                  : Colors.white,
              size: Dimensions.iconSizeSmall,
            ),
          ),
        ),
      ],
    );
  }
}
