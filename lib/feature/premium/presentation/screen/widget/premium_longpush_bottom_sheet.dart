import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../dashboard/presentation/screen/widget/custom_drawer.dart';
import '../../../../premium/premium.dart';

class PremiumLongPushBottomSheet extends ConsumerStatefulWidget {
  const PremiumLongPushBottomSheet({super.key});

  @override
  ConsumerState<PremiumLongPushBottomSheet> createState() =>
      _PremiumLongPushBottomSheetConsumerState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _PremiumLongPushBottomSheetConsumerState
    extends ConsumerState<PremiumLongPushBottomSheet> {
  bool isLoading = false;
  List<PremiumLongpushType> longPushType = [];

  @override
  void initState() {
    super.initState();
    initialLongPushDetail();
  }

  void initialLongPushDetail() async {
    setState(() => isLoading = true);
    ref
        .read(premiumProvider.notifier)
        .getPremiumLongPushTypeList()
        .then((res) => res.fold(
              (l) => {
                setState(() => {longPushType = [], isLoading = false}),
              },
              (r) => {
                setState(() => {
                      longPushType = r.longpushType ?? [],
                      debugPrint(r.longpushType?.length.toString()),
                      isLoading = false
                    }),
              },
            ));
  }

  void longPushTypeList(List<PremiumLongpushType> type) async {
    ref.read(premiumNotifierProvider).setLongPushType(type);
  }

  void longPushSelectedIndex(int index) async {
    ref.read(premiumNotifierProvider).setLongPushIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    int selectedIndex = ref.watch(premiumNotifierProvider).longPush ?? 0;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.kVerticalSpaceLarge,
            appBar(),
            Padding(
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
                        const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB40205),
                    ),
                    child: Text(
                      'Long Push',
                      style:
                          textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  Text(
                      'Do any of your units have access to the loading / unloading area.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000),
                      )),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: longPushType.length,
                padding: Dimensions.kPaddingAllMedium,
                itemBuilder: (_, i) {
                  final res = i + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 74),
                    child: GestureDetector(
                      onTap: () => setState(() => {
                            if (selectedIndex == res)
                              {
                                longPushSelectedIndex(0),
                                longPushTypeList([]),
                              }
                            else
                              {
                                longPushSelectedIndex(res),
                                longPushTypeList(longPushType),
                              }
                          }),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: Dimensions.kPaddingAllSmall,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFB30205)),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          Dimensions.kBorderRadiusAllSmallest,
                                      border: Border.all(
                                        width: 2,
                                        color: selectedIndex == res
                                            ? context.colorScheme.primary
                                            : const Color(0xFF969696),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: selectedIndex == res
                                      ? Image(
                                          image: const AssetImage(
                                              AppIcon.checkMark),
                                          width: Dimensions.iconSizeMedium,
                                          color: context.colorScheme.primary,
                                        )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                            Dimensions.kHorizontalSpaceSmall,
                            Text(
                              longPushType[i].description ?? '',
                              textAlign: TextAlign.center,
                              style: textTheme.headlineMedium
                                  ?.copyWith(color: const Color(0xFF444550)),
                            ),
                            Dimensions.kVerticalSpaceSmallest,
                            Text(
                              'MYR ${longPushType[i].rate}',
                              textAlign: TextAlign.center,
                              style: textTheme.headlineMedium?.copyWith(
                                  color: const Color(0xFF444550),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                alignment: Alignment.center,
                height: 50.sp,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFB40205),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Done',
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Image(
                  image: const AssetImage(AppIcon.theMoversLogo), width: 100.w),
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
            ],
          ),
        ));
  }
}
