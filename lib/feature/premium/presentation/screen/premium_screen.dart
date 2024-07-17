import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../premium/premium.dart';

class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({super.key});

  @override
  ConsumerState<PremiumScreen> createState() => _PremiumScreenConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _PremiumScreenConsumerState extends ConsumerState<PremiumScreen> {
  int currentState = 1;
  double totalAmount = 0;

  void setNextState() {
    setState(() => currentState = currentState + 1);
  }

  void setBackState() {
    setState(currentState != 0 ? () => currentState = currentState - 1 : () {});
  }

  void appBarOnTap() {
    if (currentState == 1) {
      Navigator.pop(context);
    }
    if (currentState == 2 || currentState == 3 || currentState == 4) {
      setBackState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context),
      drawer: const CustomDrawer(),
      body: currentState == 1
          ? const PremiumAddressScreen()
          : currentState == 2
              ? const PremiumVehicleTypeScreen()
              // : currentState == 3
              //     ? const PremiumAdditionalService()
              : currentState == 3
                  ? const PremiumBookingScreen()
                  : Container(),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: currentState == 3 ? 130.h : 66.h,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16).w,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.01),
              offset: const Offset(6, 0),
              blurRadius: 16,
              spreadRadius: 3,
            ),
          ],
        ),
        child: nextButtonShowOrNot(currentState),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Dimensions.kHorizontalSpaceMedium,
              InkWell(
                onTap: () {
                  appBarOnTap();
                },
                child: Container(
                    width: 38.w,
                    height: 38.h,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFB40205)),
                    child: SvgPicture.asset(AppIcon.backArrowIcon)),
              ),
              const Spacer(),
              Image(
                  image: const AssetImage(AppIcon.theMoversLogo), width: 100.w),
              const Spacer(),
              InkWell(
                onTap: () => _scaffoldKey.currentState!.openDrawer(),
                child: Container(
                    width: 38.w,
                    height: 38.h,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFB40205)),
                    child: SvgPicture.asset(AppIcon.menus)),
              ),
              Dimensions.kHorizontalSpaceMedium,
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Divider(
              height: 0,
              color: const Color(0xFFC1C1C1).withOpacity(0.2),
              endIndent: 16,
              indent: 16)
        ],
      ),
    );
  }

  Widget nextButtonShowOrNot(int currentState) {
    final budgetPackage = ref.watch(premiumNotifierProvider).premiumPackage;
    final longPushType = ref.watch(premiumNotifierProvider).longPushType ?? [];

    int distance = ref.watch(premiumNotifierProvider).distance ?? 0;

    // int manPower = ref.watch(premiumNotifierProvider).manPowerCount ?? 0;

    int stairCarry = ref.watch(premiumNotifierProvider).stairCarry ?? 0;
    bool tailGate = ref.watch(premiumNotifierProvider).tailGate ?? false;

    int longPush = ref.watch(premiumNotifierProvider).longPush ?? 0;

    bool isLoading = ref.watch(premiumNotifierProvider).isLoading ?? false;

    List amountList = [
      Calculator.premiumDistanceAmount(distance, budgetPackage),
      // Calculator.premiumManpowerAmount(manPower, budgetPackage),
      Calculator.premiumStairCarryAmount(stairCarry, budgetPackage),
      Calculator.premiumTailGateAmount(tailGate, budgetPackage),
      Calculator.premiumLongPushAmount(longPush, longPushType)
    ];

    totalAmount = Calculator.totalAmount(amountList);

    if (currentState == 1) {
      return distance != 0 ? nextStateWidget() : disableStateWidget();
    }
    if (currentState == 2) {
      return budgetPackage != null ? nextStateWidget() : disableStateWidget();
    }
    // if (currentState == 3) {
    //   return nextStateWidget();
    // }
    if (currentState == 3) {
      return isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                currentState == 3
                    ? Button(
                        color: const Color(0xFF1B293D),
                        onTap: () {
                          appBarOnTap();
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            height: 0.18,
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 6),
                currentState == 3
                    ? Button(
                        onTap: () => {
                          ref.read(premiumNotifierProvider).setLoading(true),
                          ref
                              .read(premiumNotifierProvider)
                              .submitPremiumMovingBooking(context, ref)
                        },
                        child: Row(
                          children: [
                            const Spacer(),
                            Text(
                              'Confirm your Booking',
                              style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.white, letterSpacing: .2),
                            ),
                            const Spacer(),
                            SvgPicture.asset(AppIcon.arrowIcon),
                            Dimensions.kHorizontalSpaceLarge,
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            );
    }
    return disableStateWidget();
  }

  Widget nextStateWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentState == 1
            ? const SizedBox()
            : totalAmount == 0
                ? const SizedBox()
                : Container(
                    padding: Dimensions.kPaddingAllSmall,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF1B293D)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total\nAmount',
                          style: context.textTheme.labelSmall!.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          totalAmount.toString(),
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        Text(
                          'MYR',
                          style: context.textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
        Button(
          onTap: setNextState,
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Next',
                style:
                    context.textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
              SvgPicture.asset(AppIcon.arrowIcon),
            ],
          ),
        ),
      ],
    );
  }

  Widget disableStateWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentState == 1
            ? const SizedBox()
            : totalAmount == 0
                ? const SizedBox()
                : Container(
                    padding: Dimensions.kPaddingAllSmall,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF1B293D)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total\nAmount',
                          style: context.textTheme.labelSmall!.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          totalAmount.toStringAsFixed(2),
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        Text(
                          'MYR',
                          style: context.textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
        Button(
          onTap: () {},
          width: 120,
          color: context.colorScheme.secondary.withOpacity(.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Next',
                style:
                    context.textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
              SvgPicture.asset(AppIcon.arrowIcon),
            ],
          ),
        )
      ],
    );
  }
}
