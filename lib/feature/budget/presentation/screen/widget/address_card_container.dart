import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../config/config.dart';

class AddressCardContainer extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPass;
  final Widget child;
  final String pickupOrDropIcon;

  const AddressCardContainer({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPass,
    required this.child,
    required this.pickupOrDropIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: const LineStyle(color: Color(0xFFB40205), thickness: 2),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        indicator: Padding(
          padding: const EdgeInsets.all(2),
          child: SvgPicture.asset(
            pickupOrDropIcon,
            width: 12,
            colorFilter:
                const ColorFilter.mode(Color(0xFFB40205), BlendMode.srcIn),
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
          ),
          child: child,
        ),
      ),
    );
  }
}
