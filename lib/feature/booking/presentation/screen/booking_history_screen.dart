import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/core/core.dart';

import '../../../../../config/config.dart';
import '../../booking.dart';

class BookingHistoryScreen extends ConsumerStatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  ConsumerState<BookingHistoryScreen> createState() =>
      _BookingHistoryScreenConsumerState();
}

class _BookingHistoryScreenConsumerState
    extends ConsumerState<BookingHistoryScreen> {
  bool isLoading = false;
  List<BookingsList> bookingList = [];

  @override
  void initState() {
    super.initState();
    initialGetVehicleType();
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
                        bookingList = r.bookingsList ?? [],
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
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Booking History',
          style: textTheme.headlineMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        padding: Dimensions.kPaddingAllMedium,
        itemCount: bookingList.length,
        itemBuilder: (_, i) {
          final booking = bookingList[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BookingDetailScreen(
                          bookingId: booking.id.toString(),
                          discount: 0,
                        )));
              },
              child: Container(
                padding: Dimensions.kPaddingAllMedium,
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius: Dimensions.kBorderRadiusAllSmall,
                ),
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
                              bookingServiceType(
                                  booking.serviceType.toString()),
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
                                  borderRadius:
                                      Dimensions.kBorderRadiusAllSmallest,
                                  color: context.colorScheme.onError
                                      .withOpacity(.4),
                                ),
                                child: Text(
                                  booking.bookingType ?? '',
                                  style: context.textTheme.labelMedium,
                                ),
                              ),
                      ],
                    ),
                    Dimensions.kVerticalSpaceSmall,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    Dimensions.kVerticalSpaceSmall,
                    Row(
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
                                  image: const AssetImage(
                                      AppIcon.vehicleFiveTonne),
                                  width: Dimensions.iconSizeSmall,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '5 tonne',
                                  style: context.textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Dimensions.kSpacer,
                        Container(
                          padding: Dimensions.kPaddingAllSmall,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: Dimensions.kBorderRadiusAllSmallest,
                            color: context.colorScheme.primary,
                          ),
                          child: Text(
                            'MYR ${booking.amount.toString()}',
                            style: context.textTheme.labelLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
