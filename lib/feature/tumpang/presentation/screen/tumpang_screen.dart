import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../tumpang/tumpang.dart';

class TumpangScreen extends ConsumerStatefulWidget {
  const TumpangScreen({super.key});

  @override
  ConsumerState<TumpangScreen> createState() => _TumpangScreenConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _TumpangScreenConsumerState extends ConsumerState<TumpangScreen> {
  int currentState = 1;
  int totalAmount = 0;

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
    if (currentState == 2) {
      setBackState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    totalAmount = ref.watch(tumpangNotifierProvider).amount ?? 0;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context),
      drawer: const CustomDrawer(),
      body: currentState == 1
          ? const TumpangAddressScreen()
          : currentState == 2
              ? const TumpangAdditionalServiceScreen()
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
    final distance = ref.watch(tumpangNotifierProvider).distance;

    final isLoading = ref.read(tumpangNotifierProvider).isLoading ?? false;

    if (currentState == 1) {
      return distance != null ? nextStateWidget() : disableStateWidget();
    }
    if (currentState == 2) {
      return
          // isLoading
          //   ? const Center(child: CircularProgressIndicator())
          //   :
          Button(
        onTap: () {
          ref.read(tumpangNotifierProvider).setLoading(true);
          ref.read(tumpangNotifierProvider).submitTumpangBooking(context, ref);
        },
        width: 120,
        child: Row(
          children: [
            const Spacer(),
            Text(
              'INQUIRY NOW',
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

  Widget nextStateWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Dimensions.kSpacer,
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
        Dimensions.kSpacer,
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
