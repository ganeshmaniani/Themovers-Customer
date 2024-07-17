import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../dashboard/presentation/screen/widget/custom_drawer.dart';
import '../../booking.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final String title;
  final String stageId;

  const BookingScreen({required this.title, required this.stageId, super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenConsumerState();
}

class _BookingScreenConsumerState extends ConsumerState<BookingScreen> {
  bool isLoading = false;
  List<BookingListUnassigned> bookingList = [];
  List<BookingsList> bookingLists = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initialGetVehicleType();
    initialUnAssignedBookingList();
  }

  Future<void> _refreshData() async {
    initialGetVehicleType();
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> initialUnAssignedBookingList() async {
    setState(() => isLoading = true);
    final customerId = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;
    debugPrint(customerId.toString());
    final unAssignedBookingEntities = UnAssignedBookingEntities(
      customerId: customerId.toString(),
      bookingStatusId: widget.stageId,
    );

    ref
        .read(bookingProvider.notifier)
        .getUnAssignedBookingList(unAssignedBookingEntities)
        .then((res) => res.fold(
            (l) => {
                  setState(() => {
                        bookingList = [],
                        isLoading = false,
                      })
                },
            (r) => {
                  setState(() => {
                        bookingList = r.bookingListUnassigned ?? [],
                        isLoading = false,
                      })
                }));
  }

  Future<void> initialGetVehicleType() async {
    setState(() => isLoading = true);
    final customerId = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;
    ref
        .read(bookingProvider.notifier)
        .getBookingList(customerId.toString())
        .then((res) => res.fold(
            (l) => {
                  setState(() => {
                        bookingList = [],
                        isLoading = false,
                      })
                },
            (r) => {
                  setState(() => {
                        bookingLists = r.bookingsList ?? [],
                        debugPrint(bookingList.length.toString()),
                        isLoading = false,
                      })
                }));
  }

  String bookingServiceType(String type) {
    if (type == '1') {
      return 'Budget Booking';
    }
    if (type == '2') {
      return 'Premium Booking';
    }
    if (type == '3') {
      return 'Disposal Booking';
    }
    if (type == '4') {
      return 'Tumpang Booking';
    }
    if (type == '5') {
      return 'Manpower Booking';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: SpinKitHourGlass(color: Colors.red))
          : bookingLists.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(AppIcon.emptyDataIcon,
                      height: 250.sp, width: 250.sp))
              : SizedBox(
                  child: RefreshIndicator(
                    onRefresh: () => _refreshData(),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: Dimensions.kPaddingAllMedium,
                        itemCount: bookingLists.length,
                        itemBuilder: (_, i) {
                          final booking = bookingLists[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BookingDetailScreen(
                                          stageId: booking.bookingStatus,
                                          bookingId: booking.id.toString(),
                                          discount: 0,
                                        )));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F0),
                                  borderRadius:
                                      Dimensions.kBorderRadiusAllSmall,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Dimensions.kVerticalSpaceSmall,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 12),
                                          color: const Color(0xFFB30205),
                                          child: Text(
                                            bookingServiceType(
                                                booking.serviceType.toString()),
                                            style: context.textTheme.labelLarge!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                        Dimensions.kSpacer,
                                        Container(
                                          alignment: Alignment.center,
                                          // width: 100,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: booking.bookingStatus ==
                                                      "Available"
                                                  ? Colors.blue
                                                  : booking.bookingStatus ==
                                                          "Completed"
                                                      ? const Color(0xFF013220)
                                                      : booking.bookingStatus ==
                                                              'In Progress'
                                                          ? Colors.orange
                                                          : booking.bookingStatus ==
                                                                  'Accepted'
                                                              ? const Color(
                                                                  0xFF008000)
                                                              : Colors
                                                                  .transparent),
                                          child: Text(
                                              booking.bookingStatus ==
                                                      'Available'
                                                  ? 'Pending'
                                                  : booking.bookingStatus ==
                                                          'Completed'
                                                      ? 'Completed'
                                                      : booking.bookingStatus ==
                                                              'In Progress'
                                                          ? 'In Progress'
                                                          : booking.bookingStatus ==
                                                                  'Accepted'
                                                              ? 'Accepted'
                                                              : '',
                                              style: context
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ),
                                        // booking.totalAmount == null
                                        //     ? const SizedBox()
                                        //     : const Text(
                                        //         'MYR ',
                                        //         style: TextStyle(
                                        //             color: Color(0xFF1B293D),
                                        //             fontWeight:
                                        //                 FontWeight.w700,
                                        //             fontSize: 20),
                                        //       ),
                                        // booking.totalAmount == null
                                        //     ? const SizedBox()
                                        //     : Text(
                                        //         '${booking.totalAmount}',
                                        //         style: context
                                        //             .textTheme.labelLarge
                                        //             ?.copyWith(
                                        //                 color: const Color(
                                        //                     0xFF1B293D),
                                        //                 fontWeight:
                                        //                     FontWeight.w500,
                                        //                 fontSize: 20),
                                        //       ),
                                        const SizedBox(width: 12),
                                      ],
                                    ),
                                    Dimensions.kVerticalSpaceSmall,
                                    Row(
                                      mainAxisAlignment:
                                          booking.dropOffAddress == null
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(width: 12),
                                        SvgPicture.asset(AppIcon.pickupLocation,
                                            width: 14,
                                            colorFilter: const ColorFilter.mode(
                                                Color(0xFF1B293D),
                                                BlendMode.srcIn)),
                                        const SizedBox(width: 2),
                                        Text(
                                          'Pickup Address',
                                          style: context.textTheme.bodySmall!
                                              .copyWith(
                                                  color:
                                                      const Color(0xFF1B293D),
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(width: 4),
                                        booking.dropOffAddress == null
                                            ? const SizedBox()
                                            : const Expanded(
                                                flex: 1,
                                                child: DottedDivider()),
                                        const SizedBox(width: 4),
                                        booking.dropOffAddress == null
                                            ? const SizedBox()
                                            : SvgPicture.asset(
                                                AppIcon.dropLocation,
                                                width: 14,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color(0xFF1B293D),
                                                        BlendMode.srcIn)),
                                        const SizedBox(width: 2),
                                        booking.dropOffAddress == null
                                            ? const SizedBox()
                                            : Text(
                                                'Drop off Address',
                                                style: context
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF1B293D),
                                                ),
                                              ),
                                        const SizedBox(width: 12),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 28),
                                        booking.pickupAddress == null
                                            ? const SizedBox()
                                            : Expanded(
                                                flex: 5,
                                                child: Text(
                                                  booking.pickupAddress ?? '',
                                                  style: context
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                          color: const Color(
                                                              0xFF1B293D)),
                                                )),
                                        const SizedBox(width: 30),
                                        booking.dropOffAddress == null
                                            ? const SizedBox()
                                            : Expanded(
                                                flex: 5,
                                                child: Text(
                                                  booking.dropOffAddress ?? '',
                                                  style: context
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                          color: const Color(
                                                              0xFF1B293D)),
                                                )),
                                      ],
                                    ),
                                    Dimensions.kVerticalSpaceSmall,
                                    Row(
                                      children: [
                                        booking.bookingDateTime == null
                                            ? const SizedBox()
                                            : Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 2),
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF1B293D),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    16))),
                                                child: Text(
                                                  booking.bookingDateTime
                                                      .toString(),
                                                  // .split(' ')
                                                  // .first,

                                                  style: context
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                          color: Colors.white),
                                                ),
                                              ),
                                        const Spacer(),
                                        booking.totalAmount == null
                                            ? const SizedBox()
                                            : RichText(
                                                text: TextSpan(
                                                    text: 'MYR ',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF1B293D),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 20),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            booking.totalAmount,
                                                        style: context.textTheme
                                                            .labelLarge
                                                            ?.copyWith(
                                                                color: const Color(
                                                                    0xFF1B293D),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 20),
                                                      ),
                                                    ]),
                                              ),
                                        const SizedBox(width: 12)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Image(image: const AssetImage(AppIcon.theMoversLogo), width: 100.w),
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
    );
  }
}
