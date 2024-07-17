import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:themovers/feature/dashboard/presentation/screen/widget/custom_image_slider.dart';
import 'dart:developer';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../feature.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() =>
      _DashboardScreenConsumerState();
}

class _DashboardScreenConsumerState extends ConsumerState<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CustomerProfileDetail customerProfileDetail = CustomerProfileDetail();
  bool isLoading = false;
  var selectService = 0;
  final Connectivity _connectivity = Connectivity();
  bool isConnection = false;

  List<Map<String, dynamic>> service = [
    {"label": "Budget\nMoving", "icon": AppIcon.budgetMoving},
    {"label": "Premium\nMoving", "icon": AppIcon.premiumMoving},
    {"label": "Disposal\nService", "icon": AppIcon.disposalMoving},
    {"label": "Manpower\nService", "icon": AppIcon.manpowerMoving},
    {"label": "Tumpang\nService", "icon": AppIcon.tumpangMoving},
  ];

  @override
  void initState() {
    initialCustomerProfileDetail();
    _initConnectivity();
    getVersionCode();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  ///For NetWork Connection
  Future<void> _initConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      isConnection = (result != ConnectivityResult.none);
    });
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

  getVersionCode() async {
    final packageInfo = await PackageInfo.fromPlatform();

    WidgetsBinding.instance.addPostFrameCallback((__) {
      ref.read(imageSliderProvider.notifier).getVersionCode().then(
            (response) => response.fold(
              (_) {},
              (version) {
                final Version currentVersion =
                    Version.parse(packageInfo.version);
                final Version latestVersion =
                    Version.parse(version.version ?? "");

                final comparison = currentVersion.compareTo(latestVersion);
                log("Comparison ${comparison.toString()}");

                if (comparison < 0) {
                  showUpdateAlert(version.version, packageInfo, 'old');
                } else if (comparison > 0) {
                  showUpdateAlert(version.version, packageInfo, 'new');
                }
              },
            ),
          );
    });
  }

  void showUpdateAlert(
      dynamic appVersion, PackageInfo packageInfo, String label) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AppUpdater();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBars(context),
      drawer: const CustomDrawer(),
      body: isConnection
          ? SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 8,
                      ),
                      child: Row(children: [
                        Text('Welcome Back! ',
                            style: textTheme.headlineMedium!.copyWith(
                                color: const Color(0xFFC1C1C1),
                                fontWeight: FontWeight.w400)),
                        customerProfileDetail.name == null
                            ? const SizedBox()
                            : Expanded(
                                child: Text(customerProfileDetail.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.headlineMedium!.copyWith(
                                        color: const Color(0xFFB30205),
                                        fontWeight: FontWeight.w600)),
                              )
                      ]),
                    ),
                    const CustomImageSlider(),
                    Dimensions.kVerticalSpaceMedium,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Color(0xFFB40205),
                            ),
                            child: Text(
                              'How can we help you?',
                              style: textTheme.titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          Dimensions.kVerticalSpaceSmaller,
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),

                                    // Set your desired border radius
                                  ),
                                  height: 105.h, // Height of each container
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5, // Number of containers
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final services = service[index];
                                      final image = services['icon'].toString();
                                      final label =
                                          services['label'].toString();
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          switch (index) {
                                            case 0:
                                              setState(() {
                                                selectService = 0;
                                              });
                                            case 1:
                                              setState(() {
                                                selectService = 1;
                                              });
                                            case 2:
                                              setState(() {
                                                selectService = 2;
                                              });
                                            case 3:
                                              setState(() {
                                                selectService = 3;
                                              });
                                            case 4:
                                              setState(() {
                                                selectService = 4;
                                              });
                                          }
                                        },
                                        child: Opacity(
                                          opacity: selectService == index
                                              ? 1.0
                                              : 0.60,
                                          child: Container(
                                            width: 75.w,
                                            height: 105.h,
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                            ),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 0.50.w,
                                                    color: selectService ==
                                                            index
                                                        ? const Color(
                                                            0xFFB30205)
                                                        : Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(image,
                                                    height: 45.h, width: 44.w),
                                                SizedBox(height: 16.h),
                                                Text(label,
                                                    textAlign: TextAlign.center,
                                                    style: textTheme.labelSmall!
                                                        .copyWith(
                                                            fontSize: 10.sp,
                                                            color: selectService ==
                                                                    index
                                                                ? const Color(
                                                                    0xFFB30205)
                                                                : Colors
                                                                    .black)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1.w,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          servicesCardUI()
                          // Wrap(
                          //   spacing: 12.w,
                          //   runSpacing: 12.h,
                          //   children: [
                          //     ...service.map(
                          //       (e) => serviceCardUI(
                          //         icon: e["icon"],
                          //         title: e["label"],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 12.h,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F2),
                borderRadius: Dimensions.kBorderRadiusAllSmaller,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No Connection Found',
                        style: context.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFFB10205),
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Please check your network connection',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: const Color(0xFFB10205),
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/icons/no_signal.png',
                      width: 30.w, color: const Color(0xFFB10205))
                ],
              ),
            ),
    );
  }

  Widget servicesCardUI() {
    final textTheme = context.textTheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
      height: 243.h,
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: const Color(0xFFF0F0F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              selectService == 0
                  ? "Budget Moving"
                  : selectService == 1
                      ? "Premium Moving"
                      : selectService == 2
                          ? "Disposal Service "
                          : selectService == 3
                              ? "Manpower Service"
                              : selectService == 4
                                  ? "Tumpang Moving"
                                  : "",
              style:
                  textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
          selectService == 2
              ? Text(
                  'Package Includes ManPower',
                  style: TextStyle(fontSize: 14.sp),
                )
              : const SizedBox(),
          SizedBox(height: 4.h),
          selectService == 1
              ? Column(
                  children: [
                    // Text('Just sit and Relax, we’ve got you covered',
                    //     style: textTheme.labelMedium!),
                    Text(
                        'Premium moving service goes beyond basic moving by offering perks like packing and handling specialty items, providing a stress-free and convenient experience for customers.',
                        style: textTheme.labelMedium!),
                    // customPremiumText('1 Trip Limit'),
                    // customPremiumText('Unlimited Wrapping'),
                    // customPremiumText(
                    //     ' Free Furniture\nDismantling &\nReassembling'),
                    // customPremiumText('Free 10-20 Boxes'),
                    // customPremiumText('1 Driver-3 Manpower'),
                  ],
                )
              : const SizedBox(),
          const Spacer(),
          selectService == 1
              ?
              // Row(
              //         children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              // customPremiumText(' 1 Trip Limit'),
              // const SizedBox(height: 2),
              // customPremiumText(' Unlimited Wrapping'),
              // const SizedBox(height: 2),
              // customPremiumText(
              //     ' Free Furniture Dismantling &\n Reassembling'),
              // const SizedBox(height: 4),
              // customPremiumText(' Free 10-20 Boxes'),
              // const SizedBox(height: 2),
              // customPremiumText(' 1 Driver-3 Manpower'),
              // SizedBox(
              //   height: 100.h,
              //   child: SingleChildScrollView(
              //     child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const Text(
              //               '1 Tonne Lorry 10 Feet - \nLimited to one Trip ',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w500)),
              //           SizedBox(height: 4.h),
              //           customPremiumText(
              //               ' Max cargo size 10’x5’x5’ '),
              //           SizedBox(height: 2.h),
              //           customPremiumText('3 Skilled Movers'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Packing Service -\n Shrink & Bubble Wrap '),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               ' Furniture assembly and \ndisassembly'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Free 10 Boxes - \n[610 x 458 x 458] MM '),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Customized packing materials'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Dedicated Moving coordinator'),
              //           SizedBox(height: 2.h),
              //           customPremiumText('Customized moving plans'),
              //           SizedBox(height: 8.h),
              //           const Text(
              //               '3 Tonne Lorry 14 Feet - \nLimited to one Trip',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w500)),
              //           SizedBox(height: 4.h),
              //           customPremiumText('Max cargo size 14’x7’x7’'),
              //           SizedBox(height: 2.h),
              //           customPremiumText('3 - 4 Skilled Movers'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Packing Service -\n Shrink & Bubble Wrap'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Furniture assembly and \ndisassembly'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               ' Free 20 Boxes -\n [610 x 458 x 458] MM '),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               ' Customized packing materials'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Dedicated Moving coordinator'),
              //           SizedBox(height: 2.h),
              //           customPremiumText('Customized moving plans'),
              //           SizedBox(height: 8.h),
              //           const Text(
              //               '5 Tonne Lorry 17 Feet - \nLimited to one Trip ',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w500)),
              //           SizedBox(height: 4.h),
              //           customPremiumText(
              //               'Max cargo size 17’x7.2’x7’'),
              //           SizedBox(height: 2.h),
              //           customPremiumText('3 - 4 Skilled Movers'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Packing Service -\n Shrink & Bubble Wrap '),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Furniture assembly and disassembly'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Free 20 Boxes - \n[610 x 458 x 458] MM'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Customized packing materials'),
              //           SizedBox(height: 2.h),
              //           customPremiumText(
              //               'Dedicated Moving coordinator'),
              //           SizedBox(height: 2.h),
              //           customPremiumText('Customized moving plans'),
              //           SizedBox(height: 2.h),
              //         ]),
              //   ),
              // ),
              //   ],
              // ),
              // Text(
              //     '*  1 Trip Limit\n*  Unlimited Wrapping\n*  Free Furniture\n    Dismantling &\n    Reassembling\n*  Free 10-20 Boxes\n*  1 Driver - 3 Manpower',
              //     style: textTheme.labelMedium),
              // const Spacer(),
              Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset(AppIcon.premiumCard,
                      height: 100.h, width: 98.w),
                )
              //   ],
              // )
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                      selectService == 0
                          ? "Experience the most Affordable and seamless Moving service.Choose your type of Vehicle and Extra services according to your needs."
                          : selectService == 2
                              ? "No Fret -  Chill! We will handle all the unwanted things for you. Let’s Go Green - We will make sure your wastes are disposed properly."
                              : selectService == 3
                                  ? "Leave the Heavy Lifting to us - Enjoy! Hassle-Free on time Movement.\n"
                                  : selectService == 4
                                      ? "Delivery service including:Cargo, Logistics, Lorry Transport and Movers delivery services in sharing basics"
                                      : "",
                      style: textTheme.labelMedium),
                ),
          // const SizedBox(height: 4),
          selectService == 0
              ? Image.asset(AppIcon.budgetCard, height: 100.h, width: 98.w)
              : selectService == 2
                  ? Image.asset(AppIcon.disposalCard,
                      height: 100.h, width: 98.w)
                  : selectService == 3
                      ? Image.asset(AppIcon.manpowerCard,
                          height: 100.h, width: 98.w)
                      : selectService == 4
                          ? Image.asset(AppIcon.tumpangCard,
                              height: 100.h, width: 98.w)
                          : const SizedBox(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => navigatedToBookingScreen(selectService),
                child: Container(
                  alignment: Alignment.center,
                  width: 114.w,
                  height: 31.h,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(10.r)),
                    color: const Color(0xFFB30205),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Book Now",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFFFFFFF),
                          )),
                      SizedBox(width: 8.w),
                      SvgPicture.asset(AppIcon.arrowIcon)
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
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
            //
            children: [
              Dimensions.kHorizontalSpaceMedium,
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
              height: 0.h,
              color: const Color(0xFFC1C1C1).withOpacity(0.2),
              endIndent: 16,
              indent: 16)
        ],
      ),
    );
  }

  Future navigatedToBookingScreen(selectService) async {
    if (selectService == 0) {
      return Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const BudgetScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ));
    }
    if (selectService == 1) {
      return Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const PremiumScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ));
    }
    if (selectService == 2) {
      return Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            const DisposalScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ));
    }
    if (selectService == 3) {
      return Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            const ManpowerScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ));
    }
    if (selectService == 4) {
      return Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const TumpangScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ));
    }
  }

  Widget customPremiumText(String text) {
    final textTheme = context.textTheme;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(AppIcon.redCheckBox, height: 20, width: 20),
          Text(text, style: textTheme.labelMedium)
        ]);
  }
}

// bottomSheet: CustomBottomSheet(
//   onPressed: () {
//     if (selectedVal == 'Budget') {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (_) => const BudgetScreen()));
//     }
//     if (selectedVal == 'Premium') {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (_) => const PremiumScreen()));
//     }
//     if (selectedVal == 'Disposal') {
//       Navigator.of(context).push(
//           MaterialPageRoute(builder: (_) => const DisposalScreen()));
//     }
//     if (selectedVal == 'Manpower') {
//       Navigator.of(context).push(
//           MaterialPageRoute(builder: (_) => const ManpowerScreen()));
//     }
//
//     if (selectedVal == 'Tumpang') {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (_) => const TumpangScreen()));
//     }
//   },
// ),
