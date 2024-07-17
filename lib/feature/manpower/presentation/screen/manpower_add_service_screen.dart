import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themovers/feature/budget/presentation/screen/widget/container_card.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../manpower/manpower.dart';

class ManpowerAddServiceScreen extends ConsumerStatefulWidget {
  const ManpowerAddServiceScreen({super.key});

  @override
  ConsumerState<ManpowerAddServiceScreen> createState() =>
      _ManpowerAddServiceScreenConsumerState();
}

class _ManpowerAddServiceScreenConsumerState
    extends ConsumerState<ManpowerAddServiceScreen> {
  bool isLoading = false;
  TextEditingController controller = TextEditingController(text: ' ');
  List<ManpowerPackage> manpowerPackage = [];
  int? manpowerPackageModel;

  @override
  void initState() {
    super.initState();
    initialManpower();
  }

  void initialManpower() async {
    setState(() => isLoading = true);

    String? description =
        ref.read(manpowerNotifierProvider).manPowerDescription ?? ' ';
    controller = TextEditingController(text: description);

    ref
        .read(manpowerProvider.notifier)
        .manpowerPackageDetail()
        .then((res) => res.fold(
              (l) => setState(() => {manpowerPackage = [], isLoading = false}),
              (r) => setState(() => {
                    manpowerPackageModel = r.defaultManpowerAmount,
                    manpowerPackage = r.manpowerPackage ?? [],
                    isLoading = false,
                    setManpowerPackageInitial(manpowerPackage, r),
                  }),
            ));
  }

  void setManpowerPackageInitial(
      List<ManpowerPackage> manpowerPackage, ManpowerPackageModel model) async {
    final package = ref.read(manpowerNotifierProvider).manpowerPackage;
    if (package == null && manpowerPackage.isNotEmpty) {
      ref.read(manpowerNotifierProvider).setManPowerCount(2);
      ref.read(manpowerNotifierProvider).setServiceHour(2);
      ref.read(manpowerNotifierProvider).setManpowerPackage(manpowerPackage[0]);
      ref.read(manpowerNotifierProvider).setDefaultValue(model);
    }
  }

  void setManpowerPackageStore(int index) async {
    final position = index - 2;
    ref
        .read(manpowerNotifierProvider)
        .setManpowerPackage(manpowerPackage[position]);
  }

  void sendResponse(String service, int val) async {
    switch (service) {
      case 'man_count':
        ref.read(manpowerNotifierProvider).setManPowerCount(val);
        break;
      case 'hour_count':
        ref.read(manpowerNotifierProvider).setServiceHour(val);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    int manPowerCount = ref.watch(manpowerNotifierProvider).manPower ?? 2;
    int serviceHourCount = ref.watch(manpowerNotifierProvider).serviceHour ?? 2;
    bool isSelect = ref.watch(manpowerNotifierProvider).isSelectDay ?? false;
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: Dimensions.kPaddingAllMedium,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manpower Service',
                style: textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Dimensions.kVerticalSpaceSmall,
              Row(
                children: [
                  Expanded(
                    child: CardContainer(
                      topChild: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Select Manpower',
                          style: context.textTheme.bodySmall
                              ?.copyWith(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                      bottomChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Dimensions.kVerticalSpaceSmall,
                          Image(
                            image: const AssetImage(
                              AppIcon.selectManpower,
                            ),
                            width: 90.w,
                            height: 90.h,
                          ),
                          Dimensions.kVerticalSpaceSmall,
                          CustomManpowerCounterCard(
                            count: manPowerCount.toString(),
                            increment: () => setState(
                              manPowerCount < 5
                                  ? () => {
                                        manPowerCount = manPowerCount + 1,
                                        sendResponse(
                                            'man_count', manPowerCount),
                                        setManpowerPackageStore(manPowerCount),
                                      }
                                  : () {},
                            ),
                            decrement: () => setState(
                              manPowerCount != 2
                                  ? () => {
                                        manPowerCount = manPowerCount - 1,
                                        sendResponse(
                                            'man_count', manPowerCount),
                                        setManpowerPackageStore(manPowerCount),
                                      }
                                  : () {},
                            ),
                            limited: true,
                          ),
                          Dimensions.kVerticalSpaceLarger,
                        ],
                      ),
                      isTrue: true,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: CardContainer(
                        topChild: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Duration',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodySmall?.copyWith(
                                color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                        bottomChild: Column(
                          children: [
                            Dimensions.kVerticalSpaceSmall,
                            Image(
                                image: const AssetImage(AppIcon.selectDuration),
                                width: 90.w,
                                height: 90.h),
                            Dimensions.kVerticalSpaceSmall,
                            isSelect
                                ? const SizedBox()
                                : CustomManpowerCounterCard(
                                    count: "$serviceHourCount Hrs",
                                    increment: () => setState(
                                      serviceHourCount < 5
                                          ? () => {
                                                serviceHourCount =
                                                    serviceHourCount + 1,
                                                sendResponse('hour_count',
                                                    serviceHourCount),
                                              }
                                          : () {},
                                    ),
                                    decrement: () => setState(
                                      serviceHourCount != 2
                                          ? () => {
                                                serviceHourCount =
                                                    serviceHourCount - 1,
                                                sendResponse('hour_count',
                                                    serviceHourCount),
                                              }
                                          : () {},
                                    ),
                                    limited: true,
                                  ),
                            Dimensions.kVerticalSpaceSmall,
                            GestureDetector(
                              onTap: () => setState(() => {
                                    isSelect = !isSelect,
                                    ref
                                        .read(manpowerNotifierProvider)
                                        .setIsSelectDay(isSelect)
                                  }),
                              child: Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: Dimensions
                                                .kBorderRadiusAllSmallest,
                                            border: Border.all(
                                              width: 2,
                                              color: isSelect
                                                  ? context.colorScheme.primary
                                                  : const Color(0xFF969696),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 2,
                                        right: 2,
                                        child: isSelect
                                            ? Image(
                                                image: const AssetImage(
                                                    AppIcon.checkMark),
                                                width: Dimensions.iconSizeSmall,
                                                color:
                                                    context.colorScheme.primary,
                                              )
                                            : const SizedBox(),
                                      ),
                                    ],
                                  ),
                                  // Dimensions.kHorizontalSpaceSmaller,
                                  Text(
                                    'for full day\n9:00 AM to 5:00 PM',
                                    style: textTheme.labelSmall?.copyWith(
                                        color: const Color(0xFF444550)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        isTrue: true),
                  )
                ],
              ),
              Dimensions.kVerticalSpaceSmall,
              Text(
                'Remarks(optional)',
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
              ),
              Dimensions.kVerticalSpaceSmall,
              TextFormField(
                controller: controller,
                textAlignVertical: TextAlignVertical.top,
                maxLines: 7,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                style: textTheme.bodySmall,
                onChanged: (res) {
                  ref
                      .read(manpowerNotifierProvider)
                      .setManPowerDescription(res);
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0x80000000))),
                  border: const OutlineInputBorder(),
                  hintText: 'Description',
                  contentPadding: Dimensions.kPaddingAllSmall,
                  labelStyle: textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
