import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themovers/config/config.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../../core/constants/app_assets.dart';

class CustomHotlineNumber extends StatelessWidget {
  CustomHotlineNumber({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBars(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: Dimensions.kPaddingAllMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hotline Numbers',
              style: textTheme.headlineMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            Dimensions.kVerticalSpaceMedium,
            Dimensions.kVerticalSpaceSmall,
            contactCartText(context, phoneNo: '0123244261'),
            contactCartText(context, phoneNo: '0122661021'),
            contactCartText(context, phoneNo: '0123445193'),
            contactCartText(context, phoneNo: '0177447212'),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBars(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Dimensions.kHorizontalSpaceMedium,
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

  Widget contactCartText(BuildContext context, {required String phoneNo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: const Color(0xFFB30205),
                borderRadius: BorderRadius.circular(5)),
            child: const Icon(Icons.phone, size: 15, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Text(phoneNo,
              style: context.textTheme.bodySmall!.copyWith(fontSize: 15.sp)),
        ],
      ),
    );
  }
}
