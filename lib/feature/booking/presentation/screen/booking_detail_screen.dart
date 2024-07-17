import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../booking/booking.dart';
import '../../../budget/presentation/screen/widget/address_card_container.dart';
import '../../../budget/presentation/screen/widget/container_card.dart';
import '../../../dashboard/dashboard.dart';

class ExtraServiceModel {
  String label;
  String count;

  ExtraServiceModel({required this.label, required this.count});
}

class BookingDetailScreen extends ConsumerStatefulWidget {
  final String bookingId;
  final String? stageId;
  final bool? isTrue;
  final double discount;

  const BookingDetailScreen(
      {super.key,
      required this.bookingId,
      this.stageId,
      this.isTrue,
      required this.discount});

  @override
  ConsumerState<BookingDetailScreen> createState() =>
      _BookingDetailScreenConsumerState();
}

class _BookingDetailScreenConsumerState
    extends ConsumerState<BookingDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String paymentMode = '2';
  Bookings booking = Bookings();
  BookingDetailsModel bookingDetailsModel = BookingDetailsModel();

  List<ExtraServiceModel> services = [];

  @override
  void initState() {
    super.initState();
    initialBookingDetails();
  }

  Future<void> initialBookingDetails() async {
    setState(() => isLoading = true);
    ref
        .read(bookingProvider.notifier)
        .getBookingDetails(widget.bookingId)
        .then((res) => res.fold(
            (l) => {
                  setState(() => {
                        debugPrint(l.message),
                        isLoading = false,
                      })
                },
            (r) => {
                  setState(() => {
                        booking = r.bookings!,
                        bookingDetailsModel = r,
                        setExtraService(booking),
                        isLoading = false,
                      })
                }));
  }

  void setExtraService(Bookings booking) {
    if (booking.serviceType == 'Budget') {
      services = [
        ExtraServiceModel(
            label: 'Manpower', count: booking.manpowerCount.toString()),
        ExtraServiceModel(label: 'Boxes', count: booking.boxCount.toString()),
        ExtraServiceModel(label: 'Shrink', count: booking.wrapping.toString()),
        ExtraServiceModel(label: 'Bubble', count: booking.bubble.toString()),
        ExtraServiceModel(
            label: 'Dining Table', count: booking.diningTableCount.toString()),
        ExtraServiceModel(
            label: 'Office Table', count: booking.tableCount.toString()),
        ExtraServiceModel(label: 'Bed', count: booking.bedCount.toString()),
        ExtraServiceModel(
            label: 'Wardrobe', count: booking.wardrobeCount.toString()),
        ExtraServiceModel(
            label: 'Tail Gate', count: booking.tailGate.toString()),
        ExtraServiceModel(
            label: 'Stair Carry', count: booking.stairCarryEnabled.toString()),
        ExtraServiceModel(
            label: 'Long Push', count: booking.longpushEnabled.toString()),
      ];
    }
    if (booking.serviceType == 'Premium') {
      services = [
        // ExtraServiceModel(
        //     label: 'Manpower', count: booking.manpowerCount.toString()),
        ExtraServiceModel(
            label: 'Tail Gate', count: booking.tailGate.toString()),
        ExtraServiceModel(
            label: 'Stair Carry', count: booking.stairCarryEnabled.toString()),
        ExtraServiceModel(
            label: 'Long Push', count: booking.longpushEnabled.toString()),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context),
      drawer: const CustomDrawer(),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     bookingServiceType(
      //     booking.serviceType != null
      //         ? "${booking.serviceType.toString()} Booking"
      //         : '',
      //     style: textTheme.headlineMedium?.copyWith(color: Colors.white),
      //   ),
      //   leading: widget.isTrue == true
      //       ? InkWell(
      //           onTap: () => {
      //             Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                 builder: (_) => const DashboardScreen())),
      //           },
      //           child: const Icon(Icons.home, color: Colors.white),
      //         )
      //       : InkWell(
      //           onTap: () => Navigator.pop(context),
      //           child: const Icon(Icons.arrow_back_sharp, color: Colors.white),
      //         ),
      // ),
      floatingActionButtonLocation: widget.isTrue == true
          ? FloatingActionButtonLocation.centerFloat
          : null,
      // bottomNavigationBar: widget.stageId != '4'
      //     ? null
      //     : InkWell(
      //         onTap: () => showModalBottomSheet(
      //           context: context,
      //           enableDrag: false,
      //           isDismissible: true,
      //           isScrollControlled: true,
      //           backgroundColor: Colors.transparent,
      //           builder: (_) {
      //             return BookingUpdateBottomSheet(bookingId: widget.bookingId);
      //           },
      //         ),
      //         child: Container(
      //           height: 50,
      //           margin: const EdgeInsets.all(16),
      //           alignment: Alignment.center,
      //           decoration: BoxDecoration(
      //               color: const Color(0xFF23978E),
      //               borderRadius: BorderRadius.circular(12)),
      //           padding: Dimensions.kPaddingAllSmall,
      //           child: Text(
      //             "COMPLETE JOB",
      //             style: context.textTheme.bodySmall
      //                 ?.copyWith(color: Colors.white),
      //           ),
      //         ),
      //       ),
      floatingActionButton: widget.isTrue == true
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardScreen()),
                    (route) => false);
              },
              label: const Text('Back to Home'),
            )
          : null,
      body: isLoading
          ? const Center(child: SpinKitHourGlass(color: Colors.red))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking.serviceType != null
                              ? "${booking.serviceType.toString()} Booking"
                              : '',
                          style: textTheme.headlineMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          booking.bookingDateTime != null
                              ? booking.bookingDateTime.toString()
                              : '',
                          style: textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmall,

                    /// Customer Details
                    booking.userName == null ||
                            widget.stageId == 'Pending' ||
                            widget.stageId == "Completed"
                        ? const SizedBox()
                        : CardContainer(
                            isTrue: true,
                            topChild: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Fleet Admin Detail',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            bottomChild: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        Dimensions.kBorderRadiusAllLarger,
                                    color: context.colorScheme.primary
                                        .withOpacity(.2),
                                  ),
                                  child: Text(
                                    booking.userName
                                        .toString()
                                        .split('')
                                        .first
                                        .toUpperCase(),
                                    style: context.textTheme.headlineLarge
                                        ?.copyWith(),
                                  ),
                                ),
                                Dimensions.kHorizontalSpaceSmall,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking.userName.toString(),
                                      style: context.textTheme.titleMedium,
                                    ),
                                    Text(
                                      "0${booking.mobileNumber.toString()}",
                                      style: context.textTheme.titleSmall,
                                    ),
                                    Text(
                                      booking.emailId.toString(),
                                      style: context.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => makePhoneCall(
                                      number:
                                          "+60${booking.mobileNumber ?? ''}"),
                                  child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context.colorScheme.primary
                                            .withOpacity(.2),
                                      ),
                                      child: const Icon(Icons.phone)),
                                ),
                                SizedBox(width: 8.w)
                              ],
                            ),
                          ),
                    booking.customerName == null
                        ? const SizedBox()
                        : Dimensions.kVerticalSpaceSmallest,
                    booking.serviceType != 'Budget' &&
                            booking.serviceType != 'Premium' &&
                            booking.serviceType != 'Manpower' &&
                            booking.serviceType != 'Disposal'
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xFFF0F0F0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Booking ID',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1B293D),
                                        )),
                                    Text(booking.id.toString(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1B293D),
                                        ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Date/Time',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1B293D),
                                        )),
                                    booking.enabled == '2'
                                        ? Text('Any Time',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF1B293D),
                                            ))
                                        : Text(booking.dateTime.toString())
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    booking.serviceType != 'Budget' &&
                            booking.serviceType != 'Premium' &&
                            booking.serviceType != 'Manpower' &&
                            booking.serviceType != 'Disposal'
                        ? Dimensions.kVerticalSpaceSmall
                        : const SizedBox(),
                    addressDetailCardUI(),
                    booking.serviceType != 'Budget' &&
                            booking.serviceType != 'Premium' &&
                            booking.serviceType != 'Manpower' &&
                            booking.serviceType != 'Disposal'
                        ? Dimensions.kVerticalSpaceSmall
                        : const SizedBox(),
                    if (booking.serviceType != 'Budget' &&
                        booking.serviceType != 'Premium' &&
                        booking.serviceType != 'Manpower' &&
                        booking.serviceType != 'Disposal')
                      CardContainer(
                          topChild: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Require Date and Time',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          bottomChild: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date/Time',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1B293D),
                                    )),
                                booking.enabled == '2'
                                    ? Text('Any Time',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1B293D),
                                        ))
                                    : Text(booking.dateTime.toString())
                              ],
                            ),
                          ),
                          isTrue: true)
                    else
                      const SizedBox(),
                    Dimensions.kVerticalSpaceSmall,
                    booking.serviceType == 'Manpower'
                        ? manpowerCardUI()
                        : const SizedBox(),

                    booking.vehicleType == null
                        ? const SizedBox()
                        : Dimensions.kVerticalSpaceSmallest,
                    booking.vehicleType == null ||
                            booking.serviceType == 'Manpower'
                        ? const SizedBox()
                        : vehicleCardUI(),
                    booking.serviceType == null
                        ? const SizedBox()
                        : Dimensions.kVerticalSpaceSmallest,
                    booking.serviceType != 'Budget' &&
                            booking.serviceType != 'Premium'
                        ? const SizedBox()
                        : Dimensions.kVerticalSpaceSmallest,
                    booking.serviceType != 'Budget' &&
                            booking.serviceType != 'Premium'
                        ? const SizedBox()
                        : additionalCardUI(),
                    Dimensions.kVerticalSpaceSmall,
                    booking.totalAmount == null || booking.totalAmount == '0'
                        ? const SizedBox()
                        : priceCardUI(),
                    Dimensions.kVerticalSpaceSmall,

                    Dimensions.kVerticalSpaceSmall,
                    widget.isTrue == true
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: Dimensions.kPaddingAllMedium,
                              decoration: BoxDecoration(
                                color: const Color(0xFFB30205),
                                borderRadius:
                                    Dimensions.kBorderRadiusAllSmaller,
                              ),
                              child: Text(
                                'Booking Received. The Next Immediate Move Manager will be in touch with you soon',
                                textAlign: TextAlign.center,
                                style: context.textTheme.titleMedium?.copyWith(
                                    color: context.colorScheme.onPrimary),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
    );
  }

  Widget priceCardUI() {
    return CardContainer(
        topChild: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount',
                  style: context.textTheme.headlineSmall,
                ),
                Dimensions.kVerticalSpaceSmaller,
                Dimensions.kVerticalSpaceSmaller,
                booking.serviceType == 'Disposal'
                    ? BookingPriceCardList(
                        label: 'Lorry${booking.vehicleType}',
                        amount: booking.amount ?? '0')
                    : const SizedBox(),
                double.parse(booking.amount ?? '0').toInt() == 0
                    ? const SizedBox()
                    : booking.serviceType == 'Manpower' ||
                            booking.serviceType == 'Disposal'
                        ? const SizedBox()
                        : BookingPriceCardList(
                            label: 'Lorry ${booking.vehicleType}',
                            amount: booking.vehicleAmount ?? '0',
                          ),
                booking.serviceType == 'Premium'
                    ? const SizedBox()
                    : booking.serviceType == 'Budget' &&
                            booking.manpowerAmount != "0.00"
                        ? BookingPriceCardList(
                            label: 'Manpower',
                            amount: '${booking.manpowerAmount}')
                        : booking.manpowerCount == null ||
                                booking.manpowerCount == 0
                            ? const SizedBox()
                            : BookingPriceCardList(
                                label:
                                    'ManPower (members-${booking.manpowerCount}${booking.manpowerHourCount == null ? '' : ',Hours${booking.manpowerHourCount}'})',
                                amount: booking.amount ?? '0',
                              ),
                booking.boxCount == null || booking.boxCount == 0
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Box',
                        amount: booking.boxAmount ?? '0',
                      ),
                booking.shrinkWrapAmount == null ||
                        booking.shrinkWrapAmount == '0' ||
                        booking.shrinkWrapAmount == '' ||
                        booking.shrinkWrapAmount == '0.00'
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Shrink Wrapping ',
                        amount: booking.shrinkWrapAmount ?? '0',
                      ),
                booking.bubbleWrapAmount == null ||
                        booking.bubbleWrapAmount == '0' ||
                        booking.bubbleWrapAmount == '' ||
                        booking.bubbleWrapAmount == '0.00'
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Bubble Wrapping ',
                        amount: booking.bubbleWrapAmount ?? '',
                      ),
                booking.diningTableCount == null ||
                        booking.diningTableCount == 0
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Dining Table ',
                        amount: booking.diningTableAmount ?? '0',
                      ),
                booking.tableCount == null || booking.tableCount == 0
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Office Table',
                        amount: booking.tableAmount ?? '0',
                      ),
                booking.bedCount == null || booking.bedCount == 0
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Bed',
                        amount: booking.bedAmount ?? '0',
                      ),
                booking.wardrobeCount == null ||
                        booking.wardrobeCount == 0 ||
                        booking.wardrobeAmount == "0"
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Wardrobe',
                        amount: booking.wardrobeAmount ?? '0',
                      ),
                booking.stairCarryEnabledAmount == null ||
                        booking.stairCarryEnabledAmount == '0' ||
                        booking.stairCarryEnabledAmount == '' ||
                        booking.stairCarryEnabledAmount == '0.00'
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Stair Carry',
                        amount: booking.stairCarryEnabledAmount ?? '0',
                      ),
                booking.tailgateAmount == null ||
                        booking.tailgateAmount == '0' ||
                        booking.tailgateAmount == '' ||
                        booking.tailgateAmount == '0.00'
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Tail Gate',
                        amount: booking.tailgateAmount ?? '0',
                      ),
                booking.longpushEnabled == null ||
                        booking.longpushEnabled == '0' ||
                        booking.longpushEnabled == '' ||
                        booking.longpushEnabled == '0.00'
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Long Push',
                        amount: booking.longpushEnabledAmount ?? '0',
                      ),
                booking.discount == '0' || booking.discount == null
                    ? const SizedBox()
                    : BookingPriceCardList(
                        label: 'Discount', amount: "${booking.discount}"),
                // booking.additionalServiceAmount == '00.00' ||
                //         booking.additionalServiceAmount == null
                //     ? const SizedBox()
                //     : BookingPriceCardList(
                //         label: 'Additional Service',
                //         amount:
                //             double.parse("${booking.additionalServiceAmount}")),
                if (bookingDetailsModel.additionalAmountHistoryList == null)
                  const SizedBox()
                else
                  for (var i = 0;
                      i <
                          bookingDetailsModel
                              .additionalAmountHistoryList!.length;
                      i++)
                    BookingPriceCardList(
                      label: bookingDetailsModel
                              .additionalAmountHistoryList![i].description ??
                          '',
                      amount:
                          "${bookingDetailsModel.additionalAmountHistoryList![i].addtionalAction ?? ' '}${bookingDetailsModel.additionalAmountHistoryList![i].additionalAmount ?? ' '}",
                    )
              ],
            )),
        bottomChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: context.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                "${booking.totalAmount} MYR",
                style: context.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        isTrue: false);
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
              widget.isTrue == true
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardScreen()),
                      (route) => false)
                  : Navigator.pop(context);
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

  Widget addressDetailCardUI() {
    return CardContainer(
      isTrue: true,
      topChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Address Details',
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      bottomChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              children: [
                AddressCardContainer(
                    isFirst: true,
                    isLast: booking.dropOffAddress == null ? true : false,
                    isPass: false,
                    pickupOrDropIcon: AppIcon.pickupLocation,
                    child: RichText(
                      text: TextSpan(
                        text: 'Pickup Address',
                        style: context.textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                        children: [
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text: booking.pickupAddress ?? '',
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    )),
                booking.dropOffAddress == null
                    ? const SizedBox()
                    : AddressCardContainer(
                        isFirst: false,
                        isLast: true,
                        isPass: false,
                        pickupOrDropIcon: AppIcon.dropLocation,
                        child: RichText(
                            text: TextSpan(
                          text: 'Drop Address',
                          style: context.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                          children: [
                            const TextSpan(text: '\n'),
                            TextSpan(
                              text: booking.dropOffAddress ?? "",
                              style: context.textTheme.labelMedium,
                            ),
                          ],
                        )))
              ],
            )),
            booking.distance == null
                ? const SizedBox()
                : Column(
                    children: [
                      RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            text: 'Distance',
                            style: context.textTheme.labelMedium,
                            children: [
                              const TextSpan(text: '\n'),
                              TextSpan(
                                text: booking.distance,
                                style: context.textTheme.headlineLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp),
                              ),
                              TextSpan(
                                text: 'Km ',
                                style: context.textTheme.headlineLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp),
                              ),
                            ],
                          )),
                      // const SizedBox(height: 10),
                      // RichText(
                      //     textAlign: TextAlign.end,
                      //     text: TextSpan(
                      //       text: 'Travel Time',
                      //       style: context.textTheme.labelMedium,
                      //       children: [
                      //         const TextSpan(text: '\n'),
                      //         TextSpan(
                      //           text: '',
                      //           style: context.textTheme.headlineLarge
                      //               ?.copyWith(
                      //                   fontWeight: FontWeight.w700,
                      //                   fontSize: 20.sp),
                      //         ),
                      //         TextSpan(
                      //           text: '',
                      //           style: context.textTheme.headlineLarge
                      //               ?.copyWith(fontWeight: FontWeight.w900),
                      //         ),
                      //       ],
                      //     ))
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Widget manpowerCardUI() {
    return CardContainer(
        topChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Manpower',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        bottomChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${booking.manpowerCount} Manpower",
                style: context.textTheme.titleLarge?.copyWith(fontSize: 30.sp),
              ),
              Image.asset(AppIcon.manpowerCard, height: 90.h, width: 90.w)
            ],
          ),
        ),
        isTrue: true);
  }

  Widget vehicleCardUI() {
    return CardContainer(
        topChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Lorry Size',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        bottomChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  booking.vehicleType ?? '',
                  style:
                      context.textTheme.titleLarge?.copyWith(fontSize: 22.sp),
                ),
              ),
              Image.asset(AppIcon.tonneTypeVehicle)
            ],
          ),
        ),
        isTrue: true);
  }

  Widget additionalCardUI() {
    return CardContainer(
        topChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Additional Services',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        bottomChild: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  ...services.map((res) => res.count == "null" ||
                          res.count == "0" ||
                          res.count == "No" ||
                          res.count == ""
                      ? booking.serviceType == 'Premium'
                          ? Container()
                          : Container(
                              width: 0,
                              height: 0,
                              padding: const EdgeInsets.all(0),
                            )
                      : additionalServicesCardUI(
                          label: res.label, count: res.count)),
                ],
              ),
            ],
          ),
        ),
        isTrue: true);
  }

  bookingAddressCard() {
    return Padding(
      padding: Dimensions.kPaddingAllMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.serviceType.toString(),
                    style: context.textTheme.headlineSmall,
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: Dimensions.iconSizeSmallest,
                        color: context.colorScheme.onError,
                      ),
                      Dimensions.kHorizontalSpaceSmaller,
                      Text(
                        booking.bookingDateTime.toString(),
                        style: context.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
              Dimensions.kSpacer,
              booking.bookingType == null
                  ? const SizedBox()
                  : Container(
                      padding: Dimensions.kPaddingAllSmall,
                      decoration: BoxDecoration(
                        borderRadius: Dimensions.kBorderRadiusAllSmallest,
                        color: context.colorScheme.onError.withOpacity(.4),
                      ),
                      child: Text(
                        booking.bookingType ?? '',
                        style: context.textTheme.labelMedium,
                      ),
                    ),
            ],
          ),
          Dimensions.kVerticalSpaceSmall,
          Text(
            'Destination',
            style: context.textTheme.labelLarge,
          ),
          const SizedBox(height: 6),
          Container(
            padding: Dimensions.kPaddingAllSmall,
            decoration: BoxDecoration(
              color: context.colorScheme.background,
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pickup Address',
                        style: context.textTheme.titleSmall,
                      ),
                      Text(
                        booking.pickupAddress ?? '',
                        style: context.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                Dimensions.kHorizontalSpaceSmall,
                booking.dropOffAddress == null
                    ? const SizedBox()
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Drop off Address',
                              style: context.textTheme.titleSmall,
                            ),
                            Text(
                              booking.dropOffAddress ?? '',
                              style: context.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  vehicleInformationCard() {
    return Padding(
      padding: Dimensions.kPaddingAllMedium,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vehicle Information',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Image(
                    image: const AssetImage(AppIcon.vehicleFiveTonne),
                    width: Dimensions.iconSizeSmall,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    booking.vehicleType ?? '',
                    style: context.textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
          Dimensions.kSpacer,
          Container(
            padding: Dimensions.kPaddingAllSmall,
            decoration: BoxDecoration(
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              color: context.colorScheme.onError.withOpacity(.4),
            ),
            child: Text(
              'MYR: ${booking.totalAmount} ',
              style: context.textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }

  notesPointCard(String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: Dimensions.kBorderRadiusAllLarger,
            color: context.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: context.textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget additionalServicesCardUI(
      {required String label, required String count}) {
    return Container(
      width: 100.w,
      padding: Dimensions.kPaddingAllSmall,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: const Color(0xFFB30205)),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              count != "null"
                  ? count == "Yes" || count == "No"
                      ? count
                      : "x$count"
                  : '0',
              style: context.textTheme.labelLarge,
            ),
          ),
          Image(
            image: AssetImage(selectIcon(label)),
            height: 50.sp,
            width: 44.sp,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.textTheme.labelLarge?.copyWith(
              color: const Color(0xA0000000),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget serviceCardUI({required String icon, required String title}) {
    final textTheme = context.textTheme;
    return Stack(
      children: [
        InkWell(
          onTap: () => showModalBottomSheet(
            context: context,
            enableDrag: false,
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) {
              return const CustomBottomModelSheet(
                  selectedServices: "selectedServices");
            },
          ),
          borderRadius: Dimensions.kBorderRadiusAllSmall,
          child: Container(
            width: 160.w,
            height: 110.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: Dimensions.kBorderRadiusAllSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(icon), width: 50),
                Dimensions.kVerticalSpaceSmallest,
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget point(String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: Dimensions.kBorderRadiusAllLarger,
            color: context.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: context.textTheme.labelMedium,
        ),
      ],
    );
  }

  String vehicleTypeImage(String label) {
    if (label == '1 Tonne') {
      return AppIcon.vehicleOneTonne;
    }
    if (label == '3 Tonne') {
      return AppIcon.vehicleThreeTonne;
    }
    if (label == '5 Tonne') {
      return AppIcon.vehicleFiveTonne;
    }

    return AppIcon.vehicleFourXFourTonne;
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
      return 'Manpower Booking';
    }
    if (type == '5') {
      return 'Tumpang Booking';
    }
    return '';
  }

  String selectIcon(String label) {
    switch (label) {
      case "Manpower":
        return AppIcon.worker;
      case "Boxes":
        return AppIcon.boxes;
      case "Shrink":
        return AppIcon.shrinkWrapping;
      case "Bubble":
        return AppIcon.bubbleWrapping;
      case "Office Table":
        return AppIcon.workspace;
      case "Dining Table":
        return AppIcon.restaurant;
      case "Bed":
        return AppIcon.additionalBed;
      case "Wardrobe":
        return AppIcon.cupboard;
      case "Stair Carry":
        return AppIcon.carrying;
      case "Tail Gate":
        return AppIcon.tailgate;
      case "Long Push":
        return AppIcon.longPush;
    }
    return '';
  }

// void submit(BuildContext context) {
//   final userid = SharedPrefs.instance.getInt(AppKeys.userId);
//   final ratingEntities = RatingEntities(
//       userId: userid.toString(),
//       bookingId: widget.bookingId,
//       ratings: _rating.toString(),
//       feedback: _descriptionController.text);
//   ref
//       .read(bookingProvider.notifier)
//       .uploadBookingRating(ratingEntities)
//       .then((res) => res.fold(
//           (l) => setState(() => {
//                 debugPrint(l.message),
//                 Navigator.pop(context),
//               }),
//           (r) => setState(() {
//                 Navigator.pop(context);
//               })));
// }

  void makePhoneCall({required number}) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    await launchUrl(url);
  }
}

class BookingPriceCardList extends StatelessWidget {
  final String label;
  final String amount;

  const BookingPriceCardList(
      {super.key, required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style:
              textTheme.titleMedium?.copyWith(color: const Color(0xFF444550)),
        ),
        Text(
          "$amount MYR",
          style: textTheme.titleSmall?.copyWith(color: const Color(0xFF444550)),
        ),
      ],
    );
  }
}
// Dimensions.kVerticalSpaceSmallest,
// Container(
//   width: MediaQuery.of(context).size.width,
//   decoration: BoxDecoration(
//     color: context.colorScheme.onPrimary,
//     borderRadius: Dimensions.kBorderRadiusAllSmaller,
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: Dimensions.kPaddingAllMedium,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Notes:',
//               style: context.textTheme.titleMedium,
//             ),
//             const SizedBox(height: 6),
//             notesPointCard(
//                 'On fridge (Already Protective Wrapped),'),
//             const SizedBox(height: 4),
//             notesPointCard('One garden table'),
//             const SizedBox(height: 4),
//             notesPointCard(
//                 '6 boxes - size 18inch x 18inch x 20inch'),
//             const SizedBox(height: 4),
//             notesPointCard(
//                 'Call Ms Nud when arrive in Kura'),
//             const SizedBox(height: 24),
//             Text(
//               'Note: Please ensure to click and view each image and read for any remark from customer.',
//               style: context.textTheme.labelMedium
//                   ?.copyWith(fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// ),
