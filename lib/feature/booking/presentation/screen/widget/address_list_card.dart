import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../config/config.dart';

class AddressListCard extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPass;
  final String address;
  final String index;
  const AddressListCard(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPass,
      required this.address,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(color: context.colorScheme.primary),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        indicator: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              index,
              style: context.textTheme.labelMedium
                  ?.copyWith(color: context.colorScheme.primary),
            ),
          ),
        ),
      ),
      endChild: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: Dimensions.kBorderRadiusAllSmaller,
            // color: AppColor.lightGrey.withOpacity(.2),
          ),
          child: Text(
            address,
            style: context.textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
