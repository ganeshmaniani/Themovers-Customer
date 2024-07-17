import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themovers/core/core.dart';

import '../../../../../config/config.dart';

class ForgetPasswordBottomBar extends StatelessWidget {
  final VoidCallback onTap;
  const ForgetPasswordBottomBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return SizedBox(
      height: 350.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 45.h,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 305.h,
              alignment: Alignment.center,
              padding: Dimensions.kPaddingAllMedium,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Dimensions.kBorderRadiusAllMedium,
              ),
              child: Column(
                children: [
                  Dimensions.kVerticalSpaceLarger,
                  Text('Check your email', style: textTheme.displayLarge),
                  Dimensions.kVerticalSpaceMedium,
                  Text(
                    'We have send a OTP to recover\nyour password to your email',
                    style: textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  Dimensions.kSpacer,
                  Button(
                    onTap: onTap,
                    height: 58.h,
                    child: Text(
                      'Done',
                      style: textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 80.w,
              height: 80.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: Dimensions.kBorderRadiusAllMedium,
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.secondary.withOpacity(.3),
                    offset: const Offset(0, 6),
                    blurRadius: 16,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Icon(
                Icons.message_rounded,
                size: Dimensions.iconSizeLarge,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
