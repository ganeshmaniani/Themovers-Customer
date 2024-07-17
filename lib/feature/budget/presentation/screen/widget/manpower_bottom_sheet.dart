import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../../config/config.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../budget/budget.dart';

class ManpowerBottomSheet extends ConsumerStatefulWidget {
  const ManpowerBottomSheet({super.key});

  @override
  ConsumerState<ManpowerBottomSheet> createState() =>
      _ManpowerBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ManpowerBottomSheetConsumerState
    extends ConsumerState<ManpowerBottomSheet> {
  void sendResponse(String service, dynamic val) async {
    switch (service) {
      case 'count':
        ref.read(budgetControllerProvider).setManPowerCount(val);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int manPowerCount = ref.watch(budgetControllerProvider).manPowerCount ?? 0;
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
                      'Manpower',
                      style: textTheme.titleSmall!.copyWith(
                          color: Colors.white, fontSize: 15.sp, height: 0),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Text(
                      'Experience the most Affordable and seamless Moving service.Choose ',
                      style: TextStyle(
                        height: 0,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000),
                      )),
                  Dimensions.kVerticalSpaceMedium,
                  customTextCard(
                    title: '1 ManPower',
                    discription:
                        'The driver is a manpower. Suitable for moving light items such as boxes, chairs, bags, etc.',
                  ),
                  const SizedBox(height: 6),
                  customTextCard(
                    title: '2 ManPower',
                    discription:
                        'Driver and 1 helper. Suitable for moving light items such as boxes, tables, chairs, bags, etc.',
                  ),
                  const SizedBox(height: 6),
                  customTextCard(
                    title: '3 ManPower',
                    discription:
                        'Driver and 2 helpers. Suitable for moving medium items such as refrigerator, tables, small room items, etc.',
                  ),
                  const SizedBox(height: 6),
                  customTextCard(
                    title: '4 ManPower',
                    discription:
                        'Driver and 3 helpers. Suitable for moving heavy items such as refrigerator, wardrobe, piano, house items, etc.',
                  ),
                  const SizedBox(height: 6),
                  customTextCard(
                    title: '5 ManPower',
                    discription:
                        'Driver and 4 helpers. Suitable for moving heavy items such as refrigerator, wardrobe, piano, house items, etc.',
                  ),
                  const SizedBox(height: 40),
                  CustomProductCounterCard(
                    isEnable: true,
                    limited: true,
                    count: manPowerCount,
                    increment: () => setState(
                      manPowerCount < 5
                          ? () => {
                                manPowerCount = manPowerCount + 1,
                                sendResponse('count', manPowerCount),
                              }
                          : () {},
                    ),
                    decrement: () => setState(
                      manPowerCount != 0
                          ? () => {
                                manPowerCount = manPowerCount - 1,
                                sendResponse('count', manPowerCount),
                              }
                          : () {},
                    ),
                  ),
                  const Spacer(),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(
                color: const Color(0xFF000000),
                fontSize: 12.sp,
                height: 0,
                fontWeight: FontWeight.w700),
          ),
          Dimensions.kVerticalSpaceSmallest,
          Opacity(
            opacity: 0.50,
            child: Text(
              discription,
              style: textTheme.labelLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 10.sp,
                  height: 0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
