import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../feature.dart';

class CustomIconBox extends ConsumerWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const CustomIconBox(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int manPower = ref.watch(budgetControllerProvider).manPowerCount ?? 0;
    return InkWell(
      onTap: label == "Manpower"
          ? onTap
          : manPower != 0
              ? onTap
              : () {},
      borderRadius: Dimensions.kBorderRadiusAllSmaller,
      child: Opacity(
        opacity: label == "Manpower"
            ? 1
            : manPower != 0
                ? 1
                : 0.25,
        child: Container(
          // width: 125,
          // height: 125,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: Dimensions.kBorderRadiusAllSmall,
            border: Border.all(width: 1, color: const Color(0xFFB30205)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(icon),
                height: 50.h, width: 50.w, fit: BoxFit.fill,
                // color: label == 'Manpower'
                //     ? const Color(0xFFB30205)
                //     : manPower != 0
                //         ? const Color(0xFFB30205)
                //         : const Color(0xA0000000)
              ),
              const SizedBox(height: 4),
              Text(label,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1B293D))),
            ],
          ),
        ),
      ),
    );
  }
}
