import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../premium/premium.dart';

class PremiumService {
  String icon;
  String label;

  PremiumService({required this.icon, required this.label});
}

class PremiumAdditionalService extends ConsumerStatefulWidget {
  const PremiumAdditionalService({super.key});

  @override
  ConsumerState<PremiumAdditionalService> createState() =>
      _PremiumAdditionalServiceConsumerState();
}

class _PremiumAdditionalServiceConsumerState
    extends ConsumerState<PremiumAdditionalService> {
  List<PremiumService> serviceList = [
    // PremiumService(icon: AppIcon.additionalManpower, label: 'Manpower'),
    PremiumService(icon: AppIcon.additionalCarrying, label: 'Stair Carry'),
    PremiumService(icon: AppIcon.additionalTailgate, label: 'Tail-Gate'),
    PremiumService(icon: AppIcon.additionalLongpush, label: 'Long Push'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Padding(
      padding: Dimensions.kPaddingAllMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Premium Booking',
            style:
                textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400),
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
            'For wrapping,assembly,stair carry and long push\nservices, you need to use premium services.',
            style: textTheme.labelMedium?.copyWith(color: Colors.black),
          ),
          Dimensions.kVerticalSpaceSmall,
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 46),
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 3 / 2.7,
                ),
                itemCount: serviceList.length,
                itemBuilder: (_, i) {
                  final service = serviceList[i];
                  return PremiumCustomIconBox(
                    icon: service.icon,
                    label: service.label,
                    onTap: () => servicesBottomSheetAction(i),
                  );
                },
              ),
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
      return const PremiumStairCarryBottomSheet();
    } else if (res == 2) {
      return const PremiumTailGateBottomSheet();
    } else if (res == 3) {
      return const PremiumLongPushBottomSheet();
    } else {
      return null;
    }
  }
}

class PremiumCustomIconBox extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const PremiumCustomIconBox(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: Dimensions.kBorderRadiusAllSmall,
      child: Container(
        // width: 125.w,
        // height: 125.h,
        padding: Dimensions.kPaddingAllSmall,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: Dimensions.kBorderRadiusAllSmall,
          border: Border.all(width: 1.5, color: const Color(0xFFB30205)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(icon),
              height: 50.h,
              width: 50.w,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF1B293D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
