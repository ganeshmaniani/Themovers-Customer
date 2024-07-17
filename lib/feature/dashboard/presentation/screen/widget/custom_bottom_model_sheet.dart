import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../../feature/feature.dart';

class CustomBottomModelSheet extends StatelessWidget {
  final String selectedServices;

  const CustomBottomModelSheet({super.key, required this.selectedServices});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return SizedBox(
      height: 500.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 45.h,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 460.h,
              alignment: Alignment.center,
              padding: Dimensions.kPaddingAllMedium,
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimensions.kVerticalSpaceLarge,
                  RichText(
                    text: TextSpan(
                      text: "Service: ",
                      style: textTheme.bodySmall
                          ?.copyWith(color: context.colorScheme.secondary),
                      children: [
                        TextSpan(
                          text: selectedServices,
                          style: textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  Text(
                    selectedServices == "Budget Moving"
                        ? 'Experience the most Affordable and seamless Moving service.Choose your type of Vehicle and Extra services according to your needs.'
                        // : selectedServices == "Premium Moving"
                        //     ? "Just Sit back & Relax.we've got you covered:"
                        : selectedServices == 'Disposal Service'
                            ? 'No Fret - Chill! We will handle all the unwanted things for you.Let’s Go Green - We will make sure your wastes are disposed properly.'
                            : selectedServices == 'Manpower Service'
                                ? 'Leave the Heavy Lifting to Us - Enjoy Hassle-Free on time Movement.'
                                : selectedServices == 'Tumpang Service'
                                    ? 'Delivery services including cargo,logistics,lorry transport & Movers delivery services In sharing Basis.'
                                    : '',
                    style: textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                  Text(
                      selectedServices == 'Premium Moving'
                          ? "Just Sit back & Relax.we've got you covered:"
                          : '',
                      style:
                          textTheme.bodySmall?.copyWith(color: Colors.black54)),
                  commonTickBox('Limited to 1 Trip', context),
                  commonTickBox('Unlimited wrapping(Shrink & Bubble)', context),
                  commonTickBox(
                      'Free Furniture Dismantling&Reassembling', context),
                  commonTickBox('Free Boxes according 10-20', context),
                  commonTickBox('4 Manpower including driver', context),
                  Dimensions.kSpacer,
                  Button(
                    onTap: () =>
                        navigatingBookingScreen(context, selectedServices),
                    height: 56.h,
                    child: Text(
                      'Book Now',
                      style: textTheme.bodyMedium?.copyWith(
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
              width: 70.w,
              height: 70.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: Dimensions.kBorderRadiusAllSmall,
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
                Icons.info_rounded,
                size: Dimensions.iconSizeMedium,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigatingBookingScreen(context, service) async {
    if (service == "Budget Moving") {
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const BudgetScreen()));
    } else if (service == "Premium Moving") {
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const PremiumScreen()));
    } else if (service == "Disposal Service") {
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const DisposalScreen()));
    } else if (service == "Manpower Service") {
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const ManpowerScreen()));
    } else if (service == "Tumpang Service") {
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const TumpangScreen()));
    }
  }

  commonTickBox(String text, BuildContext context) {
    final textTheme = context.textTheme;
    return selectedServices == 'Premium Moving'
        ? Expanded(
            child: Row(children: [
              const Image(
                image: AssetImage(AppIcon.checkMark),
                width: 16,
                color: Color(0xFF23978E),
              ),
              const SizedBox(width: 4),
              Text(text,
                  style: textTheme.bodySmall?.copyWith(color: Colors.black54))
            ]),
          )
        : const Text('');
  }
}
