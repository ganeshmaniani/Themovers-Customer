import 'package:flutter/material.dart';
import 'package:themovers/core/constants/app_assets.dart';

import '../../../../config/config.dart';
import '../../../budget/budget.dart';

class Service {
  String icon;
  String label;

  Service({required this.icon, required this.label});
}

class BudgetAdditionalService extends StatefulWidget {
  const BudgetAdditionalService({super.key});

  @override
  State<BudgetAdditionalService> createState() =>
      _BudgetAdditionalServiceState();
}

class _BudgetAdditionalServiceState extends State<BudgetAdditionalService> {
  List<Service> serviceList = [
    Service(icon: AppIcon.additionalManpower, label: 'Manpower'),
    Service(icon: AppIcon.additionalBoxes, label: 'Boxes'),
    Service(icon: AppIcon.additionalWrapping, label: 'Wrapping'),
    Service(icon: AppIcon.additionalHammer, label: 'Assembly / Disassembly'),
    // Service(icon: AppIcon.additionalInsurance, label: 'Insurance'),
    Service(icon: AppIcon.additionalCarrying, label: 'Stair Carry'),
    Service(icon: AppIcon.additionalTailgate, label: 'Tail-Gate'),
    Service(icon: AppIcon.additionalLongpush, label: 'Long Push'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: Dimensions.kPaddingAllMedium,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budget Booking',
                  style: textTheme.headlineMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                Dimensions.kVerticalSpaceSmall,
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB40205),
                  ),
                  child: Text(
                    'What do you like to add on additional services?',
                    style: textTheme.titleSmall!.copyWith(color: Colors.white),
                  ),
                ),
                Dimensions.kVerticalSpaceSmaller,
                Text(
                  'For wrapping, assembly, stair carry and long push\nservices, you need to use manpower services.',
                  style: textTheme.labelMedium?.copyWith(color: Colors.black),
                ),
                Dimensions.kVerticalSpaceSmall,
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 46),
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      // physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 3 / 2.7),
                      itemCount: serviceList.length,
                      itemBuilder: (_, i) {
                        final service = serviceList[i];
                        return CustomIconBox(
                          icon: service.icon,
                          label: service.label,
                          onTap: () => servicesBottomSheetAction(i),
                        );
                      },
                    ),
                  ),
                ),
                Dimensions.kVerticalSpaceLargest
              ],
            ),
          ),
        ],
      ),
    );
  }

  void servicesBottomSheetAction(int i) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      builder: (_) {
        return selectedWidget(i)!;
      },
    );
  }

  Widget? selectedWidget(int i) {
    final res = i + 1;
    if (res == 1) {
      return const ManpowerBottomSheet();
    } else if (res == 2) {
      return const BoxBottomSheet();
    } else if (res == 3) {
      return const WrappingBottomSheet();
    } else if (res == 4) {
      return const AssemblyDisassemblyBottomSheet();
    } else if (res == 5) {
      return const StairCarryBottomSheet();
    } else if (res == 6) {
      return const TailGateBottomSheet();
    } else if (res == 7) {
      return const LongPushBottomSheet();
    } else {
      return null;
    }
  }
}
