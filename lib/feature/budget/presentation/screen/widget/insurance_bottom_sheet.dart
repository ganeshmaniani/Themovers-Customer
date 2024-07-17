import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../budget/budget.dart';

class InsuranceBottomSheet extends ConsumerStatefulWidget {
  const InsuranceBottomSheet({super.key});

  @override
  ConsumerState<InsuranceBottomSheet> createState() =>
      _InsuranceBottomSheetConsumerState();
}

class _InsuranceBottomSheetConsumerState
    extends ConsumerState<InsuranceBottomSheet> {
  void addInsurance(bool isTrue) async {
    ref.read(budgetControllerProvider).setInsurance(isTrue);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    bool isAgree = ref.watch(budgetControllerProvider).insurance ?? false;
    final amount = ref.watch(budgetControllerProvider).budgetPackage?.insurance;

    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Dimensions.kPaddingAllMedium,
            child: Column(
              children: [
                Dimensions.kVerticalSpaceLarge,
                const CustomBottomSheetAppBar(),
                Dimensions.kVerticalSpaceMedium,
                titleAndLabelCard(
                  title: 'Worry-free protection!',
                  discription:
                      'Protect your items from damages, theft or loss during a transit.',
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: Dimensions.kPaddingAllMedium,
            child: Column(
              children: [
                GestureDetector(
                  onTap: isAgree != true
                      ? () => {addInsurance(isAgree = !isAgree)}
                      : () => {addInsurance(isAgree = !isAgree)},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    Dimensions.kBorderRadiusAllSmallest,
                                border: Border.all(
                                  width: 2,
                                  color: isAgree
                                      ? context.colorScheme.primary
                                      : const Color(0xFF969696),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: isAgree
                                ? Image(
                                    image: const AssetImage(AppIcon.checkMark),
                                    width: Dimensions.iconSizeSmall,
                                    color: context.colorScheme.primary,
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                      Dimensions.kHorizontalSpaceSmall,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Insurance',
                            style: textTheme.headlineSmall
                                ?.copyWith(color: const Color(0xFF444550)),
                          ),
                          Text(
                            'MYR 10,000 for only',
                            style: textTheme.bodySmall
                                ?.copyWith(color: Colors.black54),
                          ),
                          Text(
                            'MYR $amount',
                            style: textTheme.bodySmall
                                ?.copyWith(color: Colors.black54),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // const Divider(height: 0),
                Dimensions.kVerticalSpaceSmall,
                Text(
                  '1. Cover against risk of fire, overturning, collision during the transit as per Overland Transportation (All Risks) Clause of Marine Open Cover No (B2CC0000066).',
                  style: textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),
                Dimensions.kVerticalSpaceSmall,
                Text(
                  '2. Items not declared and valued will not be covered.',
                  style: textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),
                Dimensions.kVerticalSpaceSmall,
                Text(
                  '3. We will send a declaration form to your email after the booking has been confirmed.',
                  style: textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),
                Dimensions.kVerticalSpaceSmall,
                Text(
                  '4. Insurance policies standard excess is RM1,500 on each and every loss.',
                  style: textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  titleAndLabelCard({required String title, required String discription}) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              textTheme.headlineSmall?.copyWith(color: const Color(0xFF444550)),
        ),
        Dimensions.kVerticalSpaceSmallest,
        Text(
          discription,
          style: textTheme.bodySmall?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}

/*
1. Cover against risk of fire, overturning, collision during the transit as 
per Overland Transportation (All Risks) Clause of Marine Open Cover No (B2CC0000066) 

2. Items not declared and valued will not be covered.

3. We will send a declaration form to your email after the booking has been confirmed. 

4. Insurance policies standard excess is RM1,500 on each and every loss.
*/
