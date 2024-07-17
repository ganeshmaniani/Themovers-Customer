import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../premium/premium.dart';

class PremiumManpowerBottomSheet extends ConsumerStatefulWidget {
  const PremiumManpowerBottomSheet({super.key});

  @override
  ConsumerState<PremiumManpowerBottomSheet> createState() =>
      _ManpowerBottomSheetConsumerState();
}

class _ManpowerBottomSheetConsumerState
    extends ConsumerState<PremiumManpowerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    int manPowerCount = ref.watch(premiumNotifierProvider).manPowerCount ?? 0;

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: Dimensions.kPaddingAllMedium,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Dimensions.kVerticalSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: Dimensions.kBorderRadiusAllSmallest,
                  ),
                  child: Text(
                    'Done',
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Dimensions.kVerticalSpaceMedium,
          customTextCard(
            title: 'ManPower',
            discription:
                'Get extra hands to help your move. How many manpower do you need for your moving ?',
          ),
          const Divider(),
          Dimensions.kVerticalSpaceSmall,
          PremiumProductCounterCard(
            limited: true,
            count: manPowerCount,
            increment: () => setState(
              manPowerCount < 5
                  ? () => {
                        manPowerCount = manPowerCount + 1,
                        ref
                            .read(premiumNotifierProvider)
                            .setManPowerCount(manPowerCount)
                      }
                  : () {},
            ),
            decrement: () => setState(
              manPowerCount != 0
                  ? () => {
                        manPowerCount = manPowerCount - 1,
                        ref
                            .read(premiumNotifierProvider)
                            .setManPowerCount(manPowerCount)
                      }
                  : () {},
            ),
            isEnable: true,
          ),
          Dimensions.kVerticalSpaceMedium,
          customTextCard(
            title: '1 - ManPower',
            discription:
                'The driver is a manpower. Suitable for moving light items such as boxes, chairs, bags, etc.',
          ),
          Dimensions.kVerticalSpaceSmall,
          customTextCard(
            title: '2 - ManPower',
            discription:
                'Driver and 1 helper. Suitable for moving light items such as boxes, tables, chairs, bags, etc.',
          ),
          Dimensions.kVerticalSpaceSmall,
          customTextCard(
            title: '3 - ManPower',
            discription:
                'Driver and 2 helpers. Suitable for moving medium items such as refrigerator, tables, small room items, etc.',
          ),
          Dimensions.kVerticalSpaceSmall,
          customTextCard(
            title: '4 - ManPower',
            discription:
                'Driver and 3 helpers. Suitable for moving heavy items such as refrigerator, wardrobe, piano, house items, etc.',
          ),
          Dimensions.kVerticalSpaceSmall,
          customTextCard(
            title: '5 - ManPower',
            discription:
                'Driver and 4 helpers. Suitable for moving heavy items such as refrigerator, wardrobe, piano, house items, etc.',
          ),
        ],
      ),
    );
  }

  customTextCard({required String title, required String discription}) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(color: const Color(0xFF444550)),
        ),
        Dimensions.kVerticalSpaceSmallest,
        Text(
          discription,
          style: textTheme.labelLarge?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}

class PremiumProductCounterCard extends StatelessWidget {
  final int count;
  final VoidCallback increment;
  final VoidCallback decrement;
  final bool limited;
  final bool isEnable;

  const PremiumProductCounterCard(
      {super.key,
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
                      ? const Color(0xFFECECEC)
                      : isEnable
                          ? context.colorScheme.primary
                          : const Color(0xFFECECEC)
                  : context.colorScheme.primary,
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
