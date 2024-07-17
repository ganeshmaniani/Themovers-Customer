import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../disposal/disposal.dart';

class DisposalVehicle {
  String icon;
  String label;
  int amount;

  DisposalVehicle(
      {required this.icon, required this.label, required this.amount});
}

class DisposalVehicleTypeScreen extends ConsumerStatefulWidget {
  const DisposalVehicleTypeScreen({super.key});

  @override
  ConsumerState<DisposalVehicleTypeScreen> createState() =>
      _DisposalVehicleTypeScreenConsumerState();
}

class _DisposalVehicleTypeScreenConsumerState
    extends ConsumerState<DisposalVehicleTypeScreen> {
  bool isDisposalLoading = false;
  List<DisposalPackage> disposalPackage = [];

  List<DisposalVehicle> vehicleList = [
    DisposalVehicle(
      icon: AppIcon.oneTonne,
      label: '1 Tonne Lorry\n2 Manpower',
      amount: 500,
    ),
    DisposalVehicle(
      icon: AppIcon.threeTonne,
      label: '3 Tonne Lorry\n3 Manpower',
      amount: 700,
    ),
    DisposalVehicle(
      icon: AppIcon.fiveTonne,
      label: '5 Tonne Lorry\n3 Manpower',
      amount: 1000,
    ),
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
    initialDisposalPackageDetail();
  }

  void initialDisposalPackageDetail() async {
    setState(() => isDisposalLoading = true);
    ref
        .read(disposalProvider.notifier)
        .getDisposalPackageDetail()
        .then((res) => res.fold(
            (l) => {
                  setState(
                      () => {disposalPackage = [], isDisposalLoading = false})
                },
            (r) => {
                  setState(() => {
                        disposalPackage = r.disposalPackage ?? [],
                        isDisposalLoading = false
                      })
                }));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    int selectedIndex =
        ref.watch(disposalNotifierProvider).selectVehicleType ?? 0;
    return isDisposalLoading
        ? const Center(child: SpinKitHourGlass(color: Colors.red))
        : SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: Dimensions.kPaddingAllMedium,
            child: SizedBox(
              height: MediaQuery.of(context).size.height.h / 1.1.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Disposal Service',
                    style: textTheme.headlineMedium!
                        .copyWith(fontWeight: FontWeight.w400),
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
                    height: 461,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFF0F0F0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                    ),
                    child: Column(
                      children: [
                        Dimensions.kVerticalSpaceSmaller,
                        Text(
                          'Price includes transport, manpower and disposal fee. we reserved the right to not accept wet waste or oil-based products.',
                          style: textTheme.labelLarge
                              ?.copyWith(color: const Color(0xFF000000)),
                        ),
                        Dimensions.kVerticalSpaceMedium,
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 16,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16),
                              itemCount: disposalPackage.length,
                              itemBuilder: (_, i) {
                                final vehicle = disposalPackage[i];
                                final res = i + 1;
                                return InkWell(
                                  onTap: () => {
                                    setState(() => selectedIndex = res),
                                    ref
                                        .read(disposalNotifierProvider)
                                        .setVehicleType(res),
                                    ref
                                        .read(disposalNotifierProvider)
                                        .setVehicleSpecification(vehicle.tonne),
                                    ref
                                        .read(disposalNotifierProvider)
                                        .setDisposalPackage(disposalPackage[i]),
                                  },
                                  borderRadius:
                                      Dimensions.kBorderRadiusAllSmaller,
                                  child: Container(
                                    // width: 82,
                                    padding: Dimensions.kPaddingAllSmaller,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          Dimensions.kBorderRadiusAllSmaller,
                                      // color: selectedIndex == res
                                      //     ? Colors.white
                                      //     : Colors.transparent,
                                      color: Colors.white,

                                      border: Border.all(
                                        width: 1,
                                        color: selectedIndex == res
                                            ? context.colorScheme.primary
                                            : Colors.white,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Image(
                                              image:
                                                  AssetImage(getImage(i + 1))),
                                        ),
                                        Dimensions.kVerticalSpaceSmallest,
                                        Text(
                                          vehicle.tonne ?? '',
                                          textAlign: TextAlign.center,
                                          style: textTheme.labelLarge?.copyWith(
                                            fontSize: 12.sp,
                                            color: selectedIndex == res
                                                ? context.colorScheme.primary
                                                : Colors.black54,
                                          ),
                                        ),
                                        Dimensions.kVerticalSpaceSmallest,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
