import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../manpower/manpower.dart';

class ManpowerScreen extends ConsumerStatefulWidget {
  const ManpowerScreen({super.key});

  @override
  ConsumerState<ManpowerScreen> createState() => _ManpowerScreenConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ManpowerScreenConsumerState extends ConsumerState<ManpowerScreen> {
  int currentState = 1;
  double totalAmount = 0;

  // double initialManpowerAmount = 50;

  @override
  void initState() {
    super.initState();
  }

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
    if (currentState == 2 || currentState == 3) {
      setBackState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: Text(
      //     'Manpower Moving',
      //     style: textTheme.headlineMedium?.copyWith(
      //       color: Colors.white,
      //     ),
      //   ),
      //   leading: InkWell(
      //     onTap: appBarOnTap,
      //     child: const Icon(
      //       Icons.arrow_back_sharp,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      appBar: appBar(context),
      drawer: const CustomDrawer(),
      body: currentState == 1
          ? const ManpowerAddServiceScreen()
          : currentState == 2
              ? const ManpowerAddressScreen()
              : currentState == 3
                  ? const ManpowerBookingScreen()
                  : Container(),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 66.h,
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

  Widget nextButtonShowOrNot(int currentState) {
    final location = ref.watch(manpowerNotifierProvider).location;

    final manpowerPackage = ref.watch(manpowerNotifierProvider).manpowerPackage;
    final serviceHour = ref.watch(manpowerNotifierProvider).serviceHour;
    final manpowerPackageModel =
        ref.watch(manpowerNotifierProvider).manpowerPackageModel;

    final defaultAmount = manpowerPackageModel?.defaultManpowerAmount ?? 0;
    bool isLoading = ref.read(manpowerNotifierProvider).isLoading ?? false;

    bool isSelect = ref.watch(manpowerNotifierProvider).isSelectDay ?? false;

    double amount = isSelect
        ? Calculator.serviceFullDayAmount(manpowerPackage)
        : Calculator.serviceHourAmount(serviceHour, manpowerPackage);

    totalAmount = amount + defaultAmount;

    if (currentState == 1) {
      return manpowerPackage != null ? nextStateWidget() : disableStateWidget();
    }
    if (currentState == 2) {
      return location != null ? nextStateWidget() : disableStateWidget();
    }
    if (currentState == 3) {
      return isLoading
          ? const Center(child: CircularProgressIndicator())
          : Button(
              onTap: () => {
                ref.read(manpowerNotifierProvider).setLoading(true),
                ref
                    .read(manpowerNotifierProvider)
                    .submitDisposalMovingBooking(context, ref)
              },
              width: 120,
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    'Confirm your Booking ',
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: Colors.white, letterSpacing: .2),
                  ),
                  const Spacer(),
                  SvgPicture.asset(AppIcon.arrowIcon),
                  Dimensions.kHorizontalSpaceLarge,
                ],
              ),
            );
    }
    return disableStateWidget();
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

  Widget nextStateWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        totalAmount == 0
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
