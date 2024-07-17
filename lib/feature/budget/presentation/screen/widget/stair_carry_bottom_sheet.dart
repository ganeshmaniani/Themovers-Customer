import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../../config/config.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../budget/budget.dart';

class StairCarryBottomSheet extends ConsumerStatefulWidget {
  const StairCarryBottomSheet({super.key});

  @override
  ConsumerState<StairCarryBottomSheet> createState() =>
      _StairCarryBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _StairCarryBottomSheetConsumerState
    extends ConsumerState<StairCarryBottomSheet> {
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    int stairCarry = ref.watch(budgetControllerProvider).stairCarry ?? 0;

    final amount = ref.watch(budgetControllerProvider).budgetPackage?.stairCase;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kVerticalSpaceLarge,
            appBar(),
            Padding(
              padding: Dimensions.kPaddingAllMedium,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Budget Booking',
                    style: textTheme.headlineMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Dimensions.kVerticalSpaceSmall,
                  Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB40205),
                    ),
                    child: Text(
                      'Stair Carry',
                      style:
                          textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Text(
                      'Do any of your unit gave access to elevator? Would you require manpower to move small to bulky items up or down a flight of stair?',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000),
                      )),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 74),
              child: Container(
                padding: Dimensions.kPaddingAllMedium,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFB30205)),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (isAgree == false) {
                            isAgree = true;
                          } else if (isAgree == true) {
                            isAgree = false;
                            stairCarry = 0;
                          }
                        });
                        ref
                            .read(budgetControllerProvider)
                            .setStairCarry(stairCarry);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                              width: 30,
                              height: 30,
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
                                    width: Dimensions.iconSizeMedium,
                                    color: context.colorScheme.primary,
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Manpower will carefully move small to bulky items using stairs when elevator is not accessible.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF000000), fontSize: 12.sp),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    Text(
                      'MYR $amount',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge
                          ?.copyWith(color: const Color(0xFF444550)),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      'Stair Level',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(
                          color: const Color(0xFF444550),
                          fontWeight: FontWeight.w400),
                    ),
                    Dimensions.kVerticalSpaceSmall,
                    CustomProductCounterCard(
                      isEnable: isAgree,
                      limited: true,
                      count: isAgree ? stairCarry : stairCarry = 0,
                      increment: () => setState(
                        stairCarry < 5
                            ? () => {
                                  stairCarry = stairCarry + 1,
                                  ref
                                      .read(budgetControllerProvider)
                                      .setStairCarry(stairCarry)
                                }
                            : () {},
                      ),
                      decrement: () => setState(
                        stairCarry != 0
                            ? () => {
                                  stairCarry = stairCarry - 1,
                                  ref
                                      .read(budgetControllerProvider)
                                      .setStairCarry(stairCarry)
                                }
                            : () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: Dimensions.kPaddingAllMedium,
            //   child: GestureDetector(
            //     onTap: isAgree != true
            //         ? () => {addStairCarry(isAgree = !isAgree)}
            //         : () => {addStairCarry(isAgree = !isAgree)},
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(6),
            //               child: Container(
            //                 width: 24,
            //                 height: 24,
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: Dimensions.kBorderRadiusAllSmallest,
            //                   border: Border.all(
            //                     width: 2,
            //                     color: isAgree
            //                         ? context.colorScheme.primary
            //                         : const Color(0xFF969696),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Positioned(
            //               top: 2,
            //               right: 2,
            //               child: isAgree
            //                   ? Image(
            //                       image: const AssetImage(AppIcon.checkMark),
            //                       width: Dimensions.iconSizeSmall,
            //                       color: context.colorScheme.primary,
            //                     )
            //                   : const SizedBox(),
            //             ),
            //           ],
            //         ),
            //         Dimensions.kHorizontalSpaceSmall,
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'Stair Level (MYR $amount)',
            //                 style: textTheme.headlineSmall
            //                     ?.copyWith(color: const Color(0xFF444550)),
            //               ),
            //               Text(
            //                 'Manpower will carefully move small to bulky items using stairs when elevator is not accessible.',
            //                 style: textTheme.bodySmall
            //                     ?.copyWith(color: Colors.black54),
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            const Spacer(),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                alignment: Alignment.center,
                height: 50.sp,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
}
