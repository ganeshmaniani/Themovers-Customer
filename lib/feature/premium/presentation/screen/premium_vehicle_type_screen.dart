import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

class PremiumVehicleTypeScreen extends ConsumerStatefulWidget {
  const PremiumVehicleTypeScreen({super.key});

  @override
  ConsumerState<PremiumVehicleTypeScreen> createState() =>
      _PremiumVehicleTypeScreenConsumerState();
}

class _PremiumVehicleTypeScreenConsumerState
    extends ConsumerState<PremiumVehicleTypeScreen> {
  bool isVehicleLoading = false;
  bool isBudgetLoading = false;
  List<VehicleTypesList> vehicleTypesList = [];
  List<PremiumPackage> premiumPackage = [];
  int selectedIndex = 0;
  List<Map<String, dynamic>> service = [
    {"label": "1 Tonne", "icon": AppIcon.oneTonne},
    {"label": "2 Tonne", "icon": AppIcon.threeTonne},
    {"label": "3 Tonne", "icon": AppIcon.fiveTonne},
    // {"label": "4 x 4", "icon": AppIcon.fourNotFour},
  ];

  String getImage(index) {
    switch (index) {
      case 1:
        return AppIcon.oneTonne;
      case 2:
        return AppIcon.threeTonne;
      case 3:
        return AppIcon.fiveTonne;
    }
    return AppIcon.fiveTonne;
  }

  @override
  void initState() {
    super.initState();
    initialGetVehicleType();
  }

  Future<void> initialGetVehicleType() async {
    setState(() => {isVehicleLoading = true, isBudgetLoading = true});
    ref.read(budgetProvider.notifier).getVehicleType().then((res) => res.fold(
        (l) => {
              setState(() => {vehicleTypesList = [], isVehicleLoading = false})
            },
        (r) => {
              setState(() => {
                    vehicleTypesList = r.vehicleTypesList ?? [],
                    isVehicleLoading = false
                  })
            }));

    ref.read(premiumProvider.notifier).getPremiumPackage().then((res) =>
        res.fold(
            (l) =>
                setState(() => {premiumPackage = [], isBudgetLoading = false}),
            (r) => setState(() => {
                  premiumPackage = r.premiumPackage ?? [],
                  isBudgetLoading = false
                })));
  }

  int calcRanks(ranks) {
    double multiplier = .5;
    return (multiplier * ranks).round();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    selectedIndex =
        ref.watch(premiumNotifierProvider).selectVehicleType ?? selectedIndex;
    return isBudgetLoading || isVehicleLoading
        ? const Center(child: SpinKitHourGlass(color: Colors.red))
        : SingleChildScrollView(
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
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xFFB40205),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: Text('Select Vehicle',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ))),
                Container(
                  padding: Dimensions.kPaddingAllSmall,
                  width: MediaQuery.of(context).size.width,
                  height: 366,
                  color: const Color(0xFFF0F0F0),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 148,
                                  mainAxisSpacing: 16,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: premiumPackage.length,
                          itemBuilder: (_, index) {
                            final services = service[index];
                            final image = getImage(index + 1);
                            final label = premiumPackage[index].tonne;
                            final vehicleType = vehicleTypesList[index];
                            final res = index + 1;
                            return InkWell(
                              onTap: () => {
                                setState(() => selectedIndex = res),
                                ref
                                    .read(premiumNotifierProvider)
                                    .setVehicleType(vehicleType.id!),
                                ref
                                    .read(premiumNotifierProvider)
                                    .setVehicleSpecification(
                                        vehicleType.specification!),
                                ref
                                    .read(premiumNotifierProvider)
                                    .setPremiumPackage(premiumPackage[index]),
                                showVehicleDetailAlertModel(
                                  title: label.toString(),
                                  children: selectVehicleDescription(index),
                                ),
                              },
                              borderRadius: Dimensions.kBorderRadiusAllSmaller,
                              child: Container(
                                width: 150,
                                height: 150,
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 13,
                                  right: 12,
                                  bottom: 10,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: selectedIndex == res
                                            ? const Color(0xFFB40205)
                                            : Colors.white),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Image.asset(image,
                                          width: 122, height: 104),
                                      const SizedBox(height: 4),
                                      Text(
                                        label ?? '',
                                        style: TextStyle(
                                            color: selectedIndex == res
                                                ? const Color(0xFFB40205)
                                                : const Color(0xFF000000),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                selectedIndex == 4 || selectedIndex == 0
                    ? const SizedBox()
                    : Container(
                        padding: Dimensions.kPaddingAllSmall,
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: const Color(0xFFF0F0F0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  customTextCard(
                                      label: selectedIndex == 1
                                          ? '1 Tonne Lorry 10 Feet'
                                          : selectedIndex == 2
                                              ? '3 Tonne Lorry 14 Feet'
                                              : selectedIndex == 3
                                                  ? '5 Tonne Lorry 17 Feet'
                                                  : ''),
                                  customTextCard(
                                      label: selectedIndex == 1
                                          ? "Max cargo Size:10'x5'x5'"
                                          : selectedIndex == 2
                                              ? "Max cargo Size:14'x7'x7'"
                                              : selectedIndex == 3
                                                  ? "Max cargo Size:17'x7.2'x7'"
                                                  : ''),
                                  customTextCard(
                                      label: selectedIndex == 1
                                          ? "Max weight:1,000 kgs."
                                          : selectedIndex == 2
                                              ? "Max weight:3,000 kgs."
                                              : selectedIndex == 3
                                                  ? "Max weight:5,000 kgs."
                                                  : ''),
                                  customTextCard(
                                      label: selectedIndex == 1
                                          ? "Suitable for Room or Apartment moves"
                                          : selectedIndex == 2
                                              ? "Suitable for heavy load house or office moves"
                                              : selectedIndex == 3
                                                  ? "Suitable for heavy load house or office moves"
                                                  : ''),
                                  const SizedBox(height: 8)
                                ],
                              ),
                            ),
                            Image.asset(AppIcon.commonVehicle,
                                width: 97, height: 49),
                          ],
                        ),
                      ),
              ],
            ),
          );
  }

  customTextCard({required String label}) {
    final textTheme = context.textTheme;
    return Row(
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            borderRadius: Dimensions.kBorderRadiusAllSmall,
          ),
        ),
        Dimensions.kHorizontalSpaceSmall,
        Expanded(
          child: Text(
            label,
            style: textTheme.bodySmall?.copyWith(
                color: const Color(0xFF000000),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  void showVehicleDetailAlertModel({
    required String title,
    required List<Widget> children,
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog.adaptive(
            actionsAlignment: MainAxisAlignment.center,
            title: Text(title, textAlign: TextAlign.center),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: children),
            actions: [
              Button(
                onTap: () => Navigator.pop(context),
                width: 80.w,
                height: 38.h,
                child: Text(
                  'OK',
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: Colors.white, letterSpacing: .2),
                ),
              ),
            ],
          );
        });
  }

  List<Widget> oneTonneDescription() {
    return [
      const Text('1 Tonne Lorry 10 Feet - Limited To One Trip ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      SizedBox(height: 10.h),
      customText("Max Cargo Size 10’x5’x5’ "),
      customText('3 Skilled Movers'),
      SizedBox(height: 2.h),
      customText('Free Shrink & Bubble Wrap '),
      SizedBox(height: 2.h),
      customText('Furniture Assembly And Disassembly'),
      SizedBox(height: 2.h),
      customText('Free 10 Boxes - [610 x 458 x 458] MM '),
      SizedBox(height: 2.h),
      customText('Customized Packing Materials'),
      SizedBox(height: 2.h),
      customText('Dedicated Moving Coordinator'),
      SizedBox(height: 2.h),
      customText('Customized Moving Plans'),
    ];
  }

  List<Widget> threeTonneDescription() {
    return [
      const Text('3 Tonne Lorry 14 Feet - Limited To One Trip',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      SizedBox(height: 10.h),
      customText('Max Cargo Size 14’x7’x7’'),
      SizedBox(height: 2.h),
      customText('3 - 4 Skilled Movers'),
      SizedBox(height: 2.h),
      customText('Free Shrink & Bubble Wrap'),
      SizedBox(height: 2.h),
      customText('Furniture Assembly And Disassembly'),
      SizedBox(height: 2.h),
      customText('Free 20 Boxes - [610 x 458 x 458] MM '),
      SizedBox(height: 2.h),
      customText('Customized Packing Materials'),
      SizedBox(height: 2.h),
      customText('Dedicated Moving Coordinator'),
      SizedBox(height: 2.h),
      customText('Customized Moving Plans'),
    ];
  }

  List<Widget> fiveTonneDescription() {
    return [
      const Text('5 Tonne Lorry 17 Feet - Limited To One Trip ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      SizedBox(height: 10.h),
      customText('Max Cargo Size 17’x7.2’x7’'),
      SizedBox(height: 2.h),
      customText('3 - 4 Skilled Movers'),
      SizedBox(height: 2.h),
      customText('Free Shrink & Bubble Wrap '),
      SizedBox(height: 2.h),
      customText('Furniture Assembly And Disassembly'),
      SizedBox(height: 2.h),
      customText('Free 20 Boxes - [610 x 458 x 458] MM'),
      SizedBox(height: 2.h),
      customText('Customized Packing Materials'),
      SizedBox(height: 2.h),
      customText('Dedicated Moving Coordinator'),
      SizedBox(height: 2.h),
      customText('Customized Moving Plans'),
    ];
  }

  Widget customText(String text) {
    final textTheme = context.textTheme;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(AppIcon.redCheckBox, height: 20, width: 20),
          Expanded(child: Text(text, style: textTheme.labelMedium)),
        ]);
  }

  String selectVehicleTypeImage(int i) {
    final res = i + 1;
    if (res == 1) {
      return AppIcon.vehicleOneTonne;
    }
    if (res == 2) {
      return AppIcon.vehicleThreeTonne;
    }
    if (res == 3) {
      return AppIcon.vehicleFiveTonne;
    }
    return AppIcon.vehicleOneTonne;
  }

  List<Widget> selectVehicleDescription(int i) {
    final res = i + 1;
    if (res == 1) {
      return oneTonneDescription();
    }
    if (res == 2) {
      return threeTonneDescription();
    }
    if (res == 3) {
      return fiveTonneDescription();
    }
    return oneTonneDescription();
  }
}
