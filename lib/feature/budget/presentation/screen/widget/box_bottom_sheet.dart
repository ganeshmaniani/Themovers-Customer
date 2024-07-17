import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../../config/config.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../budget/budget.dart';

class BoxBottomSheet extends ConsumerStatefulWidget {
  const BoxBottomSheet({super.key});

  @override
  ConsumerState<BoxBottomSheet> createState() => _BoxBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _BoxBottomSheetConsumerState extends ConsumerState<BoxBottomSheet> {
  void sendResponse(String service, dynamic val) async {
    switch (service) {
      case 'count':
        ref.read(budgetControllerProvider).setBoxCount(val);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int boxCount = ref.watch(budgetControllerProvider).boxCount ?? 0;

    final amount = ref.watch(budgetControllerProvider).budgetPackage;
    final textTheme = context.textTheme;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Dimensions.kVerticalSpaceLarge,
            appBar(),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: Dimensions.kPaddingAllMedium,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Budget Booking',
                    style: textTheme.headlineMedium!
                        .copyWith(fontWeight: FontWeight.w400, height: 0),
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
                      'Boxes (Any Size)',
                      style: textTheme.titleSmall!
                          .copyWith(color: Colors.white, height: 0),
                    ),
                  ),
                  // Dimensions.kVerticalSpaceLarge,
                  // const CustomBottomSheetAppBar(),
                  // Dimensions.kVerticalSpaceMedium,

                  Dimensions.kVerticalSpaceSmaller,
                  Text(
                      'Protect your items from scratches, damage or dirt during transsit',
                      style: TextStyle(
                        height: 0,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000),
                      )),

                  Dimensions.kVerticalSpaceLarge,
                  CustomProductCounterCard(
                    isEnable: true,
                    limited: false,
                    count: boxCount,
                    increment: () => setState(
                      () => {
                        boxCount = boxCount + 1,
                        sendResponse('count', boxCount),
                      },
                    ),
                    decrement: () => setState(
                      boxCount != 0
                          ? () => {
                                boxCount = boxCount - 1,
                                sendResponse('count', boxCount),
                              }
                          : () {},
                    ),
                  ),
                  const Spacer(),
                  const Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'MYR 15.00\n',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'per box',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Center(
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         "MYR ${amount!.box.toString()}",
                  //         style: context.textTheme.titleLarge?.copyWith(
                  //             color: const Color(0xFF000000), fontSize: 30.sp),
                  //       ),
                  //       Text(
                  //         "per box",
                  //         style: context.textTheme.titleLarge?.copyWith(
                  //           color: const Color(0xFF000000),
                  //           fontSize: 30.sp,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Dimensions.kVerticalSpaceLarge,
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
                  Dimensions.kVerticalSpaceLargest,
                ],
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

  customTextCard({required String title, required String discription}) {
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
