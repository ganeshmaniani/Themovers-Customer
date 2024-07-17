import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themovers/feature/budget/presentation/screen/widget/container_card.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../budget/data/model/coupon_code_model.dart';
import '../../../budget/domain/entities/coupon_code_checker_entities.dart';
import '../../../budget/presentation/provider/budget_provider.dart';
import '../../../budget/presentation/screen/widget/address_card_container.dart';
import '../../../premium/premium.dart';

class PremiumBookingScreen extends ConsumerStatefulWidget {
  const PremiumBookingScreen({super.key});

  @override
  ConsumerState<PremiumBookingScreen> createState() =>
      _PremiumBookingScreenConsumerState();
}

class _PremiumBookingScreenConsumerState
    extends ConsumerState<PremiumBookingScreen> {
  TextEditingController couponController = TextEditingController();
  Coupon coupon = Coupon();

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
    final coupon = ref.read(premiumNotifierProvider).coupon;
    couponController = TextEditingController(text: coupon ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final date = ref.watch(premiumNotifierProvider).date;
    final time = ref.watch(premiumNotifierProvider).time;

    final vehicleSpecification =
        ref.watch(premiumNotifierProvider).vehicleSpecification;

    final pickupAddress = ref.watch(premiumNotifierProvider).pickupAddress;
    final dropOffAddress = ref.watch(premiumNotifierProvider).dropOffAddress;

    final budgetPackage = ref.watch(premiumNotifierProvider).premiumPackage;
    final longPushType = ref.watch(premiumNotifierProvider).longPushType ?? [];

    final distance = ref.watch(premiumNotifierProvider).distance ?? 0;
    final couponPackage = ref.watch(premiumNotifierProvider).couponPackage;

    // final manPower = ref.watch(premiumNotifierProvider).manPowerCount ?? 0;

    final stairCarry = ref.watch(premiumNotifierProvider).stairCarry ?? 0;
    final tailGate = ref.watch(premiumNotifierProvider).tailGate ?? false;

    final longPush = ref.watch(premiumNotifierProvider).longPush ?? 0;

    final amountList = [
      Calculator.premiumDistanceAmount(distance, budgetPackage),
      // Calculator.premiumManpowerAmount(manPower, budgetPackage),
      Calculator.premiumStairCarryAmount(stairCarry, budgetPackage),
      Calculator.premiumTailGateAmount(tailGate, budgetPackage),
      Calculator.premiumLongPushAmount(longPush, longPushType)
    ];

    double calculationAmount = Calculator.totalAmount(amountList);
    double totalAmount = 0;
    double discount = 0;

    if (couponPackage != null) {
      if (couponPackage.ruleType.toString() == '1') {
        setState(() {
          discount = double.parse(couponPackage.rule.toString());
          totalAmount = calculationAmount - discount;
          log(totalAmount.toString());
        });
      } else if (couponPackage.ruleType.toString() == '2') {
        setState(() {
          discount = (calculationAmount *
                  double.parse(couponPackage.rule.toString())) /
              100;
          totalAmount = calculationAmount - discount;
          log(totalAmount.toString());
        });
      }
    }

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: Dimensions.kPaddingAllMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Premium Booking',
              style: textTheme.headlineMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            Dimensions.kVerticalSpaceSmall,
            addressDetailCardUI(),
            Dimensions.kVerticalSpaceSmall,
            CardContainer(
                topChild: Padding(
                  padding: Dimensions.kPaddingAllSmall,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: context.textTheme.headlineSmall,
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      Dimensions.kVerticalSpaceSmaller,
                      amountList[0] == 0
                          ? const SizedBox()
                          : PremiumPriceCardList(
                              label: 'Lorry $vehicleSpecification',
                              amount: "${amountList[0]} MYR",
                            ),
                      amountList[1] == 0
                          ? const SizedBox()
                          : PremiumPriceCardList(
                              label: 'Stair Carry',
                              amount: "${amountList[1]} MYR",
                            ),
                      amountList[2] == 0
                          ? const SizedBox()
                          : PremiumPriceCardList(
                              label: 'Tail Gate',
                              amount: "${amountList[2]} MYR",
                            ),
                      amountList[3] == 0
                          ? const SizedBox()
                          : PremiumPriceCardList(
                              label: 'Long Push',
                              amount: "${amountList[3]} MYR",
                            ),
                      totalAmount == 0
                          ? const SizedBox()
                          : PremiumPriceCardList(
                              label: 'Discount',
                              amount: "$discount MYR",
                            ),
                      Dimensions.kVerticalSpaceSmallest,
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
                        totalAmount == 0
                            ? "$calculationAmount MYR"
                            : "$totalAmount MYR",
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                isTrue: false),
            Dimensions.kVerticalSpaceSmall,
            SizedBox(
              height: 60.h,
              child: TextFormField(
                controller: couponController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                style: textTheme.bodySmall,
                onChanged: (code) {
                  ref.read(premiumNotifierProvider).setCoupon(code);
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
                              totalAmount: calculationAmount))
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
                                              .read(premiumNotifierProvider)
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

  Widget addressDetailCardUI() {
    final pickupAddress = ref.watch(premiumNotifierProvider).pickupAddress;
    final dropOffAddress = ref.watch(premiumNotifierProvider).dropOffAddress;
    final distance = ref.watch(premiumNotifierProvider).distance ?? 0;
    final duration = ref.watch(premiumNotifierProvider).duration ?? '';
    return CardContainer(
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
                    isLast: false,
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
                            text: pickupAddress ?? '',
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    )),
                AddressCardContainer(
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
                          text: dropOffAddress ?? "",
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    )))
              ],
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: 'Distance',
                      style: context.textTheme.labelMedium,
                      children: [
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: distance.toString(),
                          style: context.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 20.sp),
                        ),
                        TextSpan(
                          text: 'Km ',
                          style: context.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 20.sp),
                        ),
                      ],
                    )),
                const SizedBox(height: 10),
                RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: 'Travel Time',
                      style: context.textTheme.labelMedium,
                      children: [
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: duration.toString(),
                          style: context.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 20.sp),
                        ),
                        TextSpan(
                          text: '',
                          style: context.textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
      isTrue: true,
    );
  }
}

class PremiumPriceCardList extends StatelessWidget {
  final String label;
  final String amount;

  const PremiumPriceCardList(
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
        Text(
          amount.toString(),
          style: textTheme.titleSmall?.copyWith(color: const Color(0xFF444550)),
        ),
      ],
    );
  }
}
