import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themovers/feature/dashboard/presentation/screen/widget/custom_help_support.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({super.key});

  @override
  ConsumerState<CustomDrawer> createState() => _CustomDrawerConsumerState();
}

class _CustomDrawerConsumerState extends ConsumerState<CustomDrawer> {
  bool isLoading = false;
  bool isExpand = false;
  CustomerProfileDetail customerProfileDetail = CustomerProfileDetail();

  @override
  void initState() {
    initialCustomerProfileDetail();

    super.initState();
  }

  initialCustomerProfileDetail() {
    setState(() => isLoading = true);

    ref
        .read(customerProfileDetailProvider.notifier)
        .getCustomerProfileDetail()
        .then((res) => res.fold((l) {
              setState(() => {
                    debugPrint(l.message),
                    isLoading = false,
                  });
            }, (r) {
              setState(() {
                customerProfileDetail = r.customerProfileDetail!;
              });
            }));
  }

  isExpanded() {
    setState(() {
      if (isExpand == false) {
        isExpand = true;
        log(isExpand.toString());
      } else if (isExpand == true) {
        isExpand = false;
        log(isExpand.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final name = SharedPrefs.instance.getString(AppKeys.name) ?? '';
    // final number = SharedPrefs.instance.getString(AppKeys.number) ?? '';
    // final email = SharedPrefs.instance.getString(AppKeys.email) ?? '';
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Column(
        children: [
          Container(
            height: 171.h,
            color: context.colorScheme.primary,
            padding: const EdgeInsets.only(
              top: 72,
              left: 14,
              right: 8.50,
              bottom: 19,
            ),
            child: customerProfileDetail.name == null
                ? SizedBox(width: MediaQuery.of(context).size.width)
                : Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customerProfileDetail.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "0${customerProfileDetail.mobileNumber}" ?? '',
                              style: context.textTheme.labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              customerProfileDetail.email ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      customerProfileDetail.profileImage != null
                          ? Container(
                              alignment: Alignment.center,
                              height: 90.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          '${ApiUrl.baseUrl}public/customer_uploads/${customerProfileDetail.profileImage}')),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 4)),
                            )
                          : Container(
                              alignment: Alignment.center,
                              height: 90.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 4.w)),
                              child: Text(
                                  customerProfileDetail.name
                                      .toString()
                                      .split('')
                                      .first
                                      .toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: Colors.white)),
                            ),
                    ],
                  ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 34, left: 14, right: 14),
            height: MediaQuery.of(context).size.height / 1.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navigatorListCard(
                  context: context,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const DashboardScreen()));
                  },
                  label: 'Home',
                ),
                Dimensions.kVerticalSpaceSmall,
                navigatorListCard(
                  context: context,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const BookingScreen(
                              title: 'New Booking',
                              stageId: '1',
                            )));
                  },
                  label: 'Bookings',
                ),
                // Dimensions.kVerticalSpaceSmall,
                // navigatorListCard(
                //   context: context,
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (_) => const BookingScreen(
                //             title: 'Assign Booking', stageId: '2')));
                //   },
                //   label: 'Assign Booking',
                // ),
                // Dimensions.kVerticalSpaceSmall,
                // navigatorListCard(
                //   context: context,
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (_) => const BookingScreen(
                //             title: 'In-Progress Booking', stageId: '3')));
                //   },
                //   // icon: AppIcon.bookingHistory,
                //   label: 'In-Progress Booking',
                // ),
                // Dimensions.kVerticalSpaceSmall,
                // navigatorListCard(
                //   context: context,
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (_) => const BookingScreen(
                //             title: 'Booking History', stageId: '4')));
                //   },
                //   label: 'Booking History',
                // ),
                Dimensions.kVerticalSpaceSmall,
                navigatorListCard(
                  context: context,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const CustomerProfileSettings()));
                  },
                  label: 'Settings',
                ),
                Dimensions.kVerticalSpaceSmall,
                navigatorListCard(
                    context: context,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => HelpAndSupportScreen()));
                    },
                    label: 'Help and Support'),
                // isExpand ? contactCartText('0123244261') : const SizedBox(),
                // const SizedBox(height: 2),
                // isExpand ? contactCartText('0122661021') : const SizedBox(),
                // const SizedBox(height: 2),
                // isExpand ? contactCartText('0123445193') : const SizedBox(),
                // const SizedBox(height: 2),
                // isExpand ? contactCartText('0177447212') : const SizedBox(),

                const Spacer(),

                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //   decoration: BoxDecoration(
                //       color: const Color(0xFFE5E6E6),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Contacts',
                //           style: context.textTheme.bodySmall!.copyWith(
                //               fontSize: 15.sp, fontWeight: FontWeight.w500)),
                //       const SizedBox(height: 2),
                //       contactCartText('0123244261'),
                //       const SizedBox(height: 2),
                //       contactCartText('0122661021'),
                //       const SizedBox(height: 2),
                //       contactCartText('0123445193'),
                //       const SizedBox(height: 2),
                //       contactCartText('0177447212'),
                //     ],
                //   ),
                // ),

                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        SharedPrefs.instance.remove(AppKeys.userId);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const EmailAuthScreen()),
                            (route) => false);
                      },
                      child: Container(
                        height: 25.h,
                        width: 87.w,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1B293D),
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(AppIcon.logoutSvg),
                            Text(
                              'Logout',
                              style: context.textTheme.labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Dimensions.kHorizontalSpaceMedium
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  navigatorListCard({
    required BuildContext context,
    required VoidCallback onPressed,
    required String label,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.bodySmall!
            .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget contactCartText(String phoneNo) {
    return Row(
      children: [
        const Icon(Icons.phone, size: 15),
        SizedBox(width: 4.w),
        Text(phoneNo,
            style: context.textTheme.bodySmall!.copyWith(fontSize: 15.sp)),
      ],
    );
  }
}
