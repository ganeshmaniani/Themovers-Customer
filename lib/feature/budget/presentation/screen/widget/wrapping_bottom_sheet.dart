import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../budget/budget.dart';

class WrappingBottomSheet extends ConsumerStatefulWidget {
  const WrappingBottomSheet({super.key});

  @override
  ConsumerState<WrappingBottomSheet> createState() =>
      _WrappingBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _WrappingBottomSheetConsumerState
    extends ConsumerState<WrappingBottomSheet> {
  void sendResponse(String service, int val) async {
    switch (service) {
      case 'shrink':
        ref.read(budgetControllerProvider).setShrinkWrap(val);
        break;
      case 'bubble':
        ref.read(budgetControllerProvider).setBubbleWrap(val);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    int shrinkWrapCount = ref.watch(budgetControllerProvider).shrinkWrap ?? 0;
    int bubbleWrapCount = ref.watch(budgetControllerProvider).bubbleWrap ?? 0;

    final amount = ref.watch(budgetControllerProvider).budgetPackage;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Dimensions.kVerticalSpaceLarge,
              appBar(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget Booking',
                      style: textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.w400, height: 0),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB40205),
                      ),
                      child: Text(
                        'Wrapping',
                        style: textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                          height: 0,
                        ),
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    Text(
                        'Protect your items from scratches, damage or dirt during transsit',
                        style: TextStyle(
                          fontSize: 12.sp,
                          height: 0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(AppIcon.shrinkWrap),
                      height: 100,
                      width: 100,
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      'MYR ${amount?.shrinkWrapping} per roll',
                      style: textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF000000),
                          height: 0,
                          fontSize: 15.sp),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      '50cm (W) x 1000cm (L)',
                      style: textTheme.labelMedium?.copyWith(
                          color: const Color(0xFF000000),
                          height: 0,
                          fontSize: 10.sp),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                        "A clear plastic material used to protect furniture\nand mattress from scratch or dust",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 0,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        )),
                    Dimensions.kVerticalSpaceSmallest,
                    CustomProductCounterCard(
                      isEnable: true,
                      limited: false,
                      count: shrinkWrapCount,
                      increment: () => setState(
                        () => {
                          shrinkWrapCount = shrinkWrapCount + 1,
                          sendResponse('shrink', shrinkWrapCount),
                        },
                      ),
                      decrement: () => setState(
                        () => shrinkWrapCount != 0
                            ? {
                                shrinkWrapCount = shrinkWrapCount - 1,
                                sendResponse('shrink', shrinkWrapCount),
                              }
                            : () {},
                      ),
                    ),
                    Dimensions.kVerticalSpaceMedium,
                    const Image(
                      image: AssetImage(AppIcon.bubbleWrap),
                      height: 100,
                      width: 100,
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      'MYR ${amount?.bubbleWrapping} per roll',
                      style: textTheme.titleLarge?.copyWith(
                          color: Colors.black, height: 0, fontSize: 15.sp),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      '100cm (W) x 1000cm (L)',
                      style: textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF000000),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                        "A transparent bubble plastic material used for\npackaging fragile item",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        )),
                    Dimensions.kVerticalSpaceSmallest,
                    CustomProductCounterCard(
                      isEnable: true,
                      limited: false,
                      count: bubbleWrapCount,
                      increment: () => setState(() => {
                            bubbleWrapCount = bubbleWrapCount + 1,
                            sendResponse('bubble', bubbleWrapCount),
                          }),
                      decrement: () => setState(
                        () => bubbleWrapCount != 0
                            ? {
                                bubbleWrapCount = bubbleWrapCount - 1,
                                sendResponse('bubble', bubbleWrapCount),
                              }
                            : () {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.sp,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xFFB40205),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Done',
                          style: context.textTheme.bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: AppBar(
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
              Image(
                  image: const AssetImage(AppIcon.theMoversLogo), width: 100.w),
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
            ],
          ),
        ));
  }

  optionDetailCard({required String title, required String discription}) {
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
/*
MYR 50 per roll. 
A clear plastic material used to protect furniture or mattress from scratch or dust.

MYR 150 per roll. 
A transparent bubble plastic material used for packing fragile items. 
*/
