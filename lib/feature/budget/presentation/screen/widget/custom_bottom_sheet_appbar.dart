import 'package:flutter/material.dart';

import '../../../../../config/config.dart';

class CustomBottomSheetAppBar extends StatelessWidget {
  const CustomBottomSheetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // InkWell(
        //   onTap: () => Navigator.pop(context),
        //   child: Icon(
        //     Icons.arrow_back_sharp,
        //     size: Dimensions.iconSizeSmall,
        //   ),
        // ),

        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(width: MediaQuery
              .of(context)
              .size
              .width,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
            ),
            child: Text(
              'Done',
              style:
              context.textTheme.labelLarge?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
// Icon(
//   Icons.clear_rounded,
//   color: context.colorScheme.error,
//   size: Dimensions.iconSizeSmall,
// ),
