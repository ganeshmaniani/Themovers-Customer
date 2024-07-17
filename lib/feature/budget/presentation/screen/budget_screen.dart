import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../budget/budget.dart';

class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() => _BudgetScreenConsumerState();
}

class _BudgetScreenConsumerState extends ConsumerState<BudgetScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentState = 1;
  double totalAmount = 0;

  void setNextState() {
    setState(() => currentState = currentState + 1);
  }

  void setBackState() {
    setState(currentState != 0 ? () => currentState = currentState - 1 : () {});
  }

  void appBarOnTap() {
    currentState == 2 || currentState == 3
        ? setBackState()
        : Navigator.pop(context);
  }

  //
  // void appBarOnTap() {
  //   currentState == 2 || currentState == 3 || currentState == 4
  //       ? setBackState()
  //       : Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBars(context),
      drawer: const CustomDrawer(),
      // appBar: AppBar(
      //   title: Text(
      //     'Budget Moving',
      //     style:
      //         context.textTheme.headlineMedium?.copyWith(color: Colors.white),
      //   ),
      //   leading: InkWell(
      //     onTap: () => {
      //       currentState == 2 || currentState == 3 || currentState == 4
      //           ? setBackState()
      //           : Navigator.pop(context),
      //     },
      //     child: const Icon(Icons.arrow_back_sharp, color: Colors.white),
      //   ),
      // ),
      body: currentState == 1
          ? const BudgetAddressStep()
          : currentState == 2
              ? const BudgetVehicleStep()
              : const BudgetBuyNowScreen(),
      // ? const BudgetAdditionalService()

      // currentState == 1
      //     ? const BudgetAddressStep()
      //     : currentState == 2
      //         ? const BudgetVehicleStep()
      //         : currentState == 3
      //             ? const BudgetAdditionalService()
      //             : const BudgetBuyNowScreen(),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: currentState == 3 ? 130.h : 66.h,
        // height: currentState == 4 ? 130.h : 66.h,
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
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
          Image(image: const AssetImage(AppIcon.theMoversLogo), width: 100.w),
          InkWell(
            // onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Container(
                width: 38.w,
                height: 38.h,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFB40205)),
                child: SvgPicture.asset(AppIcon.menus)),
          ),
        ],
      ),
    );
  }

  Widget nextButtonShowOrNot(int currentState) {
    final budgetPackage = ref.watch(budgetControllerProvider).budgetPackage;
    final longPushType = ref.watch(budgetControllerProvider).longPushType ?? [];

    int distance = ref.watch(budgetControllerProvider).distance ?? 0;

    int manPower = ref.watch(budgetControllerProvider).manPowerCount ?? 0;
    int boxCount = ref.watch(budgetControllerProvider).boxCount ?? 0;

    int shrinkWrap = ref.watch(budgetControllerProvider).shrinkWrap ?? 0;
    int bubbleWrap = ref.watch(budgetControllerProvider).bubbleWrap ?? 0;

    int diningTable = ref.watch(budgetControllerProvider).diningTable ?? 0;
    int bed = ref.watch(budgetControllerProvider).bed ?? 0;
    int officeTable = ref.watch(budgetControllerProvider).officeTable ?? 0;
    int wardrobe = ref.watch(budgetControllerProvider).wardrobe ?? 0;

    bool insurance = ref.watch(budgetControllerProvider).insurance ?? false;
    int stairCarry = ref.watch(budgetControllerProvider).stairCarry ?? 0;
    bool tailGate = ref.watch(budgetControllerProvider).tailGate ?? false;

    int longPush = ref.watch(budgetControllerProvider).longPush ?? 0;

    bool isLoading = ref.watch(budgetControllerProvider).isLoading ?? false;

    List amountList = [
      Calculator.distanceAmount(distance, budgetPackage),
      Calculator.manpowerAmount(manPower, budgetPackage),
      Calculator.boxAmount(boxCount, budgetPackage),
      Calculator.shrinkWrapAmount(shrinkWrap, budgetPackage),
      Calculator.bubbleWrapAmount(bubbleWrap, budgetPackage),
      Calculator.diningTableAmount(diningTable, budgetPackage),
      Calculator.bedAmount(bed, budgetPackage),
      Calculator.officeTableAmount(officeTable, budgetPackage),
      Calculator.wardrobeAmount(wardrobe, budgetPackage),
      Calculator.insuranceAmount(insurance, budgetPackage),
      Calculator.stairCarryAmount(stairCarry, budgetPackage),
      Calculator.tailGateAmount(tailGate, budgetPackage),
      Calculator.longPushAmount(longPush, longPushType)
    ];

    totalAmount = Calculator.totalAmount(amountList);

    debugPrint("=====================");
    debugPrint(" Total Amount: $totalAmount");
    debugPrint("=====================");

    if (currentState == 1) {
      return distance != 0 ? nextStateWidget() : disableStateWidget();
    }
    if (currentState == 2) {
      return budgetPackage != null ? nextStateWidget() : disableStateWidget();
    }
    // if (currentState == 3) {
    //   return nextStateWidget();
    // }
    //Changing 4 to 3
    if (currentState == 3) {
      return isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                currentState == 3
                    // currentState == 4
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
                          ref.read(budgetControllerProvider).setLoading(true),
                          ref
                              .read(budgetControllerProvider)
                              .submitBudgetMovingBooking(context, ref),
                          // _showCustomDialog(context)
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
                    : const SizedBox()
              ],
            );
    }

    return disableStateWidget();
  }

  PreferredSizeWidget appBars(BuildContext context) {
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

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Thank you for Choosing us.',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text(
                    "The Next immediate Personal Fleet Manager will be in-touch with you in a couple of minutes.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFA5A5A5),
                    )),
                // Add your custom content here
              ],
            ),
          ),
          actions: <Widget>[
            Center(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(AppIcon.okeyButton)))
          ],
        );
      },
    );
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
