import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themovers/feature/budget/data/model/coupon_code_model.dart';
import 'package:themovers/feature/budget/domain/entities/coupon_code_checker_entities.dart';
import 'package:themovers/feature/budget/presentation/screen/widget/address_card_container.dart';
import 'package:themovers/feature/budget/presentation/screen/widget/container_card.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../budget/budget.dart';

class BudgetBuyNowScreen extends ConsumerStatefulWidget {
  const BudgetBuyNowScreen({super.key});

  @override
  ConsumerState<BudgetBuyNowScreen> createState() =>
      _BudgetBuyNowScreenConsumerState();
}

class _BudgetBuyNowScreenConsumerState
    extends ConsumerState<BudgetBuyNowScreen> {
  TextEditingController couponController = TextEditingController();
  Coupon coupon = Coupon();
  late var isEnable = false;

  @override
  void initState() {
    super.initState();
    // initialResponse();
    // initialCouponCode();
  }

  //
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

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    couponController.dispose();
    super.dispose();
  }

  void remove() {
    setState(() {
      if (isEnable == true) {
        isEnable = false;
      }
      if (isEnable == false) {
        isEnable = true;
      }
    });
  }

  void resetDiscount() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final date = ref.watch(budgetControllerProvider).date;
    final time = ref.watch(budgetControllerProvider).time;

    final pickupAddress = ref.watch(budgetControllerProvider).pickupAddress;
    final dropOffAddress = ref.watch(budgetControllerProvider).dropOffAddress;

    final vehicleSpecification =
        ref.watch(budgetControllerProvider).vehicleSpecification;

    final budgetPackage = ref.watch(budgetControllerProvider).budgetPackage;
    final longPushType = ref.watch(budgetControllerProvider).longPushType ?? [];
    final couponPackage = ref.watch(budgetControllerProvider).couponPackage;

    int distance = ref.watch(budgetControllerProvider).distance ?? 0;

    int manPower = ref.watch(budgetControllerProvider).manPowerCount ?? 0;
    int boxCount = ref.watch(budgetControllerProvider).boxCount ?? 0;

    int shrinkWrap = ref.watch(budgetControllerProvider).shrinkWrap ?? 0;
    int bubbleWrap = ref.watch(budgetControllerProvider).bubbleWrap ?? 0;

    int diningTable = ref.watch(budgetControllerProvider).diningTable ?? 0;
    int bed = ref.watch(budgetControllerProvider).bed ?? 0;
    int officeTable = ref.watch(budgetControllerProvider).officeTable ?? 0;
    int wardrobe = ref.watch(budgetControllerProvider).wardrobe ?? 0;

    bool insurance = ref.watch(budgetControllerProvider).insurance ?? false;
    int stairCarry = ref.watch(budgetControllerProvider).stairCarry ?? 0;
    bool tailGate = ref.watch(budgetControllerProvider).tailGate ?? false;

    int longPush = ref.watch(budgetControllerProvider).longPush ?? 0;

    double distanceWithAmount =
        Calculator.distanceAmount(distance, budgetPackage);
    double manPowerAmount = Calculator.manpowerAmount(manPower, budgetPackage);
    double boxAmount = Calculator.boxAmount(boxCount, budgetPackage);
    double shrinkWrapAmount =
        Calculator.shrinkWrapAmount(shrinkWrap, budgetPackage);
    double bubbleWrapAmount =
        Calculator.bubbleWrapAmount(bubbleWrap, budgetPackage);

    double diningTableAmount =
        Calculator.diningTableAmount(diningTable, budgetPackage);
    double bedAmount = Calculator.bedAmount(bed, budgetPackage);
    double officeTableAmount =
        Calculator.officeTableAmount(officeTable, budgetPackage);
    double wardrobeAmount = Calculator.wardrobeAmount(wardrobe, budgetPackage);

    double insuranceAmount =
        Calculator.insuranceAmount(insurance, budgetPackage);
    double stairCarryAmount =
        Calculator.stairCarryAmount(stairCarry, budgetPackage);
    double tailGateAmount = Calculator.tailGateAmount(tailGate, budgetPackage);

    double longPushAmount = Calculator.longPushAmount(longPush, longPushType);

    List amountList = [
      Calculator.distanceAmount(distance, budgetPackage),
      Calculator.manpowerAmount(manPower, budgetPackage),
      Calculator.boxAmount(boxCount, budgetPackage),
      Calculator.shrinkWrapAmount(shrinkWrap, budgetPackage),
      Calculator.bubbleWrapAmount(bubbleWrap, budgetPackage),
      Calculator.diningTableAmount(diningTable, budgetPackage),
      Calculator.bedAmount(bed, budgetPackage),
      Calculator.officeTableAmount(officeTable, budgetPackage),
      Calculator.wardrobeAmount(wardrobe, budgetPackage),
      Calculator.insuranceAmount(insurance, budgetPackage),
      Calculator.stairCarryAmount(stairCarry, budgetPackage),
      Calculator.tailGateAmount(tailGate, budgetPackage),
      Calculator.longPushAmount(longPush, longPushType)
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
        padding: Dimensions.kPaddingAllMedium,
        // height: context.deviceSize.height,
        width: context.deviceSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budget Booking',
              style: textTheme.headlineMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            Dimensions.kVerticalSpaceSmall,
            addressDetailCardUI(),
            Dimensions.kVerticalSpaceSmall,
            CardContainer(
                topChild: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: context.textTheme.headlineSmall,
                      ),
                      Dimensions.kVerticalSpaceSmaller,
                      distanceWithAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Lorry $vehicleSpecification',
                              amount: distanceWithAmount,
                            ),
                      manPowerAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Man Power',
                              amount: manPowerAmount,
                            ),
                      boxAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Boxes',
                              amount: boxAmount,
                            ),
                      shrinkWrapAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Shrink Wrapping',
                              amount: shrinkWrapAmount,
                            ),
                      bubbleWrapAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Bubble Wrapping',
                              amount: bubbleWrapAmount,
                            ),
                      diningTableAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Dining Table',
                              amount: diningTableAmount,
                            ),
                      officeTableAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Office Table',
                              amount: officeTableAmount,
                            ),
                      bedAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Bed',
                              amount: bedAmount,
                            ),
                      wardrobeAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Wardrobe',
                              amount: wardrobeAmount,
                            ),
                      insuranceAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Insurance',
                              amount: insuranceAmount,
                            ),
                      stairCarryAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Stair Carry',
                              amount: stairCarryAmount,
                            ),
                      tailGateAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Tail Gate',
                              amount: tailGateAmount,
                            ),
                      longPushAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Long Push',
                              amount: longPushAmount,
                            ),
                      totalAmount == 0
                          ? const SizedBox()
                          : PriceCardList(
                              label: 'Discount',
                              amount: discount,
                            ),
                      // Dimensions.kVerticalSpaceSmallest,
                    ],
                  ),
                ),
                bottomChild: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
                            ? "${calculationAmount.toStringAsFixed(2)} MYR"
                            : "${totalAmount.toStringAsFixed(2)} MYR",
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
                // enabled: isEnable ? false : true,
                controller: couponController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                style: textTheme.bodySmall,
                onChanged: (code) {
                  ref.read(budgetControllerProvider).setCoupon(code);
                },
                decoration: InputDecoration(
                  // suffixIcon: Icon(
                  //   Icons.search,
                  //   color: context.colorScheme.primary,
                  // ),
                  suffix: isEnable
                      ? TextButton(
                          onPressed: () {
                            couponController.clear();
                          },
                          child: const Text('Remove'))
                      : TextButton(
                          child: const Text('Apply'),
                          onPressed: () {
                            setState(() {
                              isEnable = true;
                            });
                            final id =
                                SharedPrefs.instance.getInt(AppKeys.userId);

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
                                                log('j'),
                                              },
                                          (r) => {
                                                AppAlerts.displaySnackBar(
                                                    context,
                                                    'Coupon Code Valid',
                                                    true),
                                                ref
                                                    .read(
                                                        budgetControllerProvider)
                                                    .setCouponPackage(r),
                                                remove()
                                              })
                                    });
                          },
                        ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x80000000))),
                  border: const OutlineInputBorder(),
                  contentPadding: Dimensions.kPaddingAllMedium,
                  labelText: 'Enter Coupon Code',
                  labelStyle: textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 200)
          ],
        ),
      ),
    );
  }

  Widget addressDetailCardUI() {
    final pickupAddress = ref.watch(budgetControllerProvider).pickupAddress;
    final dropOffAddress = ref.watch(budgetControllerProvider).dropOffAddress;
    final distance = ref.watch(budgetControllerProvider).distance;
    final duration = ref.watch(budgetControllerProvider).duration ?? '';

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
    );
  }
}

class PriceCardList extends StatelessWidget {
  final String label;
  final double amount;

  const PriceCardList({super.key, required this.label, required this.amount});

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
          "${amount.toStringAsFixed(2)}MYR",
          style: textTheme.titleSmall?.copyWith(color: const Color(0xFF444550)),
        ),
      ],
    );
  }
}
