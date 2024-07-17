import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../budget/data/model/coupon_code_model.dart';
import '../../../budget/domain/entities/coupon_code_checker_entities.dart';
import '../../../budget/presentation/provider/budget_provider.dart';
import '../../../budget/presentation/screen/widget/address_card_container.dart';
import '../../../budget/presentation/screen/widget/container_card.dart';
import '../../../manpower/manpower.dart';

class ManpowerBookingScreen extends ConsumerStatefulWidget {
  const ManpowerBookingScreen({super.key});

  @override
  ConsumerState<ManpowerBookingScreen> createState() =>
      _ManpowerBookingScreenConsumerState();
}

class _ManpowerBookingScreenConsumerState
    extends ConsumerState<ManpowerBookingScreen> {
  TextEditingController couponController = TextEditingController();
  Coupon coupon = Coupon();

  // double totalAmount = 0;
  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    initialResponse();
    // initialCouponCode();
  }

  // initialCouponCode() {
  //   final id = SharedPrefs.instance.getInt(AppKeys.userId);
  //
  //   ref
  //       .read(budgetProvider.notifier)
  //       .couponCodeChecker(CouponCodeCheckerEntities(
  //           customerId: id.toString(), couponCode: couponController.text))
  //       .then((res) => {
  //             res.fold((l) => {}, (r) {
  //               setState(() => coupon = r);
  //             }),
  //           });
  // }

  void initialResponse() async {
    final coupon = ref.read(manpowerNotifierProvider).coupon;
    couponController = TextEditingController(text: coupon ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final date = ref.watch(manpowerNotifierProvider).date;
    final time = ref.watch(manpowerNotifierProvider).time;

    final location = ref.watch(manpowerNotifierProvider).location;

    final locationGeometry =
        ref.watch(manpowerNotifierProvider).locationGeometry;

    final manpowerCount = ref.watch(manpowerNotifierProvider).manPower ?? 0;
    final hoursCount = ref.watch(manpowerNotifierProvider).serviceHour ?? 0;
    final couponPackage = ref.watch(manpowerNotifierProvider).couponPackage;
    final manpowerPackage = ref.watch(manpowerNotifierProvider).manpowerPackage;
    final serviceHour = ref.watch(manpowerNotifierProvider).serviceHour;
    final manpowerPackageModel =
        ref.watch(manpowerNotifierProvider).manpowerPackageModel;

    final defaultAmount = manpowerPackageModel?.defaultManpowerAmount ?? 0;

    bool isSelect = ref.watch(manpowerNotifierProvider).isSelectDay ?? false;

    double amount = isSelect
        ? Calculator.serviceFullDayAmount(manpowerPackage) + defaultAmount
        : Calculator.serviceHourAmount(serviceHour, manpowerPackage) +
            defaultAmount;

    double totalAmount = amount;
    double discount = 0;

    if (couponPackage != null) {
      if (couponPackage.ruleType.toString() == '1') {
        setState(() {
          discount = double.parse(couponPackage.rule.toString());
          totalAmount = totalAmount - discount;
          log(totalAmount.toString());
        });
      } else if (couponPackage.ruleType.toString() == '2') {
        setState(() {
          discount =
              (amount * double.parse(couponPackage.rule.toString())) / 100;
          totalAmount = totalAmount - discount;
          log(totalAmount.toString());
        });
      }
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // location == null || date == null || time == null
            //     ? SizedBox()
            //     : Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Text(
            //             'Job Location',
            //             style: textTheme.titleLarge
            //                 ?.copyWith(color: const Color(0xFF444550)),
            //           ),
            //           Text(
            //             '${DateFormat('yyyy-MM-dd').format(date)} ${time.format(context)}',
            //             style: textTheme.titleSmall
            //                 ?.copyWith(color: context.colorScheme.primary),
            //           ),
            //         ],
            //       ),
            Dimensions.kVerticalSpaceSmall,
            Text('Manpower Service',
                style: textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.w500)),
            Dimensions.kVerticalSpaceSmaller,
            location == null
                ? const SizedBox()
                : CardContainer(
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
                                      isLast: true,
                                      isPass: false,
                                      pickupOrDropIcon: AppIcon.pickupLocation,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Pickup Address',
                                          style: context.textTheme.labelMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w900),
                                          children: [
                                            const TextSpan(text: '\n'),
                                            TextSpan(
                                              text: location,
                                              style:
                                                  context.textTheme.labelMedium,
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              )),
                            ])),
                    isTrue: true,
                  ),
            Dimensions.kVerticalSpaceSmaller,
            locationGeometry == null
                ? const SizedBox()
                : SizedBox(
                    height: 250.h,
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: locationGeometry, zoom: 12),
                      zoomControlsEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: {
                        Marker(
                          markerId: const MarkerId('origin'),
                          infoWindow: const InfoWindow(title: 'Origin'),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed),
                          position: locationGeometry,
                        ),
                      },
                      onMapCreated: (GoogleMapController controller) =>
                          _controller = controller,
                    ),
                  ),
            Dimensions.kVerticalSpaceSmaller,
            CardContainer(
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
                      amount == 0
                          ? const SizedBox()
                          : isSelect
                              ? ManpowerPriceCardList(
                                  label:
                                      'Manpower (members-$manpowerCount, Full Day- 09:00 am to 05:00 pm)',
                                  amount: amount,
                                )
                              : ManpowerPriceCardList(
                                  label:
                                      'Manpower (members-$manpowerCount, Hrs-$serviceHour)',
                                  amount: amount,
                                ),
                      // amount == 0
                      //     ? const SizedBox()
                      //     : ManpowerPriceCardList(
                      //         label: 'Add On',
                      //         amount: defaultAmount.toDouble(),
                      //       ),
                      totalAmount == 0 || discount == 0
                          ? const SizedBox()
                          : ManpowerPriceCardList(
                              label: 'Discount',
                              amount: discount,
                            ),
                    ],
                  ),
                ),
                bottomChild: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        totalAmount == 0 ? "$amount MYR" : "$totalAmount MYR",
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                isTrue: false),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: Dimensions.kPaddingAllMedium,
            //   decoration: const BoxDecoration(
            //     color: Colors.white,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Price',
            //         style: textTheme.titleLarge
            //             ?.copyWith(color: const Color(0xFF444550)),
            //       ),
            //       Dimensions.kVerticalSpaceSmaller,
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'Description',
            //                 style: textTheme.titleMedium
            //                     ?.copyWith(color: context.colorScheme.primary),
            //               ),
            //             ],
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'MYR',
            //                 style: textTheme.titleSmall
            //                     ?.copyWith(color: context.colorScheme.primary),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //       Dimensions.kVerticalSpaceSmaller,
            //       amount == 0
            //           ? const SizedBox()
            //           : isSelect
            //               ? ManpowerPriceCardList(
            //                   label:
            //                       'Manpower (members-$manpowerCount, Full Day- 09:00 am to 05:00 pm)',
            //                   amount: amount,
            //                 )
            //               : ManpowerPriceCardList(
            //                   label:
            //                       'Manpower (members-$manpowerCount, Hrs-$serviceHour)',
            //                   amount: amount,
            //                 ),
            //       totalAmount == 0
            //           ? const SizedBox()
            //           : ManpowerPriceCardList(
            //               label: 'Discount',
            //               amount: discount,
            //             ),
            //       Dimensions.kVerticalSpaceSmallest,
            //       const Divider(),
            //       Dimensions.kVerticalSpaceSmallest,
            //       ManpowerPriceCardList(
            //         label: 'Total Amount',
            //         amount: totalAmount == 0 ? amount : totalAmount,
            //       ),
            //     ],
            //   ),
            // ),

            Dimensions.kVerticalSpaceSmaller,
            SizedBox(
              height: 60.h,
              child: TextFormField(
                controller: couponController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                style: textTheme.bodySmall,
                onChanged: (code) {
                  ref.read(manpowerNotifierProvider).setCoupon(code);
                },
                decoration: InputDecoration(
                  suffix: TextButton(
                    child: const Text('Apply'),
                    onPressed: () {
                      final id = SharedPrefs.instance.getInt(AppKeys.userId);
                      ref
                          .read(budgetProvider.notifier)
                          .couponCodeChecker(CouponCodeCheckerEntities(
                              customerId: id.toString(),
                              couponCode: couponController.text,
                              totalAmount: amount))
                          .then((res) => {
                                res.fold(
                                    (l) => {
                                          AppAlerts.displaySnackBar(
                                              context, l.message, false),
                                          log(l.message),
                                        },
                                    (r) => {
                                          AppAlerts.displaySnackBar(context,
                                              'Coupon Code Valid', true),
                                          ref
                                              .read(manpowerNotifierProvider)
                                              .setCouponPackage(r)
                                        })
                              });
                    },
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x80000000))),
                  border: const OutlineInputBorder(),
                  contentPadding: Dimensions.kPaddingAllMedium,
                  labelText: 'Coupon Code',
                  hintText: '',
                  labelStyle: textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ManpowerPriceCardList extends StatelessWidget {
  final String label;
  final double amount;

  const ManpowerPriceCardList(
      {super.key, required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            label,
            style:
                textTheme.titleMedium?.copyWith(color: const Color(0xFF444550)),
          ),
        ),
        Dimensions.kHorizontalSpaceMedium,
        Text(
          "$amount MYR",
          style: textTheme.titleSmall?.copyWith(color: const Color(0xFF444550)),
        ),
      ],
    );
  }
}
