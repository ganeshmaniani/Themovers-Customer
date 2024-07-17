import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../budget/budget.dart';

class BudgetVehicleStep extends ConsumerStatefulWidget {
  const BudgetVehicleStep({super.key});

  @override
  ConsumerState<BudgetVehicleStep> createState() =>
      _BudgetVehicleStepConsumerState();
}

class _BudgetVehicleStepConsumerState extends ConsumerState<BudgetVehicleStep> {
  bool isVehicleLoading = false;
  bool isBudgetLoading = false;
  List<VehicleTypesList> vehicleTypesList = [];
  List<BudgetPackage> budgetPackage = [];
  int selectedIndex = 0;
  int selectServiceText = 0;
  List<Map<String, dynamic>> service = [
    {"icon": AppIcon.oneTonne},
    {"icon": AppIcon.threeTonne},
    {"icon": AppIcon.fiveTonne},
    {"icon": AppIcon.fourNotFour},
    {"icon": AppIcon.oneTonne},
    {"icon": AppIcon.threeTonne},
    {"icon": AppIcon.fiveTonne},
    {"icon": AppIcon.fourNotFour},
  ];

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

    ref
        .read(budgetProvider.notifier)
        .getBudgetMovingDetail()
        .then((res) => res.fold(
            (l) => {
                  setState(() => {budgetPackage = [], isBudgetLoading = false})
                },
            (r) => {
                  setState(() => {
                        budgetPackage = r.budgetPackage ?? [],
                        isBudgetLoading = false
                      })
                }));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    selectedIndex =
        ref.watch(budgetControllerProvider).selectVehicleType ?? selectedIndex;
    return isVehicleLoading || isBudgetLoading
        ? const Center(child: SpinKitHourGlass(color: Colors.red))
        : SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              // height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: Dimensions.kPaddingAllMedium,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Budget Booking',
                          style: textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Dimensions.kVerticalSpaceSmall,
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
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
                          height: 680,
                          color: const Color(0xFFF0F0F0),
                          child: Column(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 16,
                                          mainAxisExtent: 150,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 16),
                                  itemCount: budgetPackage.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    log("Vehicle ${vehicleTypesList.length.toString()}");
                                    log("Budget ${budgetPackage.length.toString()}");
                                    final services = service[index];
                                    final image = services['icon'].toString();
                                    final label = services['label'].toString();
                                    final vehicleType = vehicleTypesList[index];
                                    final budget = budgetPackage[index];
                                    final res = index + 1;
                                    String? inputString = budget.tonne;
                                    List<String> parts =
                                        inputString!.split('  ');
                                    String formattedString = parts.join('\n');
                                    return InkWell(
                                      onTap: () => {
                                        setState(() => selectedIndex = res),
                                        debugPrint(budget.basePrice!),
                                        ref
                                            .read(budgetControllerProvider)
                                            .setVehicleType(vehicleType.id!),
                                        ref
                                            .read(budgetControllerProvider)
                                            .setVehicleSpecification(
                                                vehicleType.specification!),
                                        ref
                                            .read(budgetControllerProvider)
                                            .setBudgetMoving(
                                                budgetPackage[index]),
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 160,
                                        padding: const EdgeInsets.only(
                                          top: 2,
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Image.asset(image,
                                                  width: 122.65, height: 104),
                                              const SizedBox(height: 4),
                                              Text(
                                                formattedString ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: selectedIndex == res
                                                        ? const Color(
                                                            0xFFB40205)
                                                        : const Color(
                                                            0xFF000000),
                                                    fontSize: 10.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                        selectedIndex == 4 ||
                                selectedIndex == 0 ||
                                selectedIndex == 8
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
                                                          : selectedIndex == 5
                                                              ? '1 Tonne Lorry 10 Feet'
                                                              : selectedIndex ==
                                                                      6
                                                                  ? '3 Tonne Lorry 14 Feet'
                                                                  : selectedIndex ==
                                                                          7
                                                                      ? '5 Tonne Lorry 17 Feet'
                                                                      : ''),
                                          customTextCard(
                                              label: selectedIndex == 1
                                                  ? "Max cargo Size:10'x5'x5'"
                                                  : selectedIndex == 2
                                                      ? "Max cargo Size:14'x7'x7'"
                                                      : selectedIndex == 3
                                                          ? "Max cargo Size:17'x7.2'x7'"
                                                          : selectedIndex == 5
                                                              ? "Max cargo Size:10'x5'x5'"
                                                              : selectedIndex ==
                                                                      6
                                                                  ? "Max cargo Size:14'x7'x7'"
                                                                  : selectedIndex ==
                                                                          7
                                                                      ? "Max cargo Size:17'x7.2'x7'"
                                                                      : ''),
                                          customTextCard(
                                              label: selectedIndex == 1
                                                  ? "Max weight:1,000 kgs."
                                                  : selectedIndex == 2
                                                      ? "Max weight:3,000 kgs."
                                                      : selectedIndex == 3
                                                          ? "Max weight:5,000 kgs."
                                                          : selectedIndex == 5
                                                              ? "Max weight:1,000 kgs."
                                                              : selectedIndex ==
                                                                      6
                                                                  ? "Max weight:3,000 kgs."
                                                                  : selectedIndex ==
                                                                          7
                                                                      ? "Max weight:5,000 kgs."
                                                                      : ''),
                                          customTextCard(
                                              label: selectedIndex == 1
                                                  ? "Suitable for Room or Apartment moves"
                                                  : selectedIndex == 2
                                                      ? "Suitable for heavy load house or office moves"
                                                      : selectedIndex == 3
                                                          ? "Suitable for heavy load house or office moves"
                                                          : selectedIndex == 5
                                                              ? "Suitable for Room or Apartment moves"
                                                              : selectedIndex ==
                                                                      6
                                                                  ? "Suitable for heavy load house or office moves"
                                                                  : selectedIndex ==
                                                                          7
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
                        const SizedBox(height: 50)
                      ],
                    ),
                  ),
                ],
              ),
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
        Dimensions.kHorizontalSpaceSmaller,
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
    if (res == 4) {
      return AppIcon.vehicleFourXFourTonne;
    }
    return AppIcon.vehicleOneTonne;
  }
}
