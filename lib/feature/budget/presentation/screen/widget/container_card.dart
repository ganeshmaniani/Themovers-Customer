import 'package:flutter/material.dart';

import '../../../../../config/theme/dimensions.dart';

class CardContainer extends StatelessWidget {
  final Widget topChild;
  final Widget bottomChild;
  final bool isTrue;

  const CardContainer(
      {super.key,
      required this.topChild,
      required this.bottomChild,
      required this.isTrue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Dimensions.kBorderRadiusAllSmall,
        color: const Color(0xFFF0F0F0),
      ),
      child: Column(
        children: [
          Container(
            padding: Dimensions.kPaddingAllSmall,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: isTrue ? const Color(0xFFB40205) : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: topChild,
          ),
          Container(
            padding: Dimensions.kPaddingAllSmall,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: isTrue ? Colors.transparent : const Color(0xFFB40205),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: bottomChild,
          ),
        ],
      ),
    );
  }
}
