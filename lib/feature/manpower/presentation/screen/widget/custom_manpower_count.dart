import 'package:flutter/material.dart';

import '../../../../../config/config.dart';

class CustomManpowerCounterCard extends StatelessWidget {
  final String count;
  final VoidCallback increment;
  final VoidCallback decrement;
  final bool limited;

  const CustomManpowerCounterCard(
      {super.key,
      required this.count,
      required this.increment,
      required this.decrement,
      required this.limited});

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
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: count == '2' || count == '2 Hrs'
                  ? context.colorScheme.onBackground.withOpacity(.6)
                  : context.colorScheme.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              Icons.horizontal_rule_rounded,
              color: Colors.white,
              size: Dimensions.iconSizeSmall,
            ),
          ),
        ),
        Dimensions.kHorizontalSpaceSmaller,
        Container(
          width: count == '2' || count == '3' || count == '4' || count == '5'
              ? 60
              : 70,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: Dimensions.kBorderRadiusAllSmaller,
          ),
          child: Text(
            count,
            style: textTheme.headlineMedium,
          ),
        ),
        Dimensions.kHorizontalSpaceSmaller,
        InkWell(
          onTap: increment,
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: limited
                  ? count == '5' || count == '5 Hrs'
                      ? context.colorScheme.onBackground.withOpacity(.6)
                      : context.colorScheme.primary
                  : context.colorScheme.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: Dimensions.iconSizeSmall,
            ),
          ),
        ),
      ],
    );
  }
}
